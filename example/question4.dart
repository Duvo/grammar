import 'package:grammar/grammar.dart';


/**
 * Question 4 : Peut-on analyser la phrase (incorrecte) "Pierre aime les
 * cacahouètes beaucoup" avec ce lexique ?
 */
main() {
  var grammar = new Grammar();
  grammar.rules['Pierre'] = new Rule.parse('SN');
  grammar.rules['aime'] = new Rule.parse(r'(SN\S)/SN');
  grammar.rules['beaucoup'] = new Rule.parse(r'(SN\S)\(SN\S)');
  grammar.rules['les'] = new Rule.parse('SN/N');
  grammar.rules['cacahouètes'] = new Rule.parse('N');
  
  grammar.derivate('Pierre aime les cacahouètes beaucoup').first.then((derivation) {
    print(derivation);
  });
}