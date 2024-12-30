// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables

void main() {
  // 局部变量
  int localVariable = 20;

  print('$globalVariable');
  print('$localVariable');

  // 调用函数，展示全局变量和局部变量的作用域
  printFunction();
}

// 局部变量
int globalVariable = 10;

printFunction() {
  print('$globalVariable');

  int anotherVariable = 30;

  print('$anotherVariable');
}
