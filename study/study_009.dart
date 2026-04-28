void main() {
  // 经典 for
  for (var i = 0; i < 3; i++) {
    print(i);
  }

// for-in（遍历可迭代对象，相当于 JS 的 for...of）
  for (final fruit in ['apple', 'banana', 'orange']) {
    print(fruit);
  }

// 拿到下标？两种写法
  final list = ['a', 'b', 'c'];
  for (var i = 0; i < list.length; i++) {
    print('$i: ${list[i]}');
  }

  print('========');
// 或者用 indexed（Dart 3.0+，返回 Records）
  for (final (i, v) in list.indexed) {
    print('$i: $v');
  }
}
