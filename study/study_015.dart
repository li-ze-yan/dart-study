class User {
  // final 字段：构造完成后不可变（最常用！）
  final String name;
  final int age;

  // late：延迟初始化，第一次访问前赋值即可
  // 适合：依赖 this 才能算出来的字段、单元测试需要替换的字段
  late final String displayName = '$name ($age)';

  // 静态字段（属于类，不属于实例）
  static int instanceCount = 0;

  // 静态常量
  static const int maxAge = 150;

  User(this.name, this.age) {
    instanceCount++;
  }

  // 静态方法
  static User guest() => User('访客', 0);
}

void main() {
  final u1 = User('小新', 5);
  print(u1.displayName); // 小新 (5)
  print(User.instanceCount); // 1
  print(User.maxAge); // 150
  print(User.guest());
}
