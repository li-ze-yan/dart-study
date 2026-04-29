class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  NetworkException(this.message, {this.statusCode});
  @override
  String toString() => 'NetworkException($statusCode): $message';
}

/// 模拟一个不稳定的网络请求：第 [failTimes] 次之前会失败。
class FlakeyApi {
  int _attempts = 0;
  final int failTimes;
  FlakeyApi({this.failTimes = 2});

  String fetch() {
    _attempts++;
    if (_attempts <= failTimes) {
      throw NetworkException('临时故障', statusCode: 503);
    }
    return '✅ 第 $_attempts 次请求成功';
  }
}

/// 通用重试包装器：失败 [maxRetries] 次后放弃。
T retry<T>(T Function() action, {int maxRetries = 3}) {
  var attempt = 0;
  while (true) {
    try {
      return action();
    } on NetworkException catch (e) {
      attempt++;
      if (attempt > maxRetries) {
        print('💥 达到最大重试次数 ($maxRetries)，放弃');
        rethrow;
      }
      print('⏳ 第 $attempt 次失败：$e；重试中...');
    }
  }
}

void main() {
  final api = FlakeyApi(failTimes: 2);
  try {
    final result = retry(api.fetch, maxRetries: 1);
    print(result);
  } on NetworkException catch (e) {
    print('最终失败: $e');
  }
}
