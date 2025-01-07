// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null

main() {
  /**
   * List 的 dynamic 动态类型 注意事项
   */
  // 不能将动态列表用作类型化列表
  // List<int> list = <dynamic>[]; // 错误
  var list = <dynamic>[];

  // as 静态分析正确 运行时检查错误
  List<Object> list1 = <String>['a', 'b'];

  // list1.add(1); // 运行时错误
  // List<int> list2 = list1 as List<int>; // 运行时错误

  // <dynamic>类型注释传入到函数中的List<int>指定类型中的错误例子
  List<dynamic> list3 = [1, 2, 3];
  // printInts(list3); // 错误，静态分析错误

  // 没有足够的信息的时候，会推断成 dynamic
  final list4 = [];
  var list5 = [];
  print(list4.runtimeType);
  print(list5.runtimeType);
}

printInts(List<int> ints) => print(ints);
