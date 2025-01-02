// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern
void main() {
  // 常量模式
  constPattern(1);
  constPattern(2);
  constPattern(3);

  var p1 = const Person('xiaoming');
  var p2 = const Person('xiaoming');

  print('${p1.hashCode} ${p2.hashCode}');
  constClass(p1);
}

constPattern(int? r) {
  switch (r) {
    case 1:
      print('1');
    case 2:
      print('2');
    case const (1 + 2):
      print('3');
    default:
      print('no match');
  }
}

constClass(Person? p) {
  switch (p) {
    case const Person('xiaoming'):
      print('xiaoming');
    case const Person('xiaohong'):
      print('xiaohong');
    default:
      print('no match');
  }
}

class Person {
  static const int id = 9999;
  final String name;

  const Person(this.name);
}
