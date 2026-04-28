class Animal {
  final String name;
  Animal(this.name);

  void breathe() => print('$name 在呼吸');
}

class Dog extends Animal {
  // 调用父类构造函数（只能用 super，不能用 this）
  Dog(super.name); // Dart 2.17+ 的 super 参数语法

  void bark() => print('$name: 汪汪!');
}

class Bird extends Animal {
  Bird(super.name);

  // 子类重写父类方法（@override 不是必需，但强烈推荐：拼错时编译报错）
  @override
  void breathe() {
    super.breathe(); // 还能调父类原方法
    print('$name 还会用气囊呼吸');
  }
}

void main() {
  final d = Dog('小白');
  d.breathe(); // 继承自 Animal
  d.bark(); // Dog 自己的

  final b = Bird('小鸟');
  b.breathe(); // 会先调用父类的 breathe，再打印气囊呼吸
}
