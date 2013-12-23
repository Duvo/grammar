part of grammar;

/**
 * Permet de créer une grammaire catégorielle puis de rechercher les dérivations
 * liée à une phrase selon les règles (A/B B -> A) et (B B\A -> A).
 */
class Grammar {
  /// Les règles de la grammaires.
  Map<String, Rule> rules = {};
  
  /**
   * Lance la recherche des différentes dérivations possible. Retourne un stream
   * qui récupère les différentes dérivations.
   */
  Stream<Derivation> derivate(String text) {
    var controller = new StreamController<Derivation>();
    var derivation = new Derivation.parse(text, this);
    new Future(() {
      derivation.findAll(controller);
    });    
    return controller.stream;
  }
  
  /**
   * Essaye d'appliquer la règle (A/B B -> A) sur 2 termes. Retourne le
   * nouveau terme obtenu ou nul si la règle n'est pas applicable.
   */
  static Rule useSlashRule(Rule left, Rule right) {
    if (left is MetaRule && left.isSlash && left.right == right) {
      return left.left;
    } else {
      return null;
    }
  }
  
  /**
   * Essaye d'appliquer la règle (B B\A -> A) sur 2 termes. Retourne le
   * nouveau terme obtenu ou nul si la règle n'est pas applicable.
   */
  static Rule useBackslashRule(Rule left, Rule right) {
    if (right is MetaRule && !right.isSlash && right.left == left) {
      return right.right;
    } else {
      return null;
    }
  }
}