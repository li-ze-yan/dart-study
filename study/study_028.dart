// Comparable<T>: dart:core 接口，表示"可比较大小"
//   int compareTo(T other): 负数(<) / 0(==) / 正数(>)
//   内置实现: int(Comparable<num>), double(Comparable<num>), String(Comparable<String>)
//   bool 没有实现 Comparable，所以不能传给 maxOf
T maxOf<T extends Comparable>(T a, T b) {
  return a.compareTo(b) >= 0 ? a : b;
}

void main() {
  print(maxOf<int>(3, 7)); // 7
  print(maxOf<String>('apple', 'banana')); // banana
  // maxOf(true, false);      // ❌ bool 不是 Comparable
}
