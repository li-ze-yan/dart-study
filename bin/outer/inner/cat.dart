// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals
import '../animal.dart';

void main() {}

class Cat extends Animal {
  String _name = '小猫';
  // 如何使用 super

  String get name {
    return _name;
  }

  set name(String value) {
    if (_name.isNotEmpty) {
      _name = value;
    } else {
      print('名字不能为空');
    }
  }

  @override
  void show() {
    // 怎么获取到 Animal 的 age 和 height 属性呢？
    print('name: $_name, age: ${super.age}, height: ${super.height}');
  }
}
