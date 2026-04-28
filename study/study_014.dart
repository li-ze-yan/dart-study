class Point {
  // 字段
  double x;
  double y;

  // 构造函数（this.x 是参数自动赋值字段的简写）
  Point(this.x, this.y);

  // 实例方法
  double distanceTo(Point other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return (dx * dx + dy * dy).abs(); // 简化：返回平方距离
  }

  // 重写 toString，print 时自动调用
  @override
  String toString() => 'Point($x, $y)';
}

void main() {
  // 注意：Dart 创建对象**不需要 new**（new 关键字可选，习惯上不写）
  final a = Point(0, 0);
  final b = Point(3, 4);
  print(a.distanceTo(b)); // 25
  print(b); // Point(3.0, 4.0)
}
