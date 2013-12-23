import 'package:grammar/grammar.dart';


/**
 * Question 1 : Trouver une dérivation de la phrase "Pierre aime les
 * cacahouètes".
 */
main() {
  var grammar = new Grammar();
  grammar.rules['Pierre'] = new Rule.parse('SN');
  grammar.rules['aime'] = new Rule.parse(r'(SN\S)/SN');
  grammar.rules['beaucoup'] = new Rule.parse(r'(SN\S)\(SN\S)');
  grammar.rules['les'] = new Rule.parse('SN/N');
  grammar.rules['cacahouètes'] = new Rule.parse('N');
  
  grammar.derivate('Pierre aime les cacahouètes').first.then((derivation) {
    print(derivation);
  });
}