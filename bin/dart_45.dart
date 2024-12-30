// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  // abstract 关键字定义抽象类
  // 抽象类不能被实例化
  // 抽象类里的方法如果没有写方法体，就是抽象方法，子类必须实现
  // 抽象类中的方法如果实现了方法体，就是普通方法，extends 继承，子类可以不实现

  Worker worker = Worker();
  worker.action();
}

abstract class Person {
  // 只有方法体，没有方法名，这种方法是抽象方法，子类继承，必须实现抽象方法
  action();
  breath() {
    // 这个方法有方法体，是普通方法，extends 继承，子类可以不重写普通方法
    print('breath');
  }
}

class Worker extends Person {
  @override
  action() {
    print('实现 action 方法');
  }
}
