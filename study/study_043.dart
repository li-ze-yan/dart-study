import 'dart:convert';
import 'dart:io';

class ApiService {
  // late final: 承诺初始化前一定赋值，且只赋值一次
  late final HttpClient _client;

  void init() {
    _client = HttpClient()
      ..connectionTimeout = const Duration(seconds: 5);
  }

  Future<String> fetchTitle(Uri uri) async {
    try {
      final request = await _client.getUrl(uri);
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      // 简单提取 <title> 内容
      final match = RegExp(r'<title>(.*?)</title>').firstMatch(body);
      return match?.group(1) ?? '(无标题)';
    } finally {
      // HttpClient 用完需要关闭
    }
  }

  void close() => _client.close();
}

void main() async {
  final service = ApiService();

  // --- 场景 1: 忘了 init 直接调用 ---
  try {
    await service.fetchTitle(Uri.parse('https://example.com'));
  } catch (e) {
    print('❌ LateInitializationError: $e');
    // 输出: LateInitializationError: Field '_client@...' has not been initialized.
  }

  // --- 场景 2: 正确初始化后调用 ---
  service.init(); // ← 初始化
  final title = await service.fetchTitle(Uri.parse('https://example.com'));
  print('✅ 页面标题: $title');

  service.close();
}
