// 模式匹配三大用法

// ── 数据准备 ──
sealed class Resp {}

final class Ok extends Resp {
  final dynamic data;
  Ok(this.data);
}

final class Err extends Resp {
  final int code;
  final String msg;
  Err(this.code, this.msg);
}

// ──────────────────────────────────────────
// 1) switch 表达式：值必须被每一个 case 匹配到
// ──────────────────────────────────────────
String describe(Resp r) => switch (r) {
      Ok(data: final d) => '成功: $d',
      Err(code: final c, msg: final m) => '失败[$c]: $m',
      // sealed 保证穷举，少写一个分支编译器直接报错
    };

// ──────────────────────────────────────────
// 2) if-case：只关心某一种模式，不关心的忽略
// ──────────────────────────────────────────
void onlyOk(Resp r) {
  if (r case Ok(data: final d)) {
    print('  拿到了数据: $d');
  }
  // 不是 Ok 就什么都不做
}

void onlyServerError(Resp r) {
  if (r case Err(code: 500, msg: final m)) {
    print('  服务器错误: $m');
  }
}

// ──────────────────────────────────────────
// 3) 解构（变量声明）：拆开复合值，一次性赋给多个变量
// ──────────────────────────────────────────
void destructureDemo() {
  // 3a) Record 解构
  final (fuck, shit) = ('小明', 10);
  print('  名字=$fuck, 年龄=$shit');

  // 3b) 命名 Record 解构
  final (:lat, :lng) = (lat: 39.9, lng: 116.4);
  print('  经度=$lng, 纬度=$lat');

  // 3c) List 解构（取前两个）
  final [first, second, ...] = [1, 2, 3, 4, 5];
  print('  第一个=$first, 第二个=$second');

  // 3d) 对象解构
  final Ok(:data) = Ok([10, 20, 30]);
  print('  解构出的 data=$data');
}

// ──────────────────────────────────────────
void main() {
  final ok = Ok('用户列表');
  final err = Err(500, '数据库连接失败');

  print('--- 1) switch 表达式 ---');
  print(describe(ok));
  print(describe(err));

  print('\n--- 2) if-case ---');
  onlyOk(ok);
  onlyOk(err); // 不匹配，无输出
  onlyServerError(err);

  print('\n--- 3) 解构 ---');
  destructureDemo();
}
