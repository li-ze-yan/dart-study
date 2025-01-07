// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null

import 'package:json/json.dart';

// 运行命令：dart run --enable-experiment=macros bin/dart_104.dart
main() {
  Student s1 = Student('张三', 20);
  Map<String, dynamic> map = s1.toJson();
  print(map);
  print('name is ${map['name']} age is ${map['age']}');

  // 通过 json 创建 Student 对象
  Student s2 = Student.fromJson(map);
  // print('name is ${s2.name} age is ${s2.age}');
  print(s2.toString());

  print(s1.hashCode);
  print(s2.hashCode);
}

@JsonCodable()
class Student {
  String name;
  int age;

  Student(this.name, this.age);

  @override
  String toString() {
    return 'Student name is $name, age is $age';
  }
}
