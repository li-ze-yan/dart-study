// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals
void main() async {
  // 运算符重载
  // 不是所有运算符都能进行重载 ++
  // var p1 = Person('张三', 20);
  var p1 = Person('张三', 40);
  var p2 = Person('李四', 30);

  print(p1 > p2);
  print(p1 == p2);
}

class Person {
  String name;
  int age;

  Person(this.name, this.age);

  bool operator >(Person other) {
    return age > other.age;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Person) return false;
    return name == other.name && age == other.age;
  }
}
