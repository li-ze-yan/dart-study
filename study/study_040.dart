/// 每秒产出一个递增的数字，共 [count] 个
Stream<int> counter(int count) async* {
  for (var i = 1; i <= count; i++) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield i; // 注意是 yield，不是 return
  }
}

void main() async {
  await for (final n in counter(5)) {
    print('收到: $n');
  }
  print('Stream 结束');
}
