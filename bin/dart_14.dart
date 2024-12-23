void main() {
  var a = 1;

  // 后置操作
  print('=====');
  print(a++);
  print(a);
  print(a--);
  print(a);
  print('=====');

  // 前置操作
  var b = 1;
  print('=====');
  print(++b);
  print(b);
  print(--b);
  print(b);
  print('=====');

  // 加等 减等 乘等 除等 取模等
  double c = 1;
  print('=====');
  print(c += 1);
  print(c);
  print(c -= 1);
  print(c);
  print(c *= 1);
  print(c);
  print((c /= 1).toDouble());
  print(c);
  print(c %= 1);
  print(c);
  print('=====');
}
