// 日志级别
enum LogLevel { info, warn, error }

/// 创建一个日志函数。
///
/// [tag] 必选：日志归属模块。
/// [withTime] 可选：是否打印时间戳，默认 true。
/// [formatter] 可选：自定义格式化函数；不传则用默认格式。
void Function(LogLevel, String) createLogger({
  required String tag,
  bool withTime = true,
  String Function(LogLevel, String)? formatter,
}) {
  // 默认格式化器：[INFO] message
  String defaultFormatter(LogLevel level, String msg) =>
      '[${level.name.toUpperCase()}] $msg';

  // ?? 选择自定义或默认
  final fmt = formatter ?? defaultFormatter;

  return (LogLevel level, String message) {
    final timePart = withTime ? '${DateTime.now().toIso8601String()} ' : '';
    print('$timePart[$tag] ${fmt(level, message)}');
  };
}

void main() {
  // 默认格式
  final orderLog = createLogger(tag: 'OrderModule');
  orderLog(LogLevel.info, '订单创建成功');
  orderLog(LogLevel.error, '支付失败');

  // 自定义格式（带 emoji）
  final paymentLog = createLogger(
    tag: 'Payment',
    withTime: false,
    formatter: (lv, msg) => switch (lv) {
      LogLevel.info => 'ℹ️  $msg',
      LogLevel.warn => '⚠️  $msg',
      LogLevel.error => '🔥 $msg',
    },
  );
  paymentLog(LogLevel.warn, '余额不足');
}
