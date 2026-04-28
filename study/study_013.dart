/// 创建一个限流函数：每 [intervalMs] 毫秒最多触发一次回调。
///
/// 这是闭包的典型应用：把"上次触发时间"藏在闭包里。
void Function() throttle(void Function() action, int intervalMs) {
  // 闭包捕获的状态
  DateTime? lastFired;

  return () {
    final now = DateTime.now();
    // null + ?? 兜底：如果还没触发过，认为间隔无穷大
    final elapsed = lastFired == null
        ? intervalMs
        : now.difference(lastFired!).inMilliseconds;

    if (elapsed >= intervalMs) {
      lastFired = now;
      action();
    } else {
      print('  (被节流：距上次仅 ${elapsed}ms)');
    }
  };
}

void main() async {
  var counter = 0;
  final tick = throttle(() {
    counter++;
    print('触发！第 $counter 次');
  }, 200);

  // 模拟 10 次快速点击，每隔 50ms 触发
  for (var i = 0; i < 10; i++) {
    tick();
    await Future.delayed(const Duration(milliseconds: 50));
  }
}
