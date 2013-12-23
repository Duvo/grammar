part of grammar;

abstract class Rule {
  String get value;
  
  factory Rule.parse(String string) {
    var structure = parseParenthesis(string);
    return new Rule.parseStructure(structure);
  }
  
  factory Rule.parseStructure(dynamic rule) {
    if (rule is String) {
      checkTerme(rule);
      return new SimpleRule(rule);
    } else if (rule is List) {
      switch (rule.length) {
        case 1:
          checkRule(rule.first);
          return new Rule.parseStructure(rule.first);
          break;
        case 3:
          checkRule(rule[0]);
          checkOperator(rule[1]);
          checkRule(rule[2]);
          return new MetaRule(new Rule.parseStructure(rule[0]),
              new Rule.parseStructure(rule[2]),
              rule[1] == '/');
          break;
        default:
          throw 'Règle mal écrite. Nombre incorrect d\'arguments dans une partie de la règle.';
      }
    }    
  }
}

class SimpleRule implements Rule {
  String _value;
  String get value => _value;
  
  SimpleRule(this._value);
  
  @override
  int get hashCode {
    return 37 * 17 + _value.hashCode;
  }

  @override
  bool operator==(other) {
    if (other is SimpleRule) {
      return other.value == value;
    } else {
      return false;
    }    
  }
  
  @override
  String toString() => value;
}

class MetaRule implements Rule {  
  Rule left;
  Rule right;
  bool isSlash;
  
  String get value {
    var ret = left is SimpleRule ? left.value : ('(' + left.value + ')');
    ret +=isSlash ? '/' : r'\';
    ret += right is SimpleRule ? right.value : ('(' + right.value + ')');
    return ret;
  }
  
  MetaRule(this.left, this.right, this.isSlash);
  
  @override
  int get hashCode {
    var result = 17;
    result = 37 * result + left.hashCode;
    result = 37 * result + right.hashCode;
    return 37 * result + isSlash.hashCode;
  }

  @override
  bool operator==(other) {
    if (other is MetaRule) {
      return other.isSlash == isSlash && other.left == left && other.right == right;
    } else {
      return false;
    }    
  }
  
  @override
  String toString() => value;
}