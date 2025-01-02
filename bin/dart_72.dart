// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals
void main() {
  var list = Person.values;
  for (var k in list) {
    print(k);
    print(k.tall);
    print(k.weight);
    print(k.index);
  }
}

// 增强型枚举
enum Person {
  child(tall: 150, weight: 40),
  adult(tall: 180, weight: 80);

  final int tall;
  final int weight;
  const Person({required this.tall, required this.weight}); // 要求必须是常量构造函数
}
