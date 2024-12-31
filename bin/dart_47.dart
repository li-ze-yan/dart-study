// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * implements
   * 用于实现一个或多个接口
   * 定义了一组方法和属性的契约，但没有提供这些方法的具体实现
   * 实现接口的类必须提供接口中所有方法的具体实现
   * 一个类可以实现多个接口
   * 实现接口的类必须提供接口中所有方法的具体实现
   * 接口不能包含实例变量（除了静态常量），只能包含方法和 getter/setter 的声明
   */
  /**
   * extends
   * 用于继承一个类
   * 子类继承父类的所有方法和属性，并可以重写这些方法或添加新的方法和属性
   * 子类只能继承一个父类（单继承）
   */
  Person person = Worker('1', 2, '3', '4');
  person.say();
}

class Person {
  String name;
  int age;
  Person(this.name, this.age);
  void say() {
    print('name: $name, age: $age');
  }
}

// 职业
abstract class Work {
  String work;
  Work(this.work);
  workFor() {
    print('工作');
  }

  workBy() {
    print('学习');
  }

  workGet() {
    print('获取');
  }

  workDo() {
    print('做');
  }
}

class Worker extends Person implements Work {
  @override
  String work;
  String job;
  Worker(super.name, super.age, this.job, this.work);

  @override
  workBy() {
    print('工作');
  }

  @override
  workDo() {
    print('学习');
  }

  @override
  workFor() {
    print('获取');
  }

  @override
  workGet() {
    print('做');
  }

  @override
  say() {
    print('$name-$age-$job-$work');
  }
}
