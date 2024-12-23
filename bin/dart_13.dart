// void main() {
//   print('Hello World!');
// }

// void main() async {
//   print('开始');
//   await Future.delayed(Duration(seconds: 2));
//   print('2秒后结束');
// }

// void main(List<String> args) async {
//   print('开始');
//   await Future.delayed(Duration(seconds: 2));
//   print('2秒后结束');
// }

// Future<void> main(List<String> args) async {
//   print('开始');
//   await Future.delayed(Duration(seconds: 2));
//   print('2秒后结束');
// }

Future<void> main(List<String> args) async {
  print('开始');
  await Future.delayed(Duration(seconds: 2));
  print('2秒后结束');
}
