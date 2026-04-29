T firstOr<T>(List<T> list, T fallback) {
  return list.isEmpty ? fallback : list.first;
}

void main() {
  print(firstOr<int>([1, 2, 3], 0)); // 1
  print(firstOr(<String>[], 'NA')); // NA（类型自动推导）
}
