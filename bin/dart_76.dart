// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type
void main() {
  var a = 33;
  var x =
      switch (a) { 10 => '错误', 99 => '正确', 22 || 33 => '显示为 22 33', _ => '未知' };
  print(x);
}
