// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null

main() {
  /**
   * 子类中重写方法的返回类型必须是父类型或者是它的子类型
   */
}

class Animal {
  Animal getAnimal() {
    return Animal();
  }
}

class Dog extends Animal {
  @override
  Animal getAnimal() {
    return Dog();
  }
}

class Cat extends Animal {
  @override
  Animal getAnimal() {
    return Cat();
  }
}

class Fuck extends Animal {
  @override
  Animal getAnimal() {
    return Cat();
  }
}

class Shit extends Animal {
  @override
  Animal getAnimal() {
    return Animal();
  }
}
