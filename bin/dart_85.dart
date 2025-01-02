// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case
void main() {
  /**
   * 变量模式
   * var a
   * String str
   * final int
   * _ 通配符
   * 变量模式将新变量绑定到已匹配或解构的值，它们通常作为解构模式的一部分出现，以捕获解构后的值
   * 这些变量只有在模式匹配时才能够访问的代码区域中处于作用域
   */
  const x = 100;
  const y = 200;
  switch ((1, 2)) {
    case var r:
      print('r = $r');
    case (x, y):
      print('x = $x, y = $y');
    case (int a, _):
      print('a = $a');
    case (int c, final int d):
      print('c = $c, d = $d');
    case (int e, String f):
      print('e = $e, f = $f');
    default:
      print('no match');
  }
}
