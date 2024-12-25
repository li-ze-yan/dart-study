// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals

void main() {
  // Map 的使用
  // Map 是一种键值对（key-value）集合的数据结构。它允许你存储和检索与特定键关联的值
  Map<String, int> args = {
    'a': 1,
    'b': 2,
    'c': 3,
  };

  print(args);

  Map<String, String> args2 = Map();
  print(args2);
  args2['a'] = '1';
  args2['b'] = '2';
  args2['c'] = '3';
  args2['d'] = '4';
  args2['e'] = 'e';
  print(args2);
  print(args2['a']);

  bool hasKey = args2.containsKey('a');
  print(hasKey);

  args2.remove('a');
  bool hasKey2 = args2.containsKey('a');
  print(hasKey2);

  print('======');
  // 遍历 map
  for (var key in args.keys) {
    print(key);
  }
  print('======');

  for (var value in args.values) {
    print(value);
  }
  print('======');

  for (var entry in args.entries) {
    print(entry);
  }
  print('======');

  for (var entry in args.entries) {
    print('${entry.key}: ${entry.value}');
  }
  print('======');

  args.forEach((key, value) {
    print('$key: $value');
  });
  print('======');

  List<String> keys = args.keys.toList();
  List<int> values = args.values.toList();
  print(keys);
  print(values);
  print('======');

  // 合并 Map
  var mergedMap = {...args, ...args2};
  print(mergedMap); // 输出 {a: 1, b: 2, c: 3, d: 4}
  print(mergedMap['a'] is String);
  print(mergedMap['b'] is String);
  print(mergedMap['c'] is String);
  print(mergedMap['d'] is String);
  print(mergedMap['e'] is String);
  // 同一键，后面覆盖前面的数据
  print('======');

  // 清空 Map
  mergedMap.clear();
}
