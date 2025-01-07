// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null
import './dart_40.dart';

void main() {
  /**
   * dart 3.2 
   * final 私有变量
   * 类型提升
   */
  Person person = Person('张三');
  print(person._name);
  print(person.name);

  Student student = Student();
  student.show();
  // print('student._name=${student._name}');
}

class Person {
  final String? _name;

  Person(this._name);

  // Getter 方法
  String? get name {
    return _name;
  }

  void nameLength() {
    if (_name != null) {
      print(_name.length);
    }
  }
}
