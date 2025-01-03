// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case

void main() {
  /**
   * 在 Dart 中，final 是一个类修饰符，它用于定义一个类，该类不能被继承。
   * final 类：不能被任何其他类继承
   * 作用：确保类的实现不会被子类修改或扩展，从而提高代码的安全性和不可变性
   */
}

final class MyFinalClass {
  int id;
  String name;

  MyFinalClass(this.id, this.name);
}

// error
// class MyClass extends MyFinalClass {
//   MyClass(int id, String name) : super(id, name);
// }

abstract final class MyAbstractFinalClass {
  fuck();
  shit();
}

// error
// class MyClass extends MyAbstractFinalClass {
//   @override
//   fuck() {
//   }

//   @override
//   shit() {
//   }
// }
