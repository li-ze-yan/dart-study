// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null

void main() {
  /**
   * 空状态
   * 
   */

  // 非空类型
  String nonNullableString = "Hello"; // 正确
  // String nonNullableString = null; // 错误，不能为 null

  // 可空类型
  String? nullableString = "Hello";
  nullableString = null; // 正确

  // 空值断言操作符
  String? possiblyNullString;
  // String definitelyNotNullString =
  //     possiblyNullString!; // 如果 possiblyNullString 为 null，会抛出异常

  // 空合并操作符
  String? nullableName = null;
  String name = nullableName ?? "Guest"; // name 为 "Guest"

  // 条件属性访问和调用
  Map<String, String>? nullableMap = null;
  String? value = nullableMap?["key"]; // value 为 null

  // 空安全级联
  Person? person = Person();
  person
    ?..setName('John Wick')
    ..setAge(30)
    ..setAddress(Address()
      ..setStreet('xxx')
      ..setCity('yyy'))
    ..printInfo();

  // 空安全索引运算符
  Map<String, String>? nullableMap2 = null;
  String? value2 = nullableMap2?['key']; // value 为 null

  List<String>? nullableList = null;
  String? value3 = nullableList?[0];

  /**
   * 三种方法去空化
   * as 强制转换
   * ?. 当只有不空的时候才运行
   * ! 强制解包
   */
}

class Person {
  String? name;
  int? age;
  Address? address;

  void setName(String name) {
    this.name = name;
  }

  void setAge(int age) {
    this.age = age;
  }

  void setAddress(Address address) {
    this.address = address;
  }

  void printInfo() {
    print('Name: $name, Age: $age');
    address?.printAddress(); // 安全调用 address 的方法
  }
}

class Address {
  String? street;
  String? city;

  void setStreet(String street) {
    this.street = street;
  }

  void setCity(String city) {
    this.city = city;
  }

  void printAddress() {
    print('Street: $street, City: $city');
  }
}
