// Dart 协变（Covariance）：子类型列表可以赋给父类型列表
// List<Dog> 被当作 List<Animal> 的子类型，因为 Dog 是 Animal 的子类

class Animal {}

class Dog extends Animal {}

void main() {
  List<Dog> dogs = [Dog(), Dog()];

  // ✅ 编译通过 — 方便：可以把 List<Dog> 传给接收 List<Animal> 的函数
  List<Animal> animals = dogs;
  //    ^^^^^^ 声明类型是 Animal，但底层对象依然是 List<Dog>

  // ❌ 运行时错误 — animals 和 dogs 指向同一个 List<Dog>
  //    往里塞 Animal 实例会失败，因为底层只接受 Dog
  // animals.add(Animal());
}
