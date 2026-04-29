// 模拟一个异步函数：1 秒后返回结果
Future<String> fetchUserName(int id) async {
  await Future.delayed(const Duration(seconds: 1));
  return '用户#$id';
}

void main() async {
  print('开始');
  final name = await fetchUserName(42);
  print('得到: $name');
  print('结束');
}
