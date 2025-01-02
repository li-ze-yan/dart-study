// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() async {
  /**
   * external 关键字
   * external 关键字用于声明外部实现的方法或变量。它告诉编译器该方法或变量的具体实现不在当前 Dart 文件中，而是在其他地方（例如原生代码、JavaScript 或其他 Dart 文件）提供。
   * 与平台交互：当需要调用底层平台（如 iOS、Android）的原生代码时，可以使用 external 来声明这些方法。
   * Dart 和 JavaScript 互操作：在 Dart 编写 Web 应用时，external 可以用来声明与 JavaScript 交互的方法。
   * 库实现分离：有时为了模块化设计，会将某些方法的具体实现放在不同的文件或库中，这时可以用 external 声明接口
   */

  Worker worker = Worker();
  worker.work();
}

class Person {
  external work();
}

class Worker extends Person {
  @override
  work() {
    print('哈哈');
  }
}
