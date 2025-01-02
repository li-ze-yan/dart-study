// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern
void main() {
  // 空断言
  // assert(true); // 向下执行
  // assert(false); // 抛出异常

  // String? str = 'zhangsan';
  String? str;
  nullAssert(str);

  // 使用空检查，空断言，从变量声明模式中消除 null 值
  (int?, int?) position = (100, 200);
  print(position.runtimeType);

  var (x as int, y as int) = position;
  print('$x, $y');
  var (a!, b!) = position;
}

nullAssert(String? str) {
  try {
    switch (str) {
      case var s!:
        print(s);
        break;
      default:
        print('no match');
        break;
    }
  } catch (e) {
    print('e = $e');
  }
}
