enum HttpMethod {
  get('GET', false),
  post('POST', true),
  put('PUT', true),
  delete('DELETE', false);

  // 字段
  final String label;
  final bool hasBody;

  // 必须是 const 构造
  const HttpMethod(this.label, this.hasBody);

  // 方法
  bool get isWrite => this != HttpMethod.get;
}

void main() {
  for (final m in HttpMethod.values) {
    print('${m.label} hasBody=${m.hasBody} isWrite=${m.isWrite}');
  }
}
