// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables

void main() {
  // 用 Function 保存匿名函数
  Function fn1 = () {
    print('这是Function保存方法的写法');
  };

  fn1();

  () {
    print('调用匿名方法');
  }();

  // 自执行方法
  (String v) {
    print('这是匿名方法2，参数是：$v');
  }('一只猫');
}
