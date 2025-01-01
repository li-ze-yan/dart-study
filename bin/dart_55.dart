// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  /**
   * 常量构造函数不能用函数体
   * 调用 const 关键字的构造函数可以省略 const 关键字
   * 但是省略 const 以后，相同成员变量创建的对象存储空间就不一样了
   */
  var list1 = const [1, 2, 3];
  var list2 = const [1, 2, 3];
  // var list2 = [1, 2, 3];

  print(identical(list1, list2));
  print(list1 == list2);
  print(list1.hashCode);
  print(list2.hashCode);
}
