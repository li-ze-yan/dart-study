// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * 常量构造函数，需要在构造函数左边加 const 关键字
   * 所有的成员变量都是 final 类型，这样赋值一次参数后就不会被改变，或者是 static
   * 常量命名构造函数，跟常量构造函数一样，左边有 const 关键字，右边是命名构造函数 类名.方法名+(参数)，要求所有成员都是 final
   * 
   * const 定义时赋值
   * final 运行时赋值
   * 都不能二次修改值
   */
  var p1 = const Person('张三', 15);
  print(p1.name);
  // p1.name = '李四';

  var p2 = const Person('张三', 15);

  print(p1 == p2);
  print(identical(p1, p2));
  print(p1.hashCode);
  print(p2.hashCode);
}

class Person {
  final String name;
  final int age;
  const Person(this.name, this.age);
}
