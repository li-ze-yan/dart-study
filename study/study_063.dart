// 方法重写时，参数类型不能收窄（里氏替换原则）
//
// 问题：如果 DogShelter 只接受 Dog，会导致父类型引用出 bug：
//   AnimalShelter shelter = DogShelter();  // 多态 — DogShelter 也是 AnimalShelter
//   shelter.take(Animal());                 // AnimalShelter 定义说能接 Animal
//                                           // 但 DogShelter 只接受 Dog → 炸了
//
// 结论：子类重写方法时，参数类型必须和父类完全一致（不能更窄，也不能更宽）
//       例外：加 covariant 关键字可以允许收窄（如 operator == 经常这样做）

class Animal {}

class Dog extends Animal {}

class AnimalShelter {
  void take(Animal a) {}
}

class DogShelter extends AnimalShelter {
  // ❌ 编译错误：父类 take(Animal a)，子类不能改成 take(Dog a)
  //    否则用 AnimalShelter 类型引用 DogShelter 实例时，传 Animal 会崩
  // @override
  // void take(Dog a) {}
}
