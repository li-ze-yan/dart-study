// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type
void main() {
  // 空检查
  String? str = 'abc';
  // String? str;
  nullCheck(str);
}

nullCheck(String? str) {
  switch (str) {
    // 空检查 s? 的特点是，只有非空才会匹配
    case var s?:
      print(s);
      break;
    case null:
      print('null');
      break;
    default:
      print('no match');
      break;
  }
}
