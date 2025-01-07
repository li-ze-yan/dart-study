// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null

main() {
  /**
   * 子类继承父类，并且覆盖重写父类中的方法
   * 并且入参是父类对象的时候，函数的入参需要是父类，或者是父类的超类
   */

  Dog dog = Dog();
  dog.eat(dog);
  dog.eat(Animal());
}

class Animal {
  void eat(Animal animal) {
    print('Animal eat');
  }
}

class Dog extends Animal {
  // 正确
  // @override
  // void eat(Animal animal) {
  //   print('Dog eat');
  // }

  // 正确
  @override
  void eat(Object obj) {
    print('Dog eat');
  }

  // 错误
  // @override
  // void eat(Dog dog) {
  //   print('Dog eat');
  // }
}
