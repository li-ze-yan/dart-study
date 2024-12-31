// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * 泛型 通过 extends 限制类型
   */
  ListPoison listPoison = ListPoison();
  listPoison.add(Animal());
  listPoison.add(Dog());
  listPoison.add(Cat());

  listPoison.get(0).makeSound();
  listPoison.get(1).makeSound();
  listPoison.get(2).makeSound();

  ListPerson listPerson = ListPerson();
  listPerson.add(Person('John Wick', 30));
  listPerson.add(Person('Tony Stark', 40));
  listPerson.add(Person('Bruce Wayne', 50));

  listPerson.get(0).attack();
}

class Animal {
  makeSound() {
    print('Some generic animal sound');
  }
}

class Dog extends Animal {
  @override
  makeSound() {
    print('Bark');
  }
}

class Cat extends Animal {
  @override
  makeSound() {
    print('Meow');
  }
}

class ListPoison<T extends Animal> {
  final _list = [];

  void add(T value) {
    _list.add(value);
  }

  T get(int index) {
    return _list[index];
  }
}

mixin YongChun {
  attack() {
    print('YongChun attack');
  }
}

class Person with YongChun {
  String name;
  int age;
  Person(this.name, this.age);
  void say() {
    print('My name is $name, I am $age years old');
  }

  @override
  attack() {
    print('Person attack');
  }
}

class ListPerson<T extends YongChun> {
  final _list = [];

  void add(T value) {
    _list.add(value);
  }

  T get(int index) {
    return _list[index];
  }
}
