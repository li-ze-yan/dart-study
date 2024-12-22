void main() {
  // 箭头函数
  final a = fn1(1, 2);
  print(a);
}

int Function(int a, int b) fn1 = (a, b) => a + b;
