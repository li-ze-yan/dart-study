// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * 泛型接口
   * dart 中没有接口的概念，只有方法声明，没有方法体的实现，这样的类
   * dart 中的接口可以理解成：只有抽象方法的 abstract class 抽象类
   */
  Worker worker = Worker('111');
  // worker.readId(123);
  worker.readId("456.56");
  // worker.readId(true);
  // worker.readId(123.56);
}

abstract class Person<T> {
  readId(T id);
}

class Worker<T> implements Person<T> {
  T id;
  Worker(this.id);

  @override
  readId(T id) {
    print(T);
    print("id: $id");
  }
}
