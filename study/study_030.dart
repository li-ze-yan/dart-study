enum Status { pending, active, inactive, deleted }

void main() {
  final s = Status.active;
  print(s); // Status.active
  print(s.name); // 'active'
  print(s.index); // 1
  print(Status.values); // [Status.pending, ...] 全部值
}
