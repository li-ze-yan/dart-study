void main() {
// 运算符
  print(5 + 2); // 7
  print(5 - 2); // 3
  print(5 * 2); // 10
  print(5 / 2); // 2.5    ← 注意：永远是 double
  print(5 ~/ 2); // 2      ← 整除（向下取整）
  print(5 % 2); // 1

  // 比较 & 等于
  print(1 == 1); // true
  print('a' == 'a'); // true（Dart 的 == 默认对内置类型按值比较）
  print([1] == [1]); // false（List 没重写 ==，按引用比较）

// 没有 ===，要"严格相等（同一对象）"用 identical
  print(identical([1], [1])); // false

  // 逻辑 & 短路
  final a = true, b = false;
  print(a && b); // false
  // print(a || b); // true
  print(!a); // false
}
