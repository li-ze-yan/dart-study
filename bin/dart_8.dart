void main() async {
  // dynamic 动态类型
  var a = 100;
  dynamic b = 100;
  print(a);
  print(b);

  dynamic c = 10;
  print(c is int);
  c = "hello";
  print(c is String);
  print(c?.length);
  c = 10.5;
  print(c is double);
  print(c is! double);
  print(c is num);
  print(c is! num);
  print(c is! String);
  print(c is! int);

  dynamic fn1(dynamic a, dynamic b) {
    return a + b;
  }

  print(fn1(1, 2));
  print(fn1('hello', 'world'));
  // print(fn1(1, 'world'));

  var e = await getData();
  print(e);
}

// 异步方法，一定返回一个Future对象，但是如果不设置返回类型，编译器也会识别成 Dynamic
Future<String> getData() async {
  sleep(Duration(seconds: 10));
  return 'hello world';
}

void sleep(Duration duration) {
  print('sleep');
}
