// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables

void main() {
  // new 关键字用于创建类的实例（对象）。在 Dart 2.12 及更高版本中，new 关键字是可选的，可以省略
  Person person = Person('John', 30);
  person.greet();

  person.setAddress('New York');
  print(person.getAddress());
}

class Person {
  String name;
  int age;
  // late 关键字用于标记一个非空变量，表示该变量将在未来的某个时刻被初始化，而不是在声明时立即初始化
  late String address;
  Person(this.name, this.age);

  greet() {
    print('Hello, my name is $name and I am $age years old.');
  }

  setAddress(String newAddress) {
    address = newAddress;
  }

  getAddress() {
    return address;
  }
}
