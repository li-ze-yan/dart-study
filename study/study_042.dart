// 强制空安全

String s = 'hello'; // 不可为 null
String? s2; // 可为 null

// int? 字段没初始化时**默认是 null**
class A {
  int? a; // ✅ 默认 null
  // int b;           // ❌ 必须初始化或加 ? 或加 late
}
