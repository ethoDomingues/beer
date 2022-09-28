
# Beer
A Dart Web Framework

## A Simple Example

```dart
import 'package:beer/beer.dart';

void main() {
  var app = App();
  app.get('/hello/{user}', 'user', (req) => "Salve, ${req.args['user']}!");
  app.get('/sum/{num1:int}/{num2:int}', 'number', (req) {
    int num1 = req.args['num1'];
    int num2 = req.args['num2'];
    return "Sum: ${num1 + num2}";
  });

  app.run();
  // app.run('::1', 5000); -> also works
  // app.run('0.0.0.0', 5000); -> also works
}
```
