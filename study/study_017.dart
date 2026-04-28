class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  // Getter：像访问字段一样调用
  double get area => width * height;
  double get perimeter => 2 * (width + height);

  // Setter：可以做校验
  set size(double value) {
    if (value <= 0) throw ArgumentError('size 必须为正数');
    width = value;
    height = value;
  }
}

void main() {
  final r = Rectangle(3, 4);
  print(r.area); // 12（不是 r.area()，是属性）
  r.size = 5;
  print(r.area); // 25
}
