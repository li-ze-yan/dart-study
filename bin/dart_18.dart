// ignore_for_file: unnecessary_cast, unnecessary_type_check

void main() {
  // as 类型转换
  var a = '123';
  String b = a as String;

  print(b);

  List c = [1, 2, 3];
  List<int> d = c as List<int>;
  print(d);

  var value = 'hello';
  if (value is String) {
    print(value.length);
  } else if (value is int) {
    print('int');
  }
}
