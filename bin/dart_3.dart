void main() {
  int a = 100;
  double f1 = 100.1;
  // int b = 100.1 error
  print('a:$a f1:$f1');

  String str = 'hello';
  String str2 = 'world';
  print('$str $str2');

  String str3 = '张三';
  String str4 = '张三';
  print(str3 == str4);

  String str5 = '''
hello
world
!
  ''';
  print(str5);

  String str6 = 'hello\nworld\n!';
  print(str6);
  print(str5 == str6);
}
