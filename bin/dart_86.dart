// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case
void main() {
  /**
   * 标识符模式
   * 例如：
   * name 常量名称，在外面定义的 const 常量
   * _ 通配符，匹配全部，并且不存储结果
   * 标识符模式在出现它们的上下文中可能像常量模式或变量模式一样的行为
   */

  const int c = 200;
  switch (2) {
    case c: // 标识符模式常量行为，只能匹配固定的值
      print('标识符模式常量行为$c');
    case _:
      print('_ 通配符，匹配全部，并且不存储结果');
    default:
      print('no match');
  }

  switch (0) {
    case const ((1 + 2) * 2):
      print(6);
    case const (1 + 2 * 2):
      print(5);
  }

  // 列表模式外层匹配实现 List 的值，然后递归的将其子模式与列表的元素匹配以按位置解构它们
  const a = 'a';
  const b = 'b';
  const d = 'c';

  var list = [a, b, d];

  switch (list) {
    case [a, b]:
      print('a = $a, b = $b');
    case [a, b, d]:
      print('a = $a, b = $b, d = $d');
  }
}
