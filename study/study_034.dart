int fetchScore(String user) {
  if (user == 'vip') return 100;
  throw FormatException('无法识别的用户: $user');
}

/// 中间层：记日志，但不吞异常
int service(String user) {
  try {
    return fetchScore(user);
  } catch (e, s) {
    print('[service] 记录日志: $e');
    print('[service] 堆栈: $s');
    rethrow; // 保留原始堆栈，继续向上抛
  }
}

/// 顶层：兜底处理
void controller(String user) {
  try {
    final score = service(user);
    print('分数: $score');
  } catch (e) {
    print('[controller] 兜底处理: $e');
  }
}

void main() {
  print('--- 正常情况 ---');
  controller('vip');

  print('\n--- 异常情况 ---');
  controller('guest');

  // 对比：throw e 会重置堆栈
  print('\n--- throw e 对比 ---');
  try {
    try {
      throw Exception('原始错误');
    } catch (e) {
      throw e; // ❌ 堆栈丢失，错误源头变成这一行
    }
  } catch (e, s) {
    print('错误: $e');
    print('堆栈（丢失了原始位置）: $s');
  }
}
