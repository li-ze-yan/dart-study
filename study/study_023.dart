// 这就是一个普通类，但可以被任何类 implements
class Logger {
  void log(String msg) => print('LOG: $msg');
}

// implements 表示"我承诺有 Logger 的所有 API"，但**不会继承实现**
class FileLogger implements Logger {
  // 必须重新实现 log（因为 implements 不带实现）
  @override
  void log(String msg) {
    // 这里假装写到文件
    print('FILE: $msg');
  }
}
