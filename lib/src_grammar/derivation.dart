part of grammar;

/**
 * Permet de stocker une dérivation en cours ainsi que d'effectuer les 
 * recherches de nouvelles dérivations.
 */
class Derivation {
  /// La liste des mots de la phrase que l'on dérive.
  List<String> text = [];
  
  /// Les différentes étapes de la dérivation.
  List<Step> steps = [];
  
  /**
   * Constructeur de copie.
   */
  Derivation.clone(Derivation original):
    text = original.text,
    steps = new List.from(original.steps);
  
  /**
   * Constructeur permettant de récupérer la phrase ainsi que la première
   * étape de dérivation correspondante à la grammaire.
   */
  Derivation.parse(String text, Grammar grammar) {    
    var phrase = [];
    var split = text.split(' ');
    for(var word in split) {
      word = word.trim();
      if (word.isNotEmpty) {
        if (grammar.rules.containsKey(word)) {
          this.text.add(word);
          phrase.add(grammar.rules[word]);
        } else {
          throw 'Le mot ${word} est inconnu dans la grammaire.';
        }
      }
    }
    steps.add(new Step.initial(phrase));
  }
  
  /**
   * Lance la recherche des dérivations. Chaque dérivation trouvée est
   * envoyée au stream.
   */
  findAll(StreamController controller) {
    _findAll(controller);
    controller.close();
  }
  
  _findAll(StreamController controller) {
    var step = steps.last;
    for (var i=0; i<step.phrase.length-1; i++) {
      var left = step.phrase[i];
      var right = step.phrase[i+1];
      
      var test = Grammar.useSlashRule(left, right);
      var isSlash = true;
      if (test == null) {
        test = Grammar.useBackslashRule(left, right);
        isSlash = false;
      }
      if (test != null) {
        var phrase = step.phrase.sublist(0, i);
        phrase.add(test);
        phrase.addAll(step.phrase.sublist(i+2, step.phrase.length));
        var nextStep = new Step(phrase, isSlash, i);
        var newDerivation = new Derivation.clone(this)
        ..steps.add(nextStep);
        if (nextStep.phrase.length > 1) {
          newDerivation._findAll(controller);
        } else {
          controller.add(newDerivation);          
        }        
      }    
    }
  }
  
  @override
  String toString() {
    return text.toString() + '\n' + steps.toString();
  }
}

/**
 * Permet de stocker une étape de dérivation.
 */
class Step {
  /// Identifie la règle utilisée lors de l'étape précédente (/ ou \).
  bool slashUsed;
  /// L'index de la partie gauche de la transformation qui a été appliquée.
  int leftId;
  /// Les termes de cette étape.
  List<Rule> phrase;
  
  /**
   * Constructeur de base.
   */
  Step(this.phrase, this.slashUsed, this.leftId);
  
  /**
   * Constructeur pour créer l'étape initiale directement déduite de la
   * grammaire.
   */
  Step.initial(this.phrase): slashUsed = null, leftId = null;
  
  @override
  String toString() {
    var result = phrase.toString();
    if (slashUsed is bool) {
      result += ' ' + leftId.toString() + (slashUsed ? ' / '  : r' \ ') + (leftId+1).toString();
    } else {
      result += ' INITIAL';
    }
    return result + '\n';
  }
}