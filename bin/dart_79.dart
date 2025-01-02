// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type
void main() {
  /**
 * for in 解构 map 解构 json
 */
  Map<String, int> hist = {'a': 23, 'b': 100};
  for (var item in hist.entries) {
    print(item);
    print('${item.key}: ${item.value}');
  }

  for (var MapEntry(:key, :value) in hist.entries) {
    print('$key, $value');
  }

  var m1 = MapEntry('张三', 18);
  var MapEntry(:key, :value) = m1;
  print('$key, $value');

  // 模式验证Json 这个json是个map，类型是Map<String, List<Object>>
  var json = {
    'user1': ['zhangsan', 18],
    'user2': ['lisi', 20]
  };
  print(json.length);

  var {'user1': [name, age], 'user2': [name1, age1]} = json;
  print('$name, $age, $name1, $age1');
}
