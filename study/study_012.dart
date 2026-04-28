/// 创建一个累加器：每次调用返回累计值。
int Function(int) makeAdder(int initial) {
  var total = initial; // 被闭包捕获
  return (int delta) {
    total += delta; // 持续修改外层局部变量
    return total;
  };
}

void main() {
  final adder = makeAdder(10);
  print(adder(5)); // 15
  print(adder(3)); // 18
  print(adder(-2)); // 16

  // 两个累加器互不影响（各自的 total 是独立的）
  final adder2 = makeAdder(100);
  print(adder2(1)); // 101
  print(adder(1)); // 17（不受 adder2 影响）
}
