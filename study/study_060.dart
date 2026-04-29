// Dart 单例模式：三件套保证全局只有一个实例
class Database {
  // ── 1) 静态字段：缓存唯一实例 ──
  // static: 属于类本身，不属于任何一个对象，全局共享
  // final: 赋值后不可变，保证不会中途被替换
  // _instance: _ 开头 = 库私有，外部文件拿不到
  // = Database._internal(): 类加载时调用私有构造，创建唯一实例
  static final Database _instance = Database._internal();

  // ── 2) 私有命名构造函数 ──
  // Database._internal(): _internal 是命名构造，_ 开头 = 私有
  // 外部代码无法写 new Database._internal()，只能内部调用
  // 这里只打印一行，实际项目里做初始化（开连接、读配置等）
  Database._internal() {
    print('Database 初始化（只会执行一次）');
  }

  // ── 3) factory 构造函数：拦截 new，永远返回缓存 ──
  // factory: 不真正创建新对象，而是"决定返回哪个对象"
  // 每次写 Database() 都会走这里，但返回的一直是 _instance
  // 如果不用 factory 而用普通构造，每次 new 就会创建新实例
  factory Database() => _instance;

  // ── 4) 业务方法 ──
  void query(String sql) => print('执行: $sql');
}

void main() {
  final a = Database();       // 走 factory，返回 _instance
  final b = Database();       // 再走 factory，还是返回 _instance
  print(identical(a, b));     // true — a 和 b 是同一个对象
  a.query('SELECT 1');
}

// 流程：
//   Database()  →  factory 构造  →  返回 _instance（全局唯一）
//   Database()  →  factory 构造  →  返回 _instance（还是同一个）
//   Database._internal()  →  ❌ 外部不可调用（私有）
