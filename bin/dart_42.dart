// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  Person person = Person("张三", 20, '北京');
  Person temp = Person("里斯", 19);

  person.show();
  temp.show();
}

class Person {
  // 属性只要不是可选的，就都要初始化，但 late 修饰的属性可以不初始化
  String? name;
  late int age;
  late final String address;

  // Person(this.name, this.age, [String? address]) : address = address ?? '上海';
  // Person(this.name, this.age, [this.address = '上海']);
  Person(this.name, this.age, [String? address])
      : address = age > 18 ? '上海' : '北京';

  Person.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    age = json['age'];
    address = json['address'];
  }

  show() {
    print("$name-$age-$address");
  }

  // 初始化列表的作用，跟上面的构造函数简写，效果相同，都是在创建对象的时候给属性初始化，而不是在{}里面赋值，是对象已经创建完以后再执行的操作
  // Person(String name, int age, String address): name = name, age = age, address = address;
}
