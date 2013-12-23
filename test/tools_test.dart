import 'package:unittest/unittest.dart';
import 'package:grammar/grammar.dart';

main() {
  group('Parsing parenthesis', () {
    test('incoherent', () {
      expect(() => parseParenthesis('(()))'), throws);
    });
    
    test('basic', () {
      expect(parseParenthesis('(a/b)/c'), [['a','/','b'],'/','c']);
      expect(parseParenthesis('SN'), ['SN']);
    });
    
    test('with specials characters', () {
      expect(parseParenthesis(r'*$  ù( a "/b, )/.c'), [['a','/','b'],'/','c']);
    });
    
    test('with parenthesis cleaning', () {
      expect(parseParenthesis('((a/b))(/)(c)()'), [['a','/','b'],'/','c']);
    });
    
    test('with multiples slashs', () {
      expect(parseParenthesis(r'((a//b))(/\)(c\d)()'),
          [['a','/','/','b'],['/',r'\'],['c',r'\','d']]);
    });
  });
}