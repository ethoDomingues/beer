import 'dart:io';

import 'regex.dart';

class Request {
  late Map<String, dynamic> args;
  MatchInfo matchInfo;
  HttpRequest req;
  Request(this.req, this.matchInfo) {
    args = Re.parseUriValues(req.uri.path, matchInfo.route!.rule);
  }
}
