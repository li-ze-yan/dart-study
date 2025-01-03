// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case
import './baseClass/base_class.dart';

void main() {
  /**
   * 在 Dart 中，base 是一个类修饰符，它用于定义一个类，该类不能被其他包中的类继承，但在同一包内可以被继承
   * 用于控制类的可见性和继承规则，确保某些类只能在特定范围内被继承，从而提高代码的安全性和可维护性
   */
  MyBaseClass myBaseClass = MyBaseClass();
}
// error
// class UpdateClass extends MyBaseClass {
//   void myMethod() {
//     print('myMethod');
//   }
// }

class UpdateClass {
  void myMethod() {
    print('myMethod');
  }
}
