// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  Person person1 = Person('John', 30);
  print('person1: ${person1.hashCode}');
  person1 = Person('John', 30);
  print('person1: ${person1.hashCode}');
  // 两者不同

  // json转模型
  var json = {
    'name': 'Johnn',
    'age': 300,
  };
  Person person2 = Person.formJson(json);
  person2.greet();
}

class Person {
  late String name;
  late int age;
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

  Person.formJson(Map json) {
    name = json['name'];
    age = json['age'];
  }
}
