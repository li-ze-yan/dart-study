class InsufficientFundsException implements Exception {
  final double need;
  final double have;
  InsufficientFundsException({required this.need, required this.have});

  @override
  String toString() => '余额不足：需 $need，仅有 $have';
}

double withdraw(double balance, double amount) {
  if (amount > balance) {
    throw InsufficientFundsException(need: amount, have: balance);
  }
  return balance - amount;
}

void main() {
  try {
    withdraw(50, 100);
  } on InsufficientFundsException catch (e) {
    // 按异常类型捕获（推荐）
    print('⚠️ $e');
  } on FormatException catch (e) {
    print('格式错误: $e');
  } catch (e, stack) {
    // 兜底：捕获其他所有异常 + 堆栈
    print('未知错误: $e');
    print(stack);
  } finally {
    print('交易流程结束');
  }
}
