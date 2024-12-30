// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables

void main() {
  // 闭包函数
  int localVariable = 20;

  // 创建闭包函数
  Function closure = createClosure(localVariable);

  // 调用闭包函数
  closure();

  localVariable = 40;

  closure();
}

int globalVariable = 10;

// 闭包捕获变量: 闭包可以捕获其词法作用域中的变量，包括全局变量和局部变量。
// 变量生命周期: 即使创建闭包的函数执行完毕，闭包仍然可以访问捕获的变量。
// 变量修改: 如果被捕获的局部变量在闭包创建后被修改，闭包访问的变量值也会相应变化。
Function createClosure(int captureVariable) {
  int anotherVariable = 30;

  return () {
    print('global variable: $globalVariable');
    print('capture variable: $captureVariable');
    print('another variable: $anotherVariable');
  };
}
