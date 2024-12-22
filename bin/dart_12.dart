// ignore_for_file: prefer_function_declarations_over_variables

typedef Add = int Function(int, int);

int add(int a, int b) {
  return a + b;
}

void main() {
  // 函数类型和匿名函数

  hello(String name) => 'Hello $name';

  // 使用 hello 变量
  print(hello('World')); // 输出: Hello World

  Add fn1 = add;
  print(fn1(1, 2));

  // 匿名函数
  var fn3 = () {
    print('匿名函数');
  };
  fn3();

  run(Function func) => func();
  run(() => {print('匿名函数执行了')});
}
