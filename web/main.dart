import 'dart:html';
import 'package:grammar/grammar.dart';

void main() {
  querySelector('#phrase').value = 'Pierre aime les cacahouètes';
  querySelector('#grammar').value = r'''Pierre: SN
aime: (SN\S)/SN
beaucoup: (SN\S)\(SN\S)
les: SN/N
cacahouètes: N''';
  
  querySelector('#derivate').onClick.listen((_) {
    try {
      querySelector('#console').value = '';
      (querySelector('#derivate') as ButtonElement).disabled = true;
      var result = querySelector('#result');
      result.innerHtml = '';
      var grammar = new Grammar();
      var rules = querySelector('#grammar').value.trim();
      var split = rules.split('\n');
      split.forEach((line) {
        line = line.trim();
        if (line.isNotEmpty) {
          var index = line.indexOf(':');
          if (index != -1) {
            var word = line.substring(0, index).trim();
            var rule = line.substring(index+1).trim();
            var temp = new Rule.parse(rule);
            print(temp);
            grammar.rules[word] = temp;
          }
        }
      });
      var phrase = querySelector('#phrase').value.trim();
      grammar.derivate(phrase).listen((derivation) {
        result.appendHtml(derivationToHtml(derivation));
      }, onDone: () {
        (querySelector('#derivate') as ButtonElement).disabled = false;
      });
    } catch (e) {
      querySelector('#console').value = e.toString();
      (querySelector('#derivate') as ButtonElement).disabled = false;
    }
  });  
}

String derivationToHtml(Derivation derivation) {
  var result = '<div class="derivation"><p class="phrase">' + derivation.text.join(' ') + '</p>';
  var i;
  for (i=1; i<derivation.steps.length; i++) {
    result += stepToHtml(derivation.steps[i-1], derivation.steps[i]);
  }
  result += finalStepToHtml(derivation.steps[i-1]);
  return result + '</div>';
}

String finalStepToHtml(Step step) {
  var result = '<p class="step">';
  var list = [];
  for (var i=0; i<step.phrase.length; i++) {
    list.add('<span>' + step.phrase[i].value + '</span>');
  }
  result += list.join(' ');
  return result;
}

String stepToHtml(Step step, Step nextStep) {
  var result = '<p class="step">';
  var list = [];
  for (var i=0; i<step.phrase.length; i++) {
    if (i == nextStep.leftId) {
      list.add('<span class="left">' + step.phrase[i].value + '</span>');
    } else if (i == nextStep.leftId+1) {
      list.add('<span class="right">' + step.phrase[i].value + '</span>');
    } else {
      list.add('<span>' + step.phrase[i].value + '</span>');
    }
  }
  result += list.join(' ');
  return result + ' - - <span>' + (nextStep.slashUsed ? 'A/B B -> A' : r'B B\A -> A') + '</span>';
}