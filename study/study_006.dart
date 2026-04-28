// 类型转换
void main() {
  // String -> int / double
  int age = int.parse('18');
  double price = double.parse('19.9');

  print(age);
  print(price);

  // 安全解析 解析失败给默认值
  final port = int.tryParse('abc') ?? 8080;
  print(port);

  // 数字 -> String
  final s = 42.toString();
  final s2 = (3.14159).toStringAsFixed(2);

  // int -> double
  final a = 1.toDouble();
  final b = 3.7.toInt();
  final c = 3.7.round();
}
