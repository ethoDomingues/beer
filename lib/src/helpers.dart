import 'regex.dart';
import 'routing.dart';

// TODO: add ?args=restante
// TODO: add http schema if external is true
String urlFor(String ruleName, Map<String, dynamic> args,
    [bool external = false]) {
  var strBuff = StringBuffer();
  var route = mapRules[ruleName];
  if (route == null) throw Exception("Route '$ruleName' not exists!");

  var listRuleStr = route.rule.split("/");
  for (var i = 0; i < listRuleStr.length; i++) {
    var str = listRuleStr[i];
    if (str == '') continue;
    if (Re.isVar.hasMatch(str)) {
      str = str.substring(1, str.length - 1);
      if (str.contains(":")) str = str.split(":")[0];
      strBuff.write('/${args[str]}');
    } else {
      strBuff.write('/$str');
    }
  }
  return strBuff.toString();
}
