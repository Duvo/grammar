part of grammar;

class Derivation {
  Grammar grammar;
  List<String> text = [];
  List<Step> steps = [];
  
  Derivation.parse(String text, this.grammar) {    
    var phrase = [];
    var split = text.split(' ');
    for(var word in split) {
      word = word.trim();
      if (word.isNotEmpty) {
        if (grammar.rules.containsKey(word)) {
          this.text.add(word);
          phrase.add(grammar.rules[word]);
        } else {
          throw 'Le mot ${word} est inconnu dans la grammaire.';
        }
      }
    }
    steps.add(new Step.initial(phrase));
  }
  
  bool findFirst() {
    var step = steps.last; 
    while(step != null && step.phrase.length > 1) {
      step = _firstNextStep(step);
      steps.add(step);
    }
    return step != null;
  }
  
  static Step _firstNextStep(Step current) {
    for (var i=0; i<current.phrase.length-1; i++) {
      var left = current.phrase[i];
      var right = current.phrase[i+1];
      
      var test = Grammar.useSlashRule(left, right);
      if (test != null) {
        var phrase = current.phrase.sublist(0, i);
        phrase.add(test);
        phrase.addAll(current.phrase.sublist(i+2, current.phrase.length));
        return new Step(phrase, true, i);
      }
      
      test = Grammar.useBackslashRule(left, right);
      if (test != null) {
        var phrase = current.phrase.sublist(0, i);
        phrase.add(test);
        phrase.addAll(current.phrase.sublist(i+2, current.phrase.length));
        return new Step(phrase, false, i);
      }     
    }
    return null;
  }
  
  @override
  String toString() {
    return text.toString() + steps.toString();
  }
}

class Step {
  bool slashUsed;
  int leftId;
  List<Rule> phrase;
  
  Step(this.phrase, this.slashUsed, this.leftId);
  Step.initial(this.phrase): slashUsed = null, leftId = null;
  
  @override
  String toString() {
    var result = phrase.toString();
    if (slashUsed is bool) {
      result += ' ' + leftId.toString() + (slashUsed ? ' / '  : r' \ ') + (leftId+1).toString();
    } else {
      result += ' INITIAL';
    }
    return result;
  }
}