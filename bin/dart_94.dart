// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null

void main() {
  /**
   * 空状态
   * 类型提升判断
   */

  // 使用 ?. 操作符
  String? nullableName = null;
  String name = nullableName ?? "Guest"; // name 为 "Guest"

  // 使用 ?? 操作符
  String? nullableName2 = null;
  String name2 = nullableName2 ?? "Guest"; // name 为 "Guest"

  // 使用 ??= 操作符
  String? nullableName3 = null;
  String name3 = nullableName3 ??= "Guest";

// 使用 is 和 is! 操作符进行类型检查
  String? nullableString;
  if (nullableString is String) {
    // 处理非空且为 String 类型的情况
    print(nullableString);
  } else {
    // 处理空或非 String 类型的情况
    print("String is null or not a String");
  }
}
