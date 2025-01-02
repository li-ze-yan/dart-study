// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type
void main() {
  // 模式优先级

  // 逻辑或 ||

  // 逻辑或模式通过 || 将子模式分隔开，并在任何分支匹配时进行匹配，分支从左到右进行评估
  // 一旦有一个分支匹配，其余分支将不再进行评估

  var color = Color.red;
  var isPrimary = switch (color) {
    Color.red || Color.yellow || Color.blue => true,
    _ => false
  };

  print('isPrimary = $isPrimary');

  var record = (1, 2);
  switch (record) {
    // case (var a , var b) || (var c, var d):
    //   print('错误执行');
    case (var a, var b) || (var a, var b):
      print('前置条件执行');
  }

  bool a = true;
  bool b = true;
  bool c = true;
  if (a && b && c) {
    print('正确');
  }

  switch ((1, 2)) {
    case (var a, var b) && (var c, var d, var e):
      print('错误执行');
    case (var a, var b) && (var c, var d):
      print('前置条件执行');
  }

  // == != < > <= >=
}

enum Color { red, yellow, blue, gray }
