// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type
void main() {
  // 模式中的强制类型转换
  num n1 = 100;
  print(n1.runtimeType);

  (num, Object) record = (100, 'abc');
  print(record.runtimeType);
  var (a as int, b as String) = record;
  print('a = $a, b = $b');
  // a= '11'; // error
}
