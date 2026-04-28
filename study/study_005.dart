// 内置基础类型
void main() {
  // 数字
  int n = 42;
  double d = 3.14;
  num x = 1;
  x = 1.5;

  // 字符串
  String s = 'Hello';
  String t = "World";
  String u = '''
    多行字符串
  ''';

  // 插值表达式
  int count = 3;
  print('一共有 $count 个');
  print('总价 ${count * 19.9} 元');

  // 布尔值
  bool isTrue = true;
  bool isFalse = false;

  // 类型转换
  int a = 1;
  double b = a.toDouble();
  String c = a.toString();
  int f = int.parse('123');
  double g = double.parse('3.14');

  // Null 字面量类型是Null
  Null nothing;
}
