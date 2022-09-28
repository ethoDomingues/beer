import 'dart:io';

void abort(int code) {
  throw HttpAbort(code, '');
}

class HttpAbort implements Exception {
  int code;
  String body;
  HttpAbort(this.code, this.body);

  void closeResponse(HttpRequest req) {
    req.response.statusCode = code;
    req.response.write(body);
    req.response.close();
  }
}

class Unauthorized extends HttpAbort {
  Unauthorized() : super(401, '401 Unauthorized');
}

class NotFound extends HttpAbort {
  NotFound() : super(404, '404 Not Found');
}

class MethodNotAllowed extends HttpAbort {
  MethodNotAllowed() : super(405, '405 Method Not Allowed');
}

class InternalServerError extends HttpAbort {
  InternalServerError() : super(500, '500 Internal Server Error');
}
