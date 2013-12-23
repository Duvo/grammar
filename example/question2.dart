import 'package:grammar/grammar.dart';

/**
 * Question 2 : Pourquoi ne peut-on pas trouver une dérivation de "Pierre aime
 * beaucoup les cacahouètes" ?
 */
main() {
  var grammar = new Grammar();
  grammar.rules['Pierre'] = new Rule.parse('SN');
  grammar.rules['aime'] = new Rule.parse(r'(SN\S)/SN');
  grammar.rules['beaucoup'] = new Rule.parse(r'(SN\S)\(SN\S)');
  grammar.rules['les'] = new Rule.parse('SN/N');
  grammar.rules['cacahouètes'] = new Rule.parse('N');
  
  grammar.derivate('Pierre aime beaucoup les cacahouètes').isEmpty.then((isEmpty) {
    print(isEmpty ? 'Aucune dérivation trouvée.' : 'Problème, une dérivation a été trouvée.');
  });
}