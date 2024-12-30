// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code

void main() {
  // 转换类型
  String str = '123';
  int i = int.parse(str);
  print(i);
  double d = double.parse('123.456');
  print(d);

  var j = i.toString();
  print(j);
}
