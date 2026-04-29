void main() {
  // 位置字段
  (int, String) pair = (1, 'one');
  print(pair.$1); // 1
  print(pair.$2); // one

// 命名字段（更推荐，可读性好）
  ({int x, int y}) point = (x: 3, y: 4);
  print(point.x); // 3
  print(point.y); // 4

// 混合：位置 + 命名
  (int, String, {bool active}) row = (1, 'Alice', active: true);
  print(row.$1);
  print(row.active);
}
