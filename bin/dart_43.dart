// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  // 级联操作符
  // 连续两个点是级联操作符，作用是把一个对象的下面的方法或者成员连续使用出来
  // 级联操作返回的是对象
  // 语法：对象..方法()..方法()..成员 = 值;

  Person p = Person();
  // p.action();
  // p.showInfo();

  p
    ..action()
    ..showInfo();
}

class Person {
  String name = '张三';
  int age = 20;
  showInfo() {
    print("name = $name, age = $age");
  }

  action() {
    print("action执行");
  }
}
