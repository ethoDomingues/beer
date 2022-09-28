import 'package:beer/beer.dart';

void main() {
  var app = App();
  app.get(
    '/hello/{user}', // url
    'user', // name of endpoint
    (req) => "Salve, ${req.args['user']}!", // handler function
  );

  app.run();
  // app.run('::1', 5000); -> also works
  // app.run('0.0.0.0', 5000); -> also works
}
