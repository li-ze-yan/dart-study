// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

import './outer/animal.dart';
import './outer/inner/cat.dart';
import './outer/student.dart';

void main() {
  // 静态变量只能被静态方法调用
  // 私有变量只能在当前类中调用
  Student student = Student();
  student.show();

  Animal animal = Animal();
  animal.show();

  Cat cat = Cat();
  cat.show();

  animal.height = 1.8;

  animal.show();

  cat.show();

  cat.height = 2.0;

  cat.show();

  print('${student.name}牵着${cat.name}');
}
