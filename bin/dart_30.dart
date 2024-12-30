// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code

void main() {
  List<Map<String, dynamic>> students = [
    {'name': '张三', 'age': 18, 'gender': '男'},
    {'name': '李四', 'age': 19, 'gender': '女'},
    {'name': '王五', 'age': 20, 'gender': '男'},
    {'name': '赵六', 'age': 21, 'gender': '女'},
    {'name': '钱七', 'age': 22, 'gender': '男'},
  ];

  String name = '钱七';
  var filterName = students.where((student) {
    return student['name']?.contains(name);
  }).toList();

  print(filterName);
}
