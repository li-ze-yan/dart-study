/// 一个常见痛点：JSON 解析时既要校验结构，又要取出字段。
/// 用 patterns 一行搞定。
void parseConfig(Map<String, dynamic> json) {
  // 期望结构：{ "version": int, "server": { "host": str, "port": int }, "tags": [str, ...] }
  switch (json) {
    // 完美匹配
    case {
        'version': final int version,
        'server': {'host': final String host, 'port': final int port},
        'tags': final List<dynamic> tags,
      }:
      print('✅ v$version 连 $host:$port，标签 ${tags.length} 个');

    // 兼容老版本：缺 server 字段
    case {'version': final int version, 'tags': final List<dynamic> _}:
      print('⚠️ v$version 没有 server，使用默认本地配置');

    // 完全不认识的格式
    default:
      print('❌ 未知配置: $json');
  }
}

void main() {
  parseConfig({
    'version': 2,
    'server': {'host': 'api.com', 'port': 443},
    'tags': ['prod', 'east'],
  });

  parseConfig({
    'version': 1,
    'tags': ['legacy'],
  });

  parseConfig({'oops': true});
}
