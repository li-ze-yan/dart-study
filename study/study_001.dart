// void main() {
//   print("Hello World!");
// }

// 合法的 main 签名

// 无参数，最常见
// void main() {}

// 有参数，接收命令行参数
// void main(List<String> args) {
//   print(args);
// }

// 异步入口
Future<void> main(List<String> args) async {
  print(args);
}
