// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * 泛型 构造函数
   */
  Person person = Person<int>(11);
  print(person.getValue());

  ListPoison listPoison = ListPoison<int>();

  listPoison.add(1);
  listPoison.add(2);
  listPoison.add(3);

  print(listPoison.get(1));
}

class Person<T> {
  T name;
  Person(this.name);
  T getValue() {
    return name;
  }
}

class ListPoison<T> {
  final _list = [];

  void add(T value) {
    _list.add(value);
  }

  T get(int index) {
    return _list[index];
  }
}
