void main() {
  // List.generate 生成数组...运算符拆解并且合并数组
  List<double> list = List.generate(10, (index) => index * 2);
  List<int> list2 = List.generate(5, (index) => index + 1);
  print(list);
  print(list2);

  print('==========');
  var list3 = [...list, ...list2];
  print(list3);
}
