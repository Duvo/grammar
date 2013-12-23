part of grammar;

/**
 * Nettoie une chaîne en ne conservant que les caractères suivants :
 *  - a-z et A-Z
 *  - les chiffres
 *  - les caractères de règles / et \
 *  - les parenthèses
 */
String stringCleaning(String string) {
  return string.replaceAll(new RegExp(r'[^\d\w/\\()]+'), '');
}

/**
 * Vérifie si la règle est bien formée.
 */
checkRule(dynamic rule) {
  if (rule is String) {
    checkTerme(rule);
  }
}

/**
 * Vérifie si le terme est bien formé. Seulement des lettres ou des chiffres.
 */
checkTerme(String terme) {
  var regex = new RegExp(r'[^\d\w]+');
  if (regex.hasMatch(terme)) {
    throw 'Règle mal écrite. ${terme} n\'est pas un terme simple.';
  }
}

/**
 * Vérifie que l'opérateur est correct.
 */
checkOperator(dynamic operator) {
  if (operator is String) {
  var regex = new RegExp(r'[^/\\]+');
  if (regex.hasMatch(operator)) {
    throw 'Règle mal écrite. ${operator} n\'est pas un opérateur / ou \\.';
  }
  } else {
    throw 'Règle mal écrite. La partie centrale d\'une règle doit être un opérateur / ou \\.';
  }
}

/**
 * Permet de parser une chaîne parenthèsée dans une structure en listes. Les
 * parenthèse inutiles sont retirées. Exemple :
 *  La chaine ((SN)/V)\SN va donner la structure [['SN', '\', 'V'],'\','SN'].
 */
List parseParenthesis(String string) {
  var clean = stringCleaning(string);
  var count = 0;
  var list = [];
  var current = '';
  var chars = clean.split('');
  
  for(var char in chars) {
    switch (char) {
      case '(':
        if (count > 0) {
          current += char;
        }
        count++;
        break;
        
      case ')':          
        count--;
        if (count > 0) {
          current += char;
        } else {
          var subList = parseParenthesis(current);
          if (subList.length > 1) {
            list.add(subList);
          } else if (subList.length == 1) {
            list.add(subList.first);
          }
          current = '';
        }       
        break;
        
      case '/':
      case r'\':
        if (count > 0) {
          current += char;
        } else {
          if (current.isNotEmpty) {
            list.add(current);
            current = '';
          }
          list.add(char);
        }        
        break;
        
      default:
        current += char;
    }
  }
  if (current.isNotEmpty) {
    list.add(current);
  }
  if (count > 0) {
    throw 'Incohérence de parenthésage. ${count} parenthèses ouvrantes en trop.';
  } else if (count < 0) {
    throw 'Incohérence de parenthésage. ${-count} parenthèses fermantes en trop.';
  }
  return list;
}