part of grammar;

String stringCleaning(String string) {
  return string.replaceAll(new RegExp(r'[^\d\w/\\()]+'), '');
}

List parseParenthesis(String string) {
  var clean = stringCleaning(string);
  var count = 0;
  var list = [];
  var current = '';
  var split = clean.split('');
  
  for(var char in split) {
    switch (char) {
      case '(':
        if (count > 0) {
          current += '(';
        }
        count++;
        break;
        
      case ')':          
        count--;
        if (count > 0) {
          current += ')';
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
        if (count > 0) {
          current += '/';
        } else {
          if (current.isNotEmpty) {
            list.add(current);
            current = '';
          }
          list.add('/');
        }
        
        break;
        
      case r'\':
        if (count > 0) {
          current += r'\';
        } else {
          if (current.isNotEmpty) {
            list.add(current);
            current = '';
          }
          list.add(r'\');
        }
        break;
        
      default:
        current += char;
    }
  }
  if (current.isNotEmpty) {
    list.add(current);
  }
  if (count != 0) {
    throw 'Bad parenthesis.';
  }
  return list;
}