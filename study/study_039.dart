Future<int> task(int id, int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  return id;
}

void main() async {
  // 并发：等所有完成（≈ Promise.all）
  final results = await Future.wait([
    task(1, 1),
    task(2, 2),
    task(3, 1),
  ]);
  print('全部完成: $results');

  // 谁先完成谁赢（≈ Promise.race）
  final winner = await Future.any([
    task(10, 3),
    task(20, 1),
    task(30, 2),
  ]);
  print('最快: $winner'); // 20
}
