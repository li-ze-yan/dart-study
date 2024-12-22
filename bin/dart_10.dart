// ignore_for_file: avoid_function_literals_in_foreach_calls

void main() {
  List<int> list = [1, 2, 3];
  List<String> fruits = ['apple', 'banana', 'orange'];
  List<dynamic> mixedList = [1, 'apple', true];
  List<int> numbers = List.filled(5, 0);

  print(list);
  print(fruits);
  print(mixedList);
  print(numbers);

  // 添加元素
  list.add(4);
  fruits.addAll(['pear', 'grape']);

  // 删除元素
  fruits.remove('pear');
  fruits.removeLast();
  list.removeAt(3);

  print(fruits);
  print(list);

  // 访问元素
  print(mixedList.first);
  print(mixedList.last);
  print(mixedList.elementAt(0));
  print(numbers.isEmpty);
  print(numbers.isNotEmpty);

  // 遍历元素
  for (var item in list) {
    print(item);
  }
  for (var i = 0; i < list.length; i++) {
    print(list[i]);
  }
  fruits.forEach((fruit) => print(fruit));
  List<int> mapList = numbers.map((k) => 1).toList();
  print(mapList);

  // 查找元素
  print(list.contains(1));
  print(list.indexOf(1));
  print(list.lastIndexOf(1));
  print(list.where((k) => k > 1));

  // 排序和反转
  list.sort();
  list.reversed.toList();

  // 其他
  print(fruits.length);
  print(fruits.join(','));
  print(fruits.sublist(1, 3));
}
