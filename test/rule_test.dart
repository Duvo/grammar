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
      expect(rule.value, 'SN/V');
      expect(rule, new isInstanceOf<MetaRule>('MetaRule'));
      var metaRule = (rule as MetaRule);
      expect(metaRule.left.value, 'SN');
      expect(metaRule.right.value, 'V');
      expect(metaRule.isSlash, isTrue);      
    });
    test('complexe meta rule', () {
      var rule = new Rule.parse(r'((SN/(V/SN))\(V\V))');
      expect(rule.value, r'(SN/(V/SN))\(V\V)');
      expect(rule, new isInstanceOf<MetaRule>('MetaRule'));
      var metaRule = (rule as MetaRule);
      expect(metaRule.left.value, r'SN/(V/SN)');
      expect(metaRule.right.value, r'V\V');
      expect(metaRule.isSlash, isFalse);      
    });
    
    // Nettoyage de la chaîne
    test('too many parenthesis', () {
      expect(new Rule.parse('(SN)').value, 'SN');
    });
    test('simple rule with spaces', () {
      expect(new Rule.parse('   S     N ').value, 'SN');
    });
    test('meta rule with spaces', () {
      expect(new Rule.parse('   S  N      /    V    ').value, 'SN/V');
    });
    test('meta rule with specials characters', () {
      expect(new Rule.parse(r'   SN2/ (V \ Diff$) *!é').value, r'SN2/(V\Diff)');
    });
    
    // Vérification règles mal formées
    test('incoherent parenthesis', () {
      expect(() => new Rule.parse('(SN/SV))'), throws);
    });
    test('too many operator', () {
      expect(() => new Rule.parse('(SN//SV)'), throws);
    });
    test('wrong arguments', () {
      expect(() => new Rule.parse('/SV'), throws);
      expect(() => new Rule.parse('/'), throws);
    });
    test('empty', () {
      expect(() => new Rule.parse(''), throws);
      expect(() => new Rule.parse('   '), throws);
    });
  });
  
  group('Comparison', () {
    var rule1 = new Rule.parse(r'(SN/V)\SN');
    var rule1bis = new Rule.parse(r'(SN/V)\SN');
    var rule2 = new Rule.parse(r'(SN\V)\SN');
    var rule3 = new Rule.parse('SN/V');
    test('equals', () {
      expect(rule1 == rule1bis, isTrue);
      expect((rule1 as MetaRule).left == rule3, isTrue);
    });
    test('not equals', () {
      expect(rule1 != rule2, isTrue);
    });
  });
  
}