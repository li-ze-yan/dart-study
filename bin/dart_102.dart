// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null
void main() {
  print(StringC.name);
  StringC.name = 'hehe';
  print(StringC.name);
  String str = 'hehe';
  print(str.lengthName);

  str.changeName = 'fuck';
  print(StringC.name);
}

// static 成员是不属于某一个变量的
extension StringC on String {
  static String name = 'haha';

  static void show() {
    print('show');
  }

  get lengthName => length;

  set changeName(String str) {
    name = str;
  }
}
