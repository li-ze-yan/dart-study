// 完整场景
void printBanner(String appName) {
  final line = '=' * (appName.length + 8);
  print(line);
  print('== $appName ==');
  print(line);
}

void main(List<String> args) {
  final name = args.isEmpty ? 'Fucker' : args.first;
  printBanner(name);
}
