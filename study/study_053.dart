extension StringExt on String {
  /// 反转字符串
  String reversed() => split('').reversed.join();

  /// 是否回文
  bool get isPalindrome => this == reversed();
}

void main() {
  print('hello'.reversed()); // olleh
  print('level'.isPalindrome); // true
}
