// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals
void main() {
  var color = Color.red;
  print(color);

  var list = Color.values;
  for (var k in list) {
    print("k = $k");
    print("k index = ${k.index}");
  }

  switch (color) {
    case Color.red:
      print("red");
      break;
    case Color.yellow:
      print("yellow");
      break;
    case Color.blue:
      print("blue");
      break;
  }
}

// 枚举类型，用于表示一组固定数量的常量值
enum Color { red, yellow, blue }
