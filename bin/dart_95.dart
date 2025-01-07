// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null

void main() {
  /**
   * late 代替 ?
   * late 延迟初始化 解决默认值为null的问题
   */

  Person p = Person('张三', 18, '北京');
}

class Person {
  // String? name;
  // int? age;
  // String? address;
  late String name;
  late int age;
  late String address;

  Person(this.name, this.age, this.address);

  void printInfo() {
    print('name: $name, age: $age, address: $address');
  }
}
