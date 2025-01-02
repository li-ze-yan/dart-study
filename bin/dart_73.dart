// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals
void main() {
  Record record = (1, 2, 3, 'hello');
  print(record);
  print(record.runtimeType);
  // 类型注释
  // Record 类型注释是由括号中的类型以逗号分隔列表组成
  (int, int, int, String) record2 = (1, 2, 3, 'hello');
  print(record2.$1);
  print(record2.$2);
  print(record2.$3);

  var record3 = (a: 1, b: 'hello', 400, 'shit');
  print(record3.a);
  print(record3.b);
  print(record3.$1);
  print(record3.$2);

  ({int a, String b}) record4 = (a: 1, b: 'hello');
  print(record4.a);
  print(record4.b);

  ({int a, String b}) record5;

  record5 = (a: 1, b: 'hello');

  (int a, int b) record6 = (1, 2);
  (int c, int d) record7 = (3, 4);
  print(record6 == record7);
}

/**
 * 元祖
 * dart 3.0 引入元祖
 */
