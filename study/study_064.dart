class Animal {}

class Dog extends Animal {}

class AnimalShelter {
  // 标记 covariant：允许子类把参数收窄
  void take(covariant Animal a) {}
}

class DogShelter extends AnimalShelter {
  @override
  void take(Dog a) {
    // 现在 OK
    print('狗舍只收狗');
  }
}
