// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  Student s = Student();
  s.show2();
  Student.show();
  Student.address = '上海';
  s.show2();
}

// 静态方法是类所拥有的方法，不需要创建对象就能访问，可以访问静态成员变量，不能访问普通成员变量
// 静态成员变量属于类所拥有的成员变量，不能被对象访问
class Student {
  String name = '张三';
  int age = 20;
  double height = 1.75;
  static String address = '北京';
  static void show() {
    print(address);
  }

  void show2() {
    show();
  }
}
