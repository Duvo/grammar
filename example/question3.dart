import 'package:grammar/grammar.dart';

/**
 * Question 3 : Quelle catégorie pourrait-on ajouter à un mot du lexique pour
 * que l'on pusse analyser les phrases "Pierre aime beaucoup les cacahouètes" et
 * "Pierre aime beaucoup beaucoup les cacahouètes" ?
 */
main() {
  var grammar = new Grammar();
  grammar.rules['Pierre'] = new Rule.parse('SN');
  grammar.rules['aime'] = new Rule.parse(r'(SN\S)/SN');
  // Règle de beaucoup modifié
  grammar.rules['beaucoup'] = new Rule.parse(r'((SN\S)/SN)\((SN\S)/SN)');
  grammar.rules['les'] = new Rule.parse('SN/N');
  grammar.rules['cacahouètes'] = new Rule.parse('N');
  
  grammar.derivate('Pierre aime beaucoup les cacahouètes').listen((derivation) {
    print(derivation);
  });
  grammar.derivate('Pierre aime beaucoup beaucoup les cacahouètes').listen((derivation) {
    print(derivation);
  });
}