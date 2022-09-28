import 'dart:io';

import 'exceptions.dart';
import 'regex.dart';
import 'request.dart';

import 'routing.dart';

class App extends Router {
  final List<Router> routers;
  App({
    super.urlPrefix,
    super.subdomain,
    this.routers = const [],
  }) : super('');

  void run([String? addr, int? port]) async {
    HttpServer.bind(addr ?? "0.0.0.0", port ?? 5000).then((HttpServer srv) {
      print("${DateTime.now()} - "
          "Server is listen in '${srv.address.address}:${srv.port}'");
      srv.forEach((HttpRequest req) {
        var mf = MatchInfo();
        if (!match(req, mf)) {
          switch (mf.error) {
            case 404:
              NotFound().closeResponse(req);
              break;
            case 405:
              MethodNotAllowed().closeResponse(req);
              break;
          }
        } else {
          try {
            var route = mf.route!;
            var rq = Request(req, mf);
            var resp = route.func(rq);
            req.response.write(resp);
            req.response.close();
          } catch (e) {
            print(e);
            InternalServerError().closeResponse(req);
          }
        }
        print(
          "${DateTime.now()} - "
          "${req.method} ${req.uri.path}",
        );
      });
    });
  }
}
