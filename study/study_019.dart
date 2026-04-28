class TemperatureSensor {
  /// 传感器名字（构造后不可变）
  final String name;

  /// 历史读数（私有，外部只能通过方法访问）
  final List<double> _history = [];

  /// 静态：记录所有传感器实例数量
  static int totalCount = 0;

  /// 阈值，单位 ℃，超过会标记 alert
  static const double dangerThreshold = 80.0;

  TemperatureSensor(this.name) {
    totalCount++;
  }

  /// 添加一条读数
  void record(double celsius) {
    _history.add(celsius);
  }

  /// 最新读数；从未读取过返回 null
  double? get latest => _history.isEmpty ? null : _history.last;

  /// 平均温度（getter，外部像属性一样用）
  double get average {
    if (_history.isEmpty) return 0;
    final sum = _history.fold<double>(0, (a, b) => a + b);
    return sum / _history.length;
  }

  /// 是否处于报警状态
  bool get isAlert => (latest ?? 0) > dangerThreshold;

  /// 摘要报告
  String summary() {
    return '''
[$name] 共 ${_history.length} 条读数
  最新: ${latest?.toStringAsFixed(1) ?? '—'} ℃
  平均: ${average.toStringAsFixed(1)} ℃
  状态: ${isAlert ? '⚠️ 报警' : '正常'}''';
  }
}

void main() {
  final s1 = TemperatureSensor('CPU');
  s1.record(45.2);
  s1.record(60.1);
  s1.record(85.3); // 超阈值
  print(s1.summary());
  print('总传感器数: ${TemperatureSensor.totalCount}');
}
