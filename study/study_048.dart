/// 分页参数
typedef PageQuery = ({int page, int size, String? keyword});

/// 分页结果（Record 当返回类型，写起来比建一个类轻量）
typedef PageResult<T> = ({
  List<T> items,
  int total,
  int totalPages,
  bool hasMore,
});

/// 模拟：根据 keyword 在 source 里搜索并分页
PageResult<String> queryPage(List<String> source, PageQuery q) {
  // 1) 关键词过滤
  final filtered = q.keyword == null || q.keyword!.isEmpty
      ? source
      : source.where((x) => x.contains(q.keyword!)).toList();

  final total = filtered.length;
  final totalPages = (total / q.size).ceil();

  // 2) 切片
  final start = (q.page - 1) * q.size;
  final end = (start + q.size).clamp(0, total);
  final items = start >= total ? <String>[] : filtered.sublist(start, end);

  return (
    items: items,
    total: total,
    totalPages: totalPages,
    hasMore: q.page < totalPages,
  );
}

void main() {
  final cities = ['北京', '上海', '广州', '深圳', '杭州', '成都', '苏州', '南京'];

  // 解构返回值（Record 解构语法）
  // `:fieldName` 表示按名字从 Record 中抽取字段，赋值给同名变量
  // 等价于:
  //   final result = queryPage(...);
  //   final items = result.items;
  //   final total = result.total;
  //   ...
  final (:items, :total, :totalPages, :hasMore) =
      queryPage(cities, (page: 2, size: 3, keyword: null));

  print('总数=$total, 总页数=$totalPages, 当前页结果=$items, 还有？$hasMore');
}
