import 'dart:io';

import 'regex.dart';
import 'request.dart';

typedef handler = Object Function(Request);

Map<String, Route> mapRules = {};

class Route {
  late final RegExp _ruleRegex;

  final String rule;
  final String endpoint;
  List<String> methods;
  final handler func;

  Route({
    required this.rule,
    required this.endpoint,
    required this.methods,
    required this.func,
  });

  bool match(HttpRequest req) => _ruleRegex.hasMatch(req.uri.path);
}

class Router {
  final String name;
  String? urlPrefix;
  final String? subdomain;
  List<Route> routes;
  Router(
    this.name, {
    this.urlPrefix,
    this.subdomain,
  }) : routes = [];

  bool match(HttpRequest req, MatchInfo mf) {
    var mna = false;
    for (var route in routes) {
      if (route._ruleRegex.hasMatch(req.uri.path)) {
        if (route.methods.contains(req.method)) {
          mf.router = this;
          mf.route = route;
          mf.error = 0;
          return true;
        } else {
          mna = true;
        }
      } else {
        mf.error = 404;
      }
    }
    if (mna && mf.error == 404) mf.error = 405;
    return false;
  }

  void addRoute(Route r) {
    routes.forEach((route) {
      if (route.endpoint == r.endpoint) {
        throw Exception('Route Name already registered');
      }
    });

    r._ruleRegex = Re.parseUrlRegex(r.rule);
    mapRules['${name}.${r.endpoint}'] = r;
    routes.add(r);
  }

  void delete(String rule, String endpoint, handler func) {
    addRoute(
        Route(rule: rule, endpoint: endpoint, methods: ['DElETE'], func: func));
  }

  void get(String rule, String endpoint, handler func) {
    addRoute(
        Route(rule: rule, endpoint: endpoint, methods: ['GET'], func: func));
  }

  void head(String rule, String endpoint, handler func) {
    addRoute(
        Route(rule: rule, endpoint: endpoint, methods: ['HEAD'], func: func));
  }

  void patch(String rule, String endpoint, handler func) {
    addRoute(
        Route(rule: rule, endpoint: endpoint, methods: ['PATCH'], func: func));
  }

  void post(String rule, String endpoint, handler func) {
    addRoute(
        Route(rule: rule, endpoint: endpoint, methods: ['POST'], func: func));
  }

  void put(String rule, String endpoint, handler func) {
    addRoute(
        Route(rule: rule, endpoint: endpoint, methods: ['PUT'], func: func));
  }

  void trace(String rule, String endpoint, handler func) {
    addRoute(
        Route(rule: rule, endpoint: endpoint, methods: ['TRACE'], func: func));
  }
}
