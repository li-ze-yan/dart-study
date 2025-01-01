// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * 构造函数中的[] 和 {} 和普通函数一致
   * [] 不能改变顺序
   * {} 可以改变顺序
   */

  Person p1 = Person(name: '张三', age: 20);

  Worker w1 = Worker(name: '李四', age: 30, job: '程序员');

  w1.work();

  Cat cat = Cat(null, 12, '绿色');

  cat.speak();
}

class Person {
  String name;
  int? age;
  Person({required this.name, this.age});
}

class Worker extends Person {
  String? job;
  Worker({required super.name, super.age, this.job});

  void work() {
    print('我是一个$job');
  }
}

class Animal {
  String? name;
  int? age;
  Animal([this.name = '鲍勃', this.age]);
}

class Cat extends Animal {
  String? color;
  Cat([super.name = '鲍勃', super.age, this.color]);

  void speak() {
    print('我是一只$color猫 名字叫${super.name} 我今年$age 岁');
  }
}
