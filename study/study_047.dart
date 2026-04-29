void main() {
  final point = (x: 3, y: 4);
  final (x: a, y: b) = point; // 改名解构
  print('a=$a, b=$b');

// 列表解构
  final [first, second, ...rest] = [1, 2, 3, 4, 5];
  print('$first $second $rest'); // 1 2 [3, 4, 5]

// Map 解构
  final {'name': name, 'age': age} = {'name': '小新', 'age': 5};
  print('$name $age');
}
