// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * 泛型
   * 泛型的作用是减少重复代码，可以套用代码
   */
  getSomething(1, 2);
  getSomething('1', '2');

  getSomething2<int>(1, 1);
  // getSomething2<int>('1', 1);

  getSomething3<int, String>(1, '2');
}

void getSomething(row, line) {
  // runtimeType 获取变量的类型 运行时类型
  print('row的类型是${row.runtimeType}');
  print('row的类型是${line.runtimeType}');
}

void getSomething2<T>(T row, T line) {
  // runtimeType 获取变量的类型 运行时类型
  print('row的类型是${row.runtimeType}');
  print('row的类型是${line.runtimeType}');
  print('T的类型是$T');
}

void getSomething3<T, K>(T row, K line) {
  // runtimeType 获取变量的类型 运行时类型
  print('row的类型是${row.runtimeType}');
  print('row的类型是${line.runtimeType}');
  print('T的类型是$T');
}
