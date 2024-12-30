// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  Person person1 = Person('John', 30);
  Person person2 = Person('John', 30);
  Person person3 = Person('Jim', 35);

  print(person1 == person2);
  print(person2 == person3);

  Set<Person> people = {person1, person2, person3};
  print(people.length);
}

class Person {
  String name;
  int age;
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

  // 重写 == 方法
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Person && other.name == name && other.age == age;
  }

  // 重写 hashCode 方法
  @override
  int get hashCode => Object.hash(name, age);
}
