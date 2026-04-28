/*
  三种声明
  var final const
 */

void main() {
  var name = "小新";
  name = "美伢"; // 可重新赋值

  final now = DateTime.now();
  // now = DateTime.now(); // 不能重新赋值

  const pi = 3.14159;
  // pi = 3.14; // 不能重新赋值

  String city = '北京';
  int age = 30;

  // final vs const 对集合的影响
  final list1 = [1, 2, 3];
  list1.add(4);

  const list2 = [1, 2, 3];
  // list2.add(4); // 报错，const 创建的集合不能修改
}
