// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code

void main() {
  // 函数可选参数 位置
  func1(1, null);

  func2(1);

  func2(1, 2);

  func3(1, d: 2, c: 2);
}

// 基础型
func1(int a, int? b) {
  print(a);
  if (b != null) {
    print(b);
  }
}

// [] 可选参数 位置
// [] 里面的参数顺序不能换，因为 [] 中的参数是可以不传入的，所以必须是可选参数，或者给默认值
func2(int a, [int? b, int? c]) {
  print('====func2====');
  print(a);
  print(b);
  print(c);
  print('====func2====');
}

// {} 命名可选参数
// {} 大括号里面的参数名字必须传入，位置可以换，有 required 关键字作为必填项 不能有默认值，因为一定会传入
func3(int a, {int b = 1, int? c, required int d}) {
  print('====func3====');
  print(a);
  print(b);
  print(c);
  print(d);
  print('====func3====');
}
