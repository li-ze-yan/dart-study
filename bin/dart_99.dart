// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null

void main() {
  /**
   * extension type
   * 定义扩展类型： 使用 extension type 关键字来定义一个新的扩展类型。你可以为这个扩展类型添加构造函数、方法和字段
   * 实现扩展类型： 在扩展类型中，你可以通过 this 关键字访问被封装的实例
   * 使用扩展类型： 创建扩展类型的实例并调用其方法
   * Dart 的扩展类型（extension types）确实不允许声明实例字段，它们主要用于封装现有类并为其添加方法，但不能添加新的字段
   * 
   * 使用 implements 继承某个类，可以使用它下面所有的方法和操作符
   * 也可以继承这个类的父类
   * 
   * 使用工厂函数重定向
   */

  ExtendedPerson extendedPersonFromName = ExtendedPerson.fromName('John');
  ExtendedPerson extendedPersonFromPerson =
      ExtendedPerson.fromPerson(Person('John'));
}

class Person {
  final String? _name;

  Person(this._name);

  String? get name => _name;

  void nameLength() {
    if (_name != null) {
      print(_name.length);
    }
  }
}

extension type ExtendedPerson(Person person) {
  // 添加一个新的方法
  void greet() {
    print('Hello, ${person.name}!');
  }

  // 工厂构造函数重定向
  factory ExtendedPerson.fromName(String name) {
    return ExtendedPerson(Person(name));
  }

  // 另一个工厂构造函数
  factory ExtendedPerson.fromPerson(Person person) {
    return ExtendedPerson(person);
  }
}
