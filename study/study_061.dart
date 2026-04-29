class AppEnv {
  // 单例
  static final AppEnv _instance = AppEnv._();
  factory AppEnv() => _instance;
  AppEnv._();

  // 可变状态：只在启动时被 init 调用
  String _env = 'dev';
  Map<String, String> _flags = {};
  bool _initialized = false;

  /// 初始化一次（重复调会报错，避免误用）
  void init({required String env, required Map<String, String> flags}) {
    if (_initialized) {
      throw StateError('AppEnv 已经初始化过，禁止重复初始化');
    }
    _env = env;
    _flags = Map.unmodifiable(flags);
    _initialized = true;
  }

  String get env => _env;
  String? flag(String key) => _flags[key];

  bool get isProd => _env == 'prod';
}

void main() {
  // 启动时初始化
  AppEnv().init(env: 'prod', flags: {'feature_x': 'on', 'theme': 'dark'});

  // 业务任意位置使用
  print('环境: ${AppEnv().env}');
  print('feature_x: ${AppEnv().flag('feature_x')}');
  print('是生产？${AppEnv().isProd}');

  // 重复初始化会抛错
  try {
    AppEnv().init(env: 'dev', flags: {});
  } on StateError catch (e) {
    print('❌ ${e.message}');
  }
}
