// ignore_for_file: prefer_collection_literals

void main() {
  // 在 Dart 中，Set 是一种无序且不重复的集合。Set 主要用于存储唯一的元素，不允许重复值
  Set<int> set = Set();

  // 添加元素
  set.add(1);
  set.add(2);

  print(set);
  print('=======');

  List<int> list = [1, 2, 3, 4, 5];
  Set<int> set2 = Set.from(list);

  print(set2);
  print('=======');

  Set<int> set3 = Set.of([1, 2, 3, 4, 5]);

  print(set3);
  print('=======');

  Set<int> set4 = {1, 2, 3, 4, 5};
  print(set4);
  print('=======');

  // 删除元素
  set.remove(1);
  set2.removeAll([1, 2]);
  print(set);
  print(set2);
  print('=======');

  // contains 检查集合中是否包含某个元素
  print(set.contains(2));
  print(set.contains(1));
  print('=======');

  // 并集、交集、差集
  Set<int> set5 = Set.from([1, 2, 3, 4, 5]);
  Set<int> set6 = Set.from([3, 4, 5, 6, 7]);

  // 并集
  print(set5.union(set6));
  // 交集
  print(set5.intersection(set6));
  // 差集
  print(set5.difference(set6));
  print('=======');

  // Set.identity() 是一个工厂构造函数，用于创建一个 Set，该集合使用对象的标识（identity）进行相等性检查
  // 不是使用对象的 == 运算符。这意味着只有当两个对象是同一个实例时，它们才会被视为相等
  Set<Object> identitySet = Set.identity();

  var obj1 = Object();
  var obj2 = Object();
  var obj3 = obj1; // obj3 和 obj1 是同一个实例

  identitySet.add(obj1);
  identitySet.add(obj2);
  identitySet.add(obj3);

  print(identitySet.length); // 输出: 2
  print(identitySet.contains(obj1)); // 输出: true
  print(identitySet.contains(obj2)); // 输出: true
  print(identitySet.contains(obj3)); // 输出: true
}
