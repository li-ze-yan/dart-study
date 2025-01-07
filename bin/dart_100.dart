// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null

void main() {
  /**
   * implements 的 透明性和不透明性
   * 当一个扩展类型用 implements 实现了它的表示类型(封装的底层类型)，就是透明性
   * 没有通过 implements 实现的表示类型，就是不透明性
   */
  ExtendedPerson extendedPerson = ExtendedPerson(Person('张三'));

  // 通过扩展类型调用底层类型的方法
  extendedPerson.greet(); // 输出: Hello, my name is 张三
  print(extendedPerson.getNameLength()); // 输出: 2

  // 通过底层类型的方法
  print(extendedPerson.name); // 输出: 张三
  extendedPerson.nameLength(); // 输出: 2
}

// 定义一个普通类
class Person {
  final String? _name;

  Person(this._name);

  // Getter 方法
  String? get name {
    return _name;
  }

  void nameLength() {
    if (_name != null) {
      print(_name!.length);
    }
  }
}

// 定义扩展类型并实现表示类型
extension type ExtendedPerson(Person person) implements Person {
// extension type ExtendedPerson(Person person) {
  // 添加一个新的方法
  void greet() {
    print('Hello, my name is ${person.name}');
  }

  // 可以添加更多的方法或属性
  int getNameLength() {
    return person.name?.length ?? 0;
  }
}
