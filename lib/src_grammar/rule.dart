part of grammar;

abstract class Rule {
  String get value;
  
  factory Rule.parse(String string) {
    var structure = parseParenthesis(string);    
    
    return new SimpleRule(stringCleaning(string));
  }
}

class SimpleRule implements Rule {
  String _value;
  String get value => _value;
  
  SimpleRule(this._value);
}

class MetaRule implements Rule {  
  Rule left;
  Rule right;
  bool isSlash;
  String get value {
    return left.value + (isSlash ? '/' : r'\') + right.value;
  }
  
  MetaRule(this.left, this.right, this.isSlash);
}