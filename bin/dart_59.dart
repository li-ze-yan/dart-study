// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * 工厂构造函数
   */
  var p1 = Person._init('哈哈', 21);
  p1.showInfo();
}

class Person {
  String name;
  int age;
  Person._init(this.name, this.age);

  factory Person(name, age) {
    return Person._init(name, age);
  }

  showInfo() {
    print('姓名：$name，年龄：$age');
  }
}
