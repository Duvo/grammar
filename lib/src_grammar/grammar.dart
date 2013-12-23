part of grammar;

class Grammar {
  Map<String, Rule> rules = {};
  
  Derivation derivate(String text) {
    var derivation = new Derivation.parse(text, this);
    if (derivation.findFirst()) {
      return derivation;
    } else {
      return null;
    }
  }
  
  static Rule useSlashRule(Rule left, Rule right) {
    if (left is MetaRule && left.isSlash && left.right == right) {
      return left.left;
    } else {
      return null;
    }
  }
  
  static Rule useBackslashRule(Rule left, Rule right) {
    if (right is MetaRule && !right.isSlash && right.left == left) {
      return right.right;
    } else {
      return null;
    }
  }
}