// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * is as
   * 在父类和子类中使用
   * 父类型的对象通过 as 转换成子类型调用子类方法
   * is 判断父类型的对象，如果是子类型，自动转换为子类型，可以调用子类型的方法
   */

  // as 类型转换
  dynamic str = 'hello';
  var str2 = str as String;
  print(str2.length);

  Person p1 = Worker();

  action(p1);

  (p1 as Worker).work();
}

class Person {}

class Worker extends Person {
  work() {
    print('work');
  }
}

class Student extends Person {
  study() {
    print('study');
  }
}

action(Person p) {
  if (p is Worker) {
    p.work();
  } else if (p is Student) {
    p.study();
  } else {
    print('no one');
  }
}
