// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type
void main() {
  var list = [1, 2];
  switch (list) {
    case [var a, var b]:
      print('a = $a, b = $b');
      break;
    default:
      print('no match');
      break;
  }

  var list1 = [1, 2, 3];
  var [a, b, _] = list1;
  print('a = $a, b = $b');

  // switch 的 case 中可以使用逻辑运算符
  var list2 = ['abc', 99];
  switch (list2) {
    case ['abc' || 'ac', var c]:
      print(c);
      break;
    default:
      print('no match');
      break;
  }

  // if case 是把 case 放在 () 里面进行匹配，相当于单一一组的 switch case，要求 dart3.0+
  var list3 = [77, 66, '3'];
  if (list3 case [var a, _, String c]) {
    print('a = $a, c = $c');
  } else {
    print('no match');
  }

  // 赋值交换
  var (x, y) = (10, 20);
  (y, x) = (x, y);
  print('$x, $y');
}

/**
 * dart 3.0 中引入模式 Patterns 的概念
 * 模式
 * 模式是 Dart 语言中的一种语法类别，类似于语句和表达式
 * 模式表示一组可能匹配实际值的形状
 */
