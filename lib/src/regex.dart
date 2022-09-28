// import 'dart:io';

import 'request.dart';
import 'routing.dart';

class MatchInfo {
  late int error;
  Router? router;
  Route? route;
  MatchInfo() : error = 0;
}

class Re {
  static final RegExp string = RegExp(r'\w+');
  static final RegExp digit = RegExp(r'\d+');
  static final RegExp strVar = RegExp(r'{\w+(:str)?}');
  static final RegExp intVar = RegExp(r'{\w+:int}');
  static final RegExp isVar = RegExp(r'{\w+(:(int|str))?}');
  // TODO: add 'pathVar'

  static RegExp parseUrlRegex(String url) {
    url = url.replaceAll(strVar, r'\w+');
    url = url.replaceAll(intVar, r'\d+');
    return RegExp(r'^' + url + r'$');
  }

  // TODO:
  static Map<String, dynamic> parseUriValues(String path, String rule) {
    var args = <String, dynamic>{};
    var ruleList = rule.split('/');
    var pathList = path.split('/');

    for (var i = 0; i < ruleList.length; i++) {
      var str = ruleList[i];
      if (!Re.isVar.hasMatch(str)) {
        continue;
      } else {
        var t = Re.intVar.hasMatch(str);
        str = str.substring(1, str.length - 1);
        if (str.contains(":")) str = str.split(":")[0];
        if (t) {
          args[str] = int.parse(pathList[i]);
        } else {
          args[str] = pathList[i];
        }
      }
    }
    return args;
  }
}
