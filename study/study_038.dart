Future<int> divide(int a, int b) async {
  if (b == 0) throw ArgumentError('除数为 0');
  return a ~/ b;
}

void main() async {
  // 推荐：try / catch（和同步代码一样）
  try {
    final r = await divide(10, 0);
    print(r);
  } catch (e) {
    print('错误: $e');
  }

  // 也可以用 Future API 风格
  divide(10, 0).then((v) => print(v)).catchError((e) => print('链式错误: $e'));
}
