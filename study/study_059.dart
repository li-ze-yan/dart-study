/// 用 cents（分）作为底层类型，避免浮点误差
extension type Money(int cents) {
  /// 命名构造：从元转换
  Money.fromYuan(double yuan) : this((yuan * 100).round());

  /// 加法：返回新 Money
  Money operator +(Money other) => Money(cents + other.cents);

  /// 减法
  Money operator -(Money other) => Money(cents - other.cents);

  /// 乘以数量
  Money operator *(int n) => Money(cents * n);

  /// 显示成 ¥xx.xx
  String format() {
    final yuan = cents ~/ 100;
    final rest = (cents % 100).toString().padLeft(2, '0');
    return '¥$yuan.$rest';
  }
}

void main() {
  final unit = Money.fromYuan(19.9); // 1990 cents
  final total = unit * 3; // 5970 cents
  final after = total - Money.fromYuan(5); // 5470
  print(
      '${unit.format()} × 3 - ¥5 = ${after.format()}'); // ¥19.90 × 3 - ¥5 = ¥54.70

  // ❌ 不能和普通 int 混用，避免"忘了单位"导致的 bug
  // final wrong = unit + 100;   // 编译错误
}
