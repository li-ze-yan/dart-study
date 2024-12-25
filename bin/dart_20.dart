// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable

void main() {
  // List 转换为 Map

  // 方法1
  List<String> list1 = ['a:1', 'b:2', 'c:3'];
  Map<String, int> map1 = Map.fromIterable(list1,
      key: (k) => k?.split(':')[0], value: (k) => int.parse(k?.split(':')[1]));
  print(map1);

  // 方法2
  List<MapEntry<String, int>> list2 = [
    MapEntry('a', 1),
    MapEntry('b', 2),
    MapEntry('c', 3),
  ];

  Map<String, int> map2 = list2.fold({}, (acc, entry) {
    acc[entry.key] = entry.value;
    return acc;
  });
  print(map2);

  // 方法3
  List<MapEntry<String, int>> list3 = [
    MapEntry('a', 1),
    MapEntry('b', 2),
    MapEntry('c', 3),
  ];
  Map<String, int> map3 = {};
  for (var entry in list3) {
    map3[entry.key] = entry.value;
  }
  print(map3); // 输出: {a: 1, b: 2, c: 3}

  List<MapEntry<String, int>> list4 = [
    MapEntry('a', 1),
    MapEntry('b', 2),
    MapEntry('c', 3),
  ];
  Map<String, int> map4 = Map.fromEntries(list4);
  print(map4);
}
