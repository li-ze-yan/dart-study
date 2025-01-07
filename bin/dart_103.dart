// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null
void main() {
  print('123'.parseInt());

  var str1 = '456';
  var i2 = str1.parseInt();
  print(i2);

// 动态类型不能调用扩展里面的方法，只有静态分析出来的类型，才能调用扩展里面的方法
  dynamic str2 = '789'; // 运行时错误，编译正常
  str2.parseInt();
}

extension StringC on String {
  int parseInt() => int.parse(this);
}
