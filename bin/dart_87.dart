// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case
void main() {
  /**
   * 列表模式要求模式中的元素数量与整个列表相匹配，可以使用 rest 元素作为占位符来处理列表中的任意数量的元素
   * rest 元素
   */

  var [a, b, ...rest, c, d] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  print('a = $a, b = $b, rest = $rest, c = $c, d = $d');
}
