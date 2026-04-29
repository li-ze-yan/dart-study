class AppConfig {
  final String host;
  final int port;
  final String? proxy;
  final Duration? timeout;

  const AppConfig({
    required this.host,
    this.port = 80,
    this.proxy,
    this.timeout,
  });

  /// 用另一份配置覆盖当前的非 null 字段（典型的"环境覆盖默认"场景）
  AppConfig overrideWith(AppConfig? other) {
    if (other == null) return this;
    return AppConfig(
      host: other.host, // host 是必填，直接用 other
      port: other.port, // port 也必填
      proxy: other.proxy ?? proxy, // 可空字段：other 没给则保留旧值
      timeout: other.timeout ?? timeout,
    );
  }

  @override
  String toString() =>
      'AppConfig(host=$host, port=$port, proxy=$proxy, timeout=$timeout)';
}

void main() {
  // 默认配置：proxy 和 timeout 没设
  const defaults = AppConfig(host: 'api.example.com');

  // 测试环境补充 proxy
  const test =
      AppConfig(host: 'test.example.com', port: 8080, proxy: '127.0.0.1:7890');

  // 合并
  final merged = defaults.overrideWith(test);
  print(merged);
  // AppConfig(host=test.example.com, port=8080, proxy=127.0.0.1:7890, timeout=null)
}
