// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  // extends 关键字
  // 继承父类，右边是父类，左边是子类，默认情况下，什么都不写
  // 子类拥有父类全部的方法和成员变量，但是必须初始化父类的构造函数
  // 只能继承一个父类，如果要继承多个父类，需要使用 implements 关键字

  Person person = Person('张三', 20);
  Worker worker = Worker('李四', 30, '程序员');

  person
    ..showInfo()
    ..action();
  worker
    ..showInfo()
    ..action();
}

class Person {
  String name;
  int age;

  Person(this.name, this.age);
  showInfo() {
    print("name = $name, age = $age");
  }

  action() {
    print("Person action执行");
  }
}

class Worker extends Person {
  String job;
  Worker(super.name, super.age, this.job);

  @override
  showInfo() {
    print("name = $name, age = $age, job = $job");
  }

  @override
  action() {
    print("Worker action执行");
  }
}
