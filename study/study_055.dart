extension ListExt<T> on List<T> {
  /// 安全地取索引，越界返回 null
  T? getOrNull(int i) => i >= 0 && i < length ? this[i] : null;

  /// 按谓词分组（返回符合 / 不符合两组）
  ({List<T> matched, List<T> rest}) partition(bool Function(T) test) {
    final matched = <T>[];
    final rest = <T>[];
    for (final x in this) {
      if (test(x)) {
        matched.add(x);
      } else {
        rest.add(x);
      }
    }
    return (matched: matched, rest: rest);
  }
}

void main() {
  final nums = [1, 2, 3, 4, 5];
  print(nums.getOrNull(10)); // null

  final (:matched, :rest) = nums.partition((x) => x.isEven);
  print('偶数=$matched 奇数=$rest');
}
