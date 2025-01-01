// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * 类的构造函数是常量构造函数
   * 如果调用构造函数的时候，传入的值，是可变的，不是常量，那么调用的时候也不能加 const
   * 如果常量构造函数加了 const ，那么传入的值必须是不可变的
   */
  const Person('john wick');
  // String name = 'john wick';
  // const Person(name) // error
  const String name = 'john wick';
  const Person(name); // right

  const Text('2', TextStyle(fontSize: 12));
}

class Person {
  final String name;
  const Person(this.name);
}

class TextStyle {
  final int? fontSize;
  const TextStyle({this.fontSize});
}

class Text {
  final String data;
  final TextStyle style;
  const Text(this.data, this.style);
}
