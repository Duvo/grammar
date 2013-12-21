import 'package:unittest/unittest.dart';
import 'package:grammar/grammar.dart';

main() {
  group('Parsing', () {
    // Basique
    test('basic simple rule', () {
      var rule = new Rule.parse('SN');
      expect(rule.value, 'SN');
      expect(rule, new isInstanceOf<SimpleRule>('SimpleRule'));      
    });
    test('basic meta rule', () {
      var rule = new Rule.parse('SN/V');
      expect(new Rule.parse('SN/V').value, 'SN/V');
      expect(rule, new isInstanceOf<MetaRule>('MetaRule'));
      var metaRule = (rule as MetaRule);
      expect(metaRule.left, 'SN');
      expect(metaRule.right, 'SV');
      expect(metaRule.isSlash, isTrue);      
    });
    
    // Nettoyage de la chaîne
    test('simple rule with spaces', () {
      expect(new Rule.parse('   S     N ').value, 'SN');
    });
    test('meta rule with spaces', () {
      expect(new Rule.parse('   S  N      /    V    ').value, 'SN/V');
    });
    test('meta rule with specials characters', () {
      expect(new Rule.parse(r'   SN2/ (V \ Diff$) *!é').value, r'SN2/(V\Diff)');
    });
    
    // Vérification des parenthèses
    test('incoherent parenthesis', () {
      expect(() => new Rule.parse('(SN/SV))'), throws);
    });
    
  });
  
}