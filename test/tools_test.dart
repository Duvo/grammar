import 'package:unittest/unittest.dart';
import 'package:grammar/grammar.dart';

main() {
  group('Parsing parenthesis', () {
    test('incoherent', () {
      expect(() => parseParenthesis('(()))'), throws);
    });
    
    test('basic', () {
      expect(parseParenthesis('(a/b)/c'), [['a','/','b'],'/','c']);
    });
    
    test('with specials characters', () {
      expect(parseParenthesis(r'*$  ù( a "/b, )/.c'), [['a','/','b'],'/','c']);
    });
    
    test('with parenthesis cleaning', () {
      expect(parseParenthesis('((a/b))(/)(c)()'), [['a','/','b'],'/','c']);
    });
  });
}