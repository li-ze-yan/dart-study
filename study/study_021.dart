abstract class Shape {
  // 抽象方法：没有实现，子类必须提供
  double area();

  // 也可以有具体方法
  void describe() => print('一个 $runtimeType，面积 ${area()}');
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);

  @override
  double area() => 3.14159 * radius * radius;
}

class Square extends Shape {
  final double side;
  Square(this.side);

  @override
  double area() => side * side;
}

void main() {
  // ❌ Shape();  // 不能 new 抽象类
  final shapes = <Shape>[Circle(3), Square(5)];
  for (final s in shapes) {
    s.describe(); // 多态：实际调用各自的 area()
  }
}
