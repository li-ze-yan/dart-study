// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code

void main() {
  // 可选类型
  int? a = 100;
  a = null;
  print(a);

  var b = '11';
  print(b.isEmpty);
  print(b.isNotEmpty);

  String? c;
  print(c?.isEmpty);
  print(c?.isNotEmpty);

  // 可选类型不能进行运算，除非使用!判空，把可选参数变成非空参数
}
