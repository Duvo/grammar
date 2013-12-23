import 'package:unittest/unittest.dart';
import 'package:grammar/grammar.dart';

main() { 
  group('Instance', () {
    var grammar = new Grammar();
    grammar.rules['Pierre'] = new Rule.parse('SN');
    grammar.rules['aime'] = new Rule.parse(r'(SN\S)/SN');
    grammar.rules['beaucoup'] = new Rule.parse(r'(SN\S)\(SN\S)');
    grammar.rules['les'] = new Rule.parse('SN/N');
    grammar.rules['cacahouètes'] = new Rule.parse('N');
    
    test('derivable',() {
      var derivation = grammar.derivate('Pierre aime les cacahouètes');
      expect(derivation, isNotNull);
      print(derivation);
    });
    
    test('not derivable',() {
      expect(grammar.derivate('Pierre aime beaucoup les cacahouètes'), isNull);
    });
  });
  
  group('Class', () {
    test('slash rule OK',() {
      expect(Grammar.useSlashRule(
          new Rule.parse('SN/N'), new Rule.parse('N')).value,
          'SN');
    });
    test('slash rule not OK',() {
      expect(Grammar.useSlashRule(
          new Rule.parse('SN'), new Rule.parse('N')),
          isNull);
    });
    test('backslash rule OK',() {
      expect(Grammar.useBackslashRule(
          new Rule.parse('SN'), new Rule.parse(r'SN\S')).value,
          'S');
    });
    test('backslash rule not OK',() {
      expect(Grammar.useBackslashRule(
          new Rule.parse('SN'), new Rule.parse('SN')),
          isNull);
    });
  });
  
}