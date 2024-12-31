// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  // 多态
  // 父类对象运行子类方法，根据传入子类对象的真实类型，执行子类自己的方法
  // 在 dart 中就是，父类类型的对象，里面实际存储的是子类对象，可以运行子类自己重写的方法

  // person 变量的类型是 Person，但实际存储的对象可以是 Worker 或 AnotherWorker
  Person person1 = Worker();
  Person person2 = AnotherWorker();
  person1.action();
  person2.action();

  performAction(Worker());
  performAction(AnotherWorker());
}

performAction(Person obj) {
  obj.action();
}

abstract class Person {
  action();
  breath() {
    print('breath');
  }
}

class Worker extends Person {
  @override
  action() {
    print('action');
  }

  @override
  breath() {
    print('worker breath');
  }
}

class AnotherWorker extends Person {
  @override
  action() {
    print('another worker action');
  }
}
