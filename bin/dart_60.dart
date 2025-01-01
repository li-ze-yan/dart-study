// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals
import './SingletonPattern/singleton_pattern.dart';

void main() {
  /**
   * 单例模式
   */
  var p1 = Person();
  var p2 = Person();
  print('${p1.hashCode}, ${p2.hashCode}');

  p1.name = '张三';
  p2.name = '李四';

  p1.showInfo();
  p2.showInfo();
}
