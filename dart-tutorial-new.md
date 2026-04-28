# Dart 从入门到进阶（面向 JS/TS 开发者 · Dart 3.x）

> 本教程基于 **Dart 3.6+** 的最新语法，所有示例都是独立可运行的小场景（外卖订单、博客系统、银行账户、游戏角色…），方便你边读边敲。
>
> 适合读者：**有 JS / TS 经验**，希望快速、系统地掌握 Dart 全部核心语法及 3.x 新特性的开发者。
>
> 学习建议：从前往后按顺序阅读。前 8 节是地基，第 9–17 节是日常业务能力，第 18 节之后是 Dart 的"特色武器"，能写出比 TS 更优雅的代码。

---

## 目录

- [0. 写在前面：JS/TS 与 Dart 的世界观对比](#0-写在前面jsts-与-dart-的世界观对比)
- [1. 程序入口、注释与运行](#1-程序入口注释与运行)
- [2. 变量与基础类型](#2-变量与基础类型)
- [3. 运算符](#3-运算符)
- [4. 控制流](#4-控制流)
- [5. 集合：List / Set / Map / Iterable](#5-集合list--set--map--iterable)
- [6. 函数](#6-函数)
- [7. 作用域与闭包](#7-作用域与闭包)
- [8. 类（基础）](#8-类基础)
- [9. 继承、抽象类、多态](#9-继承抽象类多态)
- [10. 接口与 implements](#10-接口与-implements)
- [11. 类修饰符（Dart 3.0+）](#11-类修饰符dart-30)
- [12. 构造函数全攻略](#12-构造函数全攻略)
- [13. Mixin](#13-mixin)
- [14. 泛型](#14-泛型)
- [15. 枚举（基础与增强型）](#15-枚举基础与增强型)
- [16. 异常处理与断言](#16-异常处理与断言)
- [17. 异步：Future / async / await](#17-异步future--async--await)
- [18. 空安全（Null Safety）](#18-空安全null-safety)
- [19. 库系统：import / part / export / library](#19-库系统import--part--export--library)
- [20. Records（元组）与解构](#20-records元组与解构)
- [21. 模式匹配 Patterns（Dart 3.0+）](#21-模式匹配-patternsdart-30)
- [22. 扩展方法（Extension Methods）](#22-扩展方法extension-methods)
- [23. 扩展类型（Extension Types，Dart 3.3+）](#23-扩展类型extension-typesdart-33)
- [24. 单例模式](#24-单例模式)
- [25. 协变与方法重写规则](#25-协变与方法重写规则)
- [附录 A：与 TypeScript 的差异速查表](#附录-a与-typescript-的差异速查表)
- [附录 B：需要你补充确认的问题](#附录-b需要你补充确认的问题)

---

## 0. 写在前面：JS/TS 与 Dart 的世界观对比

| 维度       | JS/TS                                  | Dart 3.x                                                             |
| ---------- | -------------------------------------- | -------------------------------------------------------------------- |
| 类型系统   | TS 是**结构化**类型（duck typing）     | **名义类型**：必须显式 `implements X` 才算实现 X                     |
| 一切皆对象 | `number` / `string` 是基本类型         | `int`、`double`、`bool` 都是真正的对象，`1.toString()` 直接可用      |
| 默认 null  | TS 用 `strictNullChecks` 控制          | **强制空安全**：`String` 不能为 null，`String?` 才能                 |
| 变量声明   | `let` / `const`                        | `var`（可变）/ `final`（运行时常量）/ `const`（编译期常量）          |
| 私有       | `private` 关键字（仅编译时检查）       | 标识符以 `_` 开头，且**以文件（库）为边界**                          |
| 异步       | `Promise` + `async/await`              | `Future` + `async/await`，几乎一一对应                               |
| 接口       | `interface` 关键字                     | **没有 interface 关键字**：任何类都隐式可作为接口被 `implements`     |
| 元组       | `[T1, T2]` 数组充当                    | Dart 3.0 引入 **Records**：`(T1, T2)` 是真正的值类型                 |
| 模式匹配   | 基本没有                               | Dart 3.0 引入完整的 **patterns** 系统（`switch`、`if-case`、解构…）  |
| 类继承     | 单继承 + 多接口                        | 单继承 + 多接口 + **Mixin**（横向复用代码）                          |
| 编译目标   | JS（V8 / 浏览器 / Node）               | AOT 原生码（Flutter 移动端）/ JIT / JS / Wasm                        |

**思维转换要点（背下来这 5 条）：**

1. **没有 `===`**：Dart 只有 `==`，可以被重载，默认比较的是对象引用（identity）。
2. **没有 truthy / falsy**：`if (x)` 里 `x` 必须是 `bool`，写 `if (str)` 编译直接报错。
3. **变量未初始化的对象类型不能直接使用**，必须显式赋值，或用 `late` / `?` 修饰。
4. **构造函数极其强大**：命名构造、工厂构造、常量构造、初始化列表、重定向…比 TS 灵活得多。
5. **集合不可变性靠 `const` 实现**：`const [1, 2, 3]` 是编译期常量，运行时再改会抛异常。

---

## 1. 程序入口、注释与运行

### 1.1 程序入口

每个 Dart 程序必须有一个顶层 `main` 函数，名字固定。

```dart
// 最简单的入口
void main() {
  print('Hello, Dart 3!');
}
```

合法的 `main` 签名（按需选用）：

```dart
void main() {}                                  // 无参数，最常见
void main(List<String> args) {}                 // 接收命令行参数
Future<void> main(List<String> args) async {}   // 异步入口（用 await 时常用）
```

### 1.2 注释

```dart
// 单行注释（和 JS 一样）

/* 多行注释 */

/// 文档注释（DartDoc，会被 IDE 提示和 dart doc 工具生成网页）
/// 计算两个整数的和。
///
/// [a] 是第一个加数；[b] 是第二个加数。
/// 返回 `a + b` 的结果。
int add(int a, int b) => a + b;
```

> 💡 文档注释里用 `[名字]` 包裹标识符，IDE 会自动跳转。

### 1.3 运行

```bash
# 直接运行单个文件（开发期，JIT）
dart run bin/main.dart

# 编译成原生可执行文件（上线，AOT，启动快、体积大）
dart compile exe bin/main.dart -o build/app
./build/app
```

### 1.4 完整场景：欢迎横幅

```dart
/// 打印一个带边框的欢迎横幅。
///
/// [appName] 应用名，会显示在横幅中间。
void printBanner(String appName) {
  // 横线长度根据 appName 动态计算（中文字符按 2 个宽度算更准，这里简化只用 length）
  final line = '=' * (appName.length + 8);
  print(line);
  print('==  $appName  ==');
  print(line);
}

void main(List<String> args) {
  // 命令行未传参数时使用默认名字
  final name = args.isEmpty ? 'Dart 学习营' : args.first;
  printBanner(name);
}
```

运行：

```bash
dart run bin/main.dart           # ===== Dart 学习营 =====
dart run bin/main.dart MyApp     # ====== MyApp ======
```

---

## 2. 变量与基础类型

### 2.1 三种声明：`var` / `final` / `const`

| 关键字  | 类比 TS               | 含义                                                       |
| ------- | --------------------- | ---------------------------------------------------------- |
| `var`   | `let`                 | 可变变量；类型从右值推导                                   |
| `final` | `const`（运行时绑定） | 单次赋值；右值可以是运行时计算结果                         |
| `const` | 真正的"编译期常量"    | 单次赋值；右值必须在**编译期**就能确定                     |

```dart
void main() {
  // 类型推导：编译器知道 name 是 String
  var name = '小新';
  name = '美伢'; // ✅ 可重新赋值

  // final：只能赋值一次，但右边可以是运行时表达式
  final now = DateTime.now();
  // now = DateTime.now(); // ❌ 报错

  // const：编译期常量，右边必须是 const 表达式
  const pi = 3.14159;
  // const t = DateTime.now(); // ❌ DateTime.now() 不是编译期常量

  // 显式标注类型（推荐 public API、参数、返回值都标注）
  String city = '北京';
  int age = 30;
}
```

> ⚠️ **`final` vs `const` 对集合的影响**：
>
> ```dart
> final list1 = [1, 2, 3];
> list1.add(4); // ✅ 引用不可变，但内容可变
>
> const list2 = [1, 2, 3];
> list2.add(4); // ❌ 运行时抛 UnsupportedError，const 集合是真正不可变的
> ```

### 2.2 内置基础类型

```dart
// 数字
int n = 42;            // 整数（任意精度）
double d = 3.14;       // 双精度浮点
num x = 1;             // num 是 int 和 double 的父类型
x = 1.5;               // ✅

// 字符串
String s1 = 'Dart';
String s2 = "支持双引号";
String s3 = '''
三引号
支持多行
''';

// 字符串插值（注意：是 $，不是 JS 的 ${} 反引号）
int count = 3;
print('一共有 $count 个');                 // 一共有 3 个
print('总价：${count * 19.9} 元');         // 复杂表达式必须加 {}

// 布尔
bool isOk = true;

// Null 字面量类型是 Null
Null nothing = null;
```

> ⚠️ Dart 没有 `char` 类型；单个字符就是长度为 1 的 `String`。

### 2.3 类型转换

```dart
// String → int / double
final age = int.parse('18');
final price = double.parse('19.99');

// 解析失败给默认值（更安全）
final port = int.tryParse('abc') ?? 8080;  // null + ?? → 8080

// 数字 → String
final s = 42.toString();
final s2 = (3.14159).toStringAsFixed(2);   // '3.14'

// int ↔ double
final a = 1.toDouble();  // 1.0
final b = 3.7.toInt();   // 3（截断，不是四舍五入）
final c = 3.7.round();   // 4
```

### 2.4 完整场景：用户信息卡片

```dart
void main() {
  // 模拟从表单/接口拿到的字段，统一用字符串
  const rawName = '野原新之助';
  const rawAge = '5';
  const rawHeight = '105.3';

  // 解析数字字段时给容错
  final age = int.tryParse(rawAge) ?? 0;
  final height = double.tryParse(rawHeight) ?? 0.0;

  // 派生字段用 final 表示"算一次就别动"
  final bornYear = DateTime.now().year - age;

  // 用三引号字符串组装多行展示
  final card = '''
========================
姓名: $rawName
年龄: $age 岁
身高: ${height.toStringAsFixed(1)} cm
出生年份(估算): $bornYear
========================''';

  print(card);
}
```

---

## 3. 运算符

### 3.1 算术运算

```dart
print(5 + 2);   // 7
print(5 - 2);   // 3
print(5 * 2);   // 10
print(5 / 2);   // 2.5    ← 注意：永远是 double
print(5 ~/ 2);  // 2      ← 整除（向下取整）
print(5 % 2);   // 1
```

> ⚠️ JS 里 `5 / 2 = 2.5`，但 `5 | 0` 之类会取整；Dart 用 `~/` 显式表达整除，**类型也是 `int`**。

### 3.2 比较 & 等于

```dart
print(1 == 1);        // true
print('a' == 'a');    // true（Dart 的 == 默认对内置类型按值比较）
print([1] == [1]);    // false（List 没重写 ==，按引用比较）

// 没有 ===，要"严格相等（同一对象）"用 identical
print(identical([1], [1])); // false
```

### 3.3 逻辑 & 短路

```dart
final a = true, b = false;
print(a && b);   // false
print(a || b);   // true
print(!a);       // false
```

> Dart 没有 `??=` 之外的"`||` 取默认值"用法（因为 `||` 只能用在 bool 上）。要用 null 兜底必须用 `??`。

### 3.4 空安全相关运算符（重点！）

```dart
String? name;     // 可空类型

// 1) ?? 空合并：左边为 null 时返回右边
print(name ?? '默认');   // 默认

// 2) ??= 仅在变量为 null 时赋值
name ??= '小新';
print(name);             // 小新
name ??= '美伢';
print(name);             // 仍然是 小新

// 3) ?. 安全调用：左边为 null 直接返回 null，不报错
String? maybe;
print(maybe?.length);    // null（不会抛异常）

// 4) ! 强制非空（断言"我保证它不是 null"，错了会运行时崩）
String? must = '一定有值';
final len = must!.length;  // 5

// 5) 级联 ..（不是空安全，但常配合）
final list = []
  ..add(1)
  ..add(2)
  ..add(3);
print(list); // [1, 2, 3]
```

### 3.5 类型测试

```dart
final dynamic x = 42;

// is / is!（不是 instanceof）
if (x is int) print('是 int');
if (x is! String) print('不是 String');

// as 强制转换（失败抛 TypeError）
final n = x as int;
```

### 3.6 完整场景：购物车折扣计算

```dart
void main() {
  // 商品价格表（模拟）
  const prices = {'apple': 5.0, 'banana': 3.0, 'milk': 12.5};

  // 用户购物车：商品名 → 数量
  final cart = {'apple': 3, 'banana': 5, 'milk': 2};

  // 计算总价：数量 * 单价 累加
  var total = 0.0;
  cart.forEach((name, qty) {
    // ?? 0.0：如果价格表里没这个商品，按 0 处理（容错）
    final price = prices[name] ?? 0.0;
    total += price * qty;
  });

  // 满 50 打 9 折，满 100 打 8 折
  final discount = total >= 100 ? 0.8 : (total >= 50 ? 0.9 : 1.0);

  // ~/ 整除取整折后整数元；保留两位小数则用 toStringAsFixed
  final finalPrice = total * discount;

  print('原价: ${total.toStringAsFixed(2)} 元');
  print('折扣: ${(discount * 10).toStringAsFixed(1)} 折');
  print('实付: ${finalPrice.toStringAsFixed(2)} 元');
}
```

---

## 4. 控制流

### 4.1 `if` / `else`

和 JS 一模一样，但**条件必须是 `bool`**：

```dart
final score = 87;

if (score >= 90) {
  print('优秀');
} else if (score >= 60) {
  print('及格');
} else {
  print('不及格');
}

// ❌ 下面的代码在 Dart 里编译报错
// if (score) print('xxx');  // score 不是 bool
```

### 4.2 `for` 循环

```dart
// 经典 for
for (var i = 0; i < 3; i++) {
  print(i);
}

// for-in（遍历可迭代对象，相当于 JS 的 for...of）
for (final fruit in ['apple', 'banana', 'orange']) {
  print(fruit);
}

// 拿到下标？两种写法
final list = ['a', 'b', 'c'];
for (var i = 0; i < list.length; i++) {
  print('$i: ${list[i]}');
}

// 或者用 indexed（Dart 3.0+，返回 Records）
for (final (i, v) in list.indexed) {
  print('$i: $v');
}
```

### 4.3 `while` / `do-while`

```dart
var n = 0;
while (n < 3) {
  print(n);
  n++;
}

do {
  print('至少执行一次');
} while (false);
```

### 4.4 `switch`：传统写法 + 3.0 表达式写法

**老写法（语句）：**

```dart
final day = 3;
switch (day) {
  case 1:
    print('周一');
    break;       // Dart 必须 break，没有 fallthrough
  case 6:
  case 7:
    print('周末');
    break;
  default:
    print('工作日');
}
```

**Dart 3.0+ 新写法（表达式 + 模式）：**

```dart
String label(int day) => switch (day) {
  1 => '周一',
  6 || 7 => '周末',           // 多个值用 ||
  >= 2 && <= 5 => '工作日',   // 范围模式
  _ => '未知',                // 通配（相当于 default）
};

print(label(3)); // 工作日
```

> 第 21 节会专门讲 patterns，这里先有个印象。

### 4.5 `break` / `continue` / 标签

```dart
outer:
for (var i = 0; i < 3; i++) {
  for (var j = 0; j < 3; j++) {
    if (i == 1 && j == 1) break outer;   // 跳出外层循环
    print('$i,$j');
  }
}
```

### 4.6 完整场景：成绩排名播报

```dart
void main() {
  // 班级成绩表：姓名 → 分数
  final scores = {
    '小新': 87,
    '美伢': 92,
    '广志': 55,
    '风间': 100,
    '正男': 38,
  };

  // 按分数从高到低排序：先转 entries 再排序
  final sorted = scores.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  // 用增强 switch 给每个分段贴标签
  String levelOf(int score) => switch (score) {
    100 => '满分🎉',
    >= 90 => 'A',
    >= 80 => 'B',
    >= 60 => 'C',
    _ => '不及格',
  };

  // for-in 配合 indexed 得到名次
  print('=== 班级排名 ===');
  for (final (rank, entry) in sorted.indexed) {
    final medal = switch (rank) {
      0 => '🥇',
      1 => '🥈',
      2 => '🥉',
      _ => '  ',
    };
    print('$medal ${rank + 1}. ${entry.key} - ${entry.value} 分 (${levelOf(entry.value)})');
  }
}
```

---

## 5. 集合：List / Set / Map / Iterable

### 5.1 List：有序列表（≈ JS Array）

```dart
// 字面量
final fruits = <String>['apple', 'banana', 'orange'];

// 长度可变
fruits.add('grape');
fruits.addAll(['mango', 'pear']);
fruits.removeAt(0);
print(fruits); // [banana, orange, grape, mango, pear]

// 固定长度（很少用）
final fixed = List<int>.filled(3, 0); // [0, 0, 0]
fixed[0] = 99;

// 生成器
final squares = List<int>.generate(5, (i) => i * i); // [0,1,4,9,16]

// 切片
print(fruits.sublist(1, 3));  // 包左不包右

// 不可变
final readonly = List<int>.unmodifiable([1, 2, 3]);
// readonly.add(4); // ❌ 抛 UnsupportedError
```

### 5.2 Set：去重无序集合

```dart
final tags = <String>{'flutter', 'dart', 'flutter'};
print(tags); // {flutter, dart}

tags.add('mobile');
tags.remove('dart');
print(tags.contains('flutter')); // true

// 集合运算
final a = {1, 2, 3};
final b = {2, 3, 4};
print(a.union(b));        // {1, 2, 3, 4}
print(a.intersection(b)); // {2, 3}
print(a.difference(b));   // {1}
```

### 5.3 Map：键值对（≈ JS Object/Map）

```dart
// 字面量
final user = <String, dynamic>{
  'name': '小新',
  'age': 5,
};

// 读 / 写
print(user['name']);
user['city'] = '春日部';

// 遍历
user.forEach((k, v) => print('$k=$v'));

// 安全取值
final age = user['age'] ?? 0;

// 是否包含
print(user.containsKey('city')); // true
```

> 🆚 TS 里 `Record<string, any>` 对应 Dart 的 `Map<String, dynamic>`。Dart 的 `Map` 是真正的运行时数据结构，不是对象本身的属性。

### 5.4 集合字面量的高级语法（Spread / If / For）

Dart 的集合字面量比 JS 强大得多：

```dart
final base = [1, 2, 3];

// 1) Spread（和 JS 一样）
final more = [0, ...base, 4]; // [0, 1, 2, 3, 4]

// 2) Null-aware spread
final List<int>? maybeNull = null;
final safe = [0, ...?maybeNull, 4]; // [0, 4]

// 3) collection if
const isVip = true;
final menu = [
  '首页',
  '订单',
  if (isVip) 'VIP 专区',  // 条件成立才插入
];

// 4) collection for
final doubled = [for (final x in base) x * 2]; // [2, 4, 6]

// 5) 综合：从用户列表生成 Map
const users = [
  ('小新', 5),
  ('美伢', 29),
];
final ageMap = {for (final (name, age) in users) name: age};
print(ageMap); // {小新: 5, 美伢: 29}
```

### 5.5 Iterable：链式操作（≈ JS 数组方法）

```dart
final nums = [1, 2, 3, 4, 5];

// map / where（filter）/ reduce / fold / any / every
final result = nums
    .where((x) => x.isEven)        // [2, 4]
    .map((x) => x * 10)            // [20, 40]
    .toList();                     // 注意：链式是 lazy，要 toList() 触发

print(nums.fold(0, (acc, x) => acc + x)); // 15
print(nums.any((x) => x > 4));            // true
print(nums.every((x) => x > 0));          // true

// 取首尾
print(nums.first);       // 1
print(nums.last);        // 5
print(nums.first.isEven); // false
```

> ⚠️ Dart 的 `where` / `map` 返回的是**懒 Iterable**，不是新 List，需要 `.toList()` 才物化。

### 5.6 完整场景：博客文章统计

```dart
void main() {
  // 文章数据：每篇含标题、作者、阅读量、标签
  final posts = [
    {'title': 'Dart 入门', 'author': '小新', 'views': 1200, 'tags': ['dart', '入门']},
    {'title': 'Flutter 状态管理', 'author': '美伢', 'views': 3400, 'tags': ['flutter', '进阶']},
    {'title': 'Dart 异步全解', 'author': '小新', 'views': 800, 'tags': ['dart', 'async']},
    {'title': 'Hello World', 'author': '风间', 'views': 50, 'tags': ['入门']},
  ];

  // 1) 总阅读量：fold 累加
  final totalViews = posts.fold<int>(0, (sum, p) => sum + (p['views'] as int));
  print('全站阅读量: $totalViews');

  // 2) 阅读量过千的文章标题：where + map
  final hotTitles = posts
      .where((p) => (p['views'] as int) >= 1000)
      .map((p) => p['title'] as String)
      .toList();
  print('热门文章: $hotTitles');

  // 3) 所有不重复标签：用 Set + 集合 for
  final allTags = <String>{
    for (final p in posts) ...(p['tags'] as List).cast<String>(),
  };
  print('所有标签: $allTags');

  // 4) 按作者聚合阅读量：手动 fold 成 Map
  final viewsByAuthor = <String, int>{};
  for (final p in posts) {
    final author = p['author'] as String;
    viewsByAuthor[author] = (viewsByAuthor[author] ?? 0) + (p['views'] as int);
  }
  print('作者贡献: $viewsByAuthor');
}
```

---

## 6. 函数

### 6.1 基本声明

```dart
// 完整写法
int add(int a, int b) {
  return a + b;
}

// 单表达式：箭头函数（注意 => 后面是表达式，不是函数体）
int add2(int a, int b) => a + b;

// 不写返回类型默认是 dynamic（不推荐）
greet(String name) => print('Hello, $name');
```

### 6.2 参数：位置参数 / 命名参数 / 可选

Dart 的参数系统比 JS 更精细：

```dart
// 1) 必选位置参数（最常见）
int sum(int a, int b) => a + b;

// 2) 可选位置参数：用 [] 包起来，必须有默认值或加 ?
String greet(String name, [String? title]) {
  return title == null ? 'Hi, $name' : 'Hi, $title $name';
}
greet('小新');              // Hi, 小新
greet('小新', '老师');       // Hi, 老师 小新

// 3) 命名参数：用 {} 包起来，调用时用 name: value，默认是可选
String build({String? color, int? size}) {
  return 'color=$color, size=$size';
}
build(color: 'red', size: 10);
build(size: 10);              // color 可省略

// 4) 必选命名参数：在前面加 required
String createUser({required String name, int age = 18}) {
  return '$name ($age)';
}
createUser(name: '小新');      // ✅
// createUser();              // ❌ 必须传 name
```

> 💡 **强烈推荐**多参数函数都用命名参数 + `required`，可读性远胜 JS 的位置参数。

### 6.3 函数是一等公民

```dart
// 函数类型
int Function(int, int) op = (a, b) => a + b;
print(op(3, 4)); // 7

// 高阶函数
List<int> mapBy(List<int> list, int Function(int) fn) {
  return [for (final x in list) fn(x)];
}
print(mapBy([1, 2, 3], (x) => x * x)); // [1, 4, 9]

// 匿名函数（lambda）
[1, 2, 3].forEach((x) {
  print(x);
});
```

### 6.4 完整场景：可配置的日志格式化

```dart
// 日志级别
enum LogLevel { info, warn, error }

/// 创建一个日志函数。
///
/// [tag] 必选：日志归属模块。
/// [withTime] 可选：是否打印时间戳，默认 true。
/// [formatter] 可选：自定义格式化函数；不传则用默认格式。
void Function(LogLevel, String) createLogger({
  required String tag,
  bool withTime = true,
  String Function(LogLevel, String)? formatter,
}) {
  // 默认格式化器：[INFO] message
  String defaultFormatter(LogLevel level, String msg) =>
      '[${level.name.toUpperCase()}] $msg';

  // ?? 选择自定义或默认
  final fmt = formatter ?? defaultFormatter;

  return (LogLevel level, String message) {
    final timePart = withTime ? '${DateTime.now().toIso8601String()} ' : '';
    print('$timePart[$tag] ${fmt(level, message)}');
  };
}

void main() {
  // 默认格式
  final orderLog = createLogger(tag: 'OrderModule');
  orderLog(LogLevel.info, '订单创建成功');
  orderLog(LogLevel.error, '支付失败');

  // 自定义格式（带 emoji）
  final paymentLog = createLogger(
    tag: 'Payment',
    withTime: false,
    formatter: (lv, msg) => switch (lv) {
      LogLevel.info => 'ℹ️  $msg',
      LogLevel.warn => '⚠️  $msg',
      LogLevel.error => '🔥 $msg',
    },
  );
  paymentLog(LogLevel.warn, '余额不足');
}
```

---

## 7. 作用域与闭包

### 7.1 词法作用域（和 JS 完全一致）

```dart
final outer = 'A';

void f() {
  final inner = 'B';
  print(outer); // ✅ 能访问外层
  print(inner); // ✅
}

// print(inner); // ❌ 外层访问不到内层
```

### 7.2 闭包：函数捕获词法变量

```dart
/// 创建一个累加器：每次调用返回累计值。
int Function(int) makeAdder(int initial) {
  var total = initial;        // 被闭包捕获
  return (int delta) {
    total += delta;           // 持续修改外层局部变量
    return total;
  };
}

void main() {
  final adder = makeAdder(10);
  print(adder(5));   // 15
  print(adder(3));   // 18
  print(adder(-2));  // 16

  // 两个累加器互不影响（各自的 total 是独立的）
  final adder2 = makeAdder(100);
  print(adder2(1));  // 101
  print(adder(1));   // 17（不受 adder2 影响）
}
```

### 7.3 完整场景：限流器（节流）

```dart
/// 创建一个限流函数：每 [intervalMs] 毫秒最多触发一次回调。
///
/// 这是闭包的典型应用：把"上次触发时间"藏在闭包里。
void Function() throttle(void Function() action, int intervalMs) {
  // 闭包捕获的状态
  DateTime? lastFired;

  return () {
    final now = DateTime.now();
    // null + ?? 兜底：如果还没触发过，认为间隔无穷大
    final elapsed = lastFired == null
        ? intervalMs
        : now.difference(lastFired!).inMilliseconds;

    if (elapsed >= intervalMs) {
      lastFired = now;
      action();
    } else {
      print('  (被节流：距上次仅 ${elapsed}ms)');
    }
  };
}

void main() async {
  var counter = 0;
  final tick = throttle(() {
    counter++;
    print('触发！第 $counter 次');
  }, 200);

  // 模拟 10 次快速点击，每隔 50ms 触发
  for (var i = 0; i < 10; i++) {
    tick();
    await Future.delayed(const Duration(milliseconds: 50));
  }
}
```

---

## 8. 类（基础）

### 8.1 最简单的类

```dart
class Point {
  // 字段
  double x;
  double y;

  // 构造函数（this.x 是参数自动赋值字段的简写）
  Point(this.x, this.y);

  // 实例方法
  double distanceTo(Point other) {
    final dx = x - other.x;
    final dy = y - other.y;
    return (dx * dx + dy * dy).abs(); // 简化：返回平方距离
  }

  // 重写 toString，print 时自动调用
  @override
  String toString() => 'Point($x, $y)';
}

void main() {
  // 注意：Dart 创建对象**不需要 new**（new 关键字可选，习惯上不写）
  final a = Point(0, 0);
  final b = Point(3, 4);
  print(a.distanceTo(b)); // 25
  print(b);               // Point(3.0, 4.0)
}
```

### 8.2 字段：`final` / `late` / `static`

```dart
class User {
  // final 字段：构造完成后不可变（最常用！）
  final String name;
  final int age;

  // late：延迟初始化，第一次访问前赋值即可
  // 适合：依赖 this 才能算出来的字段、单元测试需要替换的字段
  late final String displayName = '$name ($age)';

  // 静态字段（属于类，不属于实例）
  static int instanceCount = 0;

  // 静态常量
  static const int maxAge = 150;

  User(this.name, this.age) {
    instanceCount++;
  }

  // 静态方法
  static User guest() => User('访客', 0);
}

void main() {
  final u1 = User('小新', 5);
  print(u1.displayName);         // 小新 (5)
  print(User.instanceCount);     // 1
  print(User.maxAge);            // 150
  print(User.guest());
}
```

### 8.3 Getter / Setter

```dart
class Rectangle {
  double width;
  double height;

  Rectangle(this.width, this.height);

  // Getter：像访问字段一样调用
  double get area => width * height;
  double get perimeter => 2 * (width + height);

  // Setter：可以做校验
  set size(double value) {
    if (value <= 0) throw ArgumentError('size 必须为正数');
    width = value;
    height = value;
  }
}

void main() {
  final r = Rectangle(3, 4);
  print(r.area);       // 12（不是 r.area()，是属性）
  r.size = 5;
  print(r.area);       // 25
}
```

### 8.4 私有：以 `_` 开头

```dart
class BankAccount {
  final String owner;
  double _balance;             // _ 开头，库外不可访问

  BankAccount(this.owner, this._balance);

  double get balance => _balance;     // 暴露只读

  void deposit(double amount) {
    if (amount <= 0) throw ArgumentError();
    _balance += amount;
  }
}
```

> ⚠️ Dart 的私有以**库（文件）为边界**：同一个 .dart 文件内可以互相访问 `_xxx`，跨文件就不行（除非 `part` 同一库）。

### 8.5 完整场景：温度传感器

```dart
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
```

---

## 9. 继承、抽象类、多态

### 9.1 继承：`extends`

```dart
class Animal {
  final String name;
  Animal(this.name);

  void breathe() => print('$name 在呼吸');
}

class Dog extends Animal {
  // 调用父类构造函数（只能用 super，不能用 this）
  Dog(super.name);   // Dart 2.17+ 的 super 参数语法

  void bark() => print('$name: 汪汪!');
}

void main() {
  final d = Dog('小白');
  d.breathe();   // 继承自 Animal
  d.bark();      // Dog 自己的
}
```

### 9.2 方法重写：`@override`

```dart
class Bird extends Animal {
  Bird(super.name);

  // 子类重写父类方法（@override 不是必需，但强烈推荐：拼错时编译报错）
  @override
  void breathe() {
    super.breathe();             // 还能调父类原方法
    print('$name 还会用气囊呼吸');
  }
}
```

### 9.3 抽象类：`abstract`

抽象类无法实例化，用来定义"模板"。

```dart
abstract class Shape {
  // 抽象方法：没有实现，子类必须提供
  double area();

  // 也可以有具体方法
  void describe() => print('一个 ${runtimeType}，面积 ${area()}');
}

class Circle extends Shape {
  final double radius;
  Circle(this.radius);

  @override
  double area() => 3.14159 * radius * radius;
}

class Square extends Shape {
  final double side;
  Square(this.side);

  @override
  double area() => side * side;
}

void main() {
  // ❌ Shape();  // 不能 new 抽象类
  final shapes = <Shape>[Circle(3), Square(5)];
  for (final s in shapes) {
    s.describe();   // 多态：实际调用各自的 area()
  }
}
```

### 9.4 完整场景：游戏角色继承体系

```dart
abstract class Character {
  final String name;
  int hp;          // 生命值
  int level;

  Character(this.name, {this.hp = 100, this.level = 1});

  /// 抽象：每个职业的攻击方式不同，子类必须实现
  int attack();

  /// 通用：受伤
  void takeDamage(int dmg) {
    hp -= dmg;
    if (hp < 0) hp = 0;
    print('$name 受到 $dmg 伤害，剩余 HP: $hp');
  }

  /// 通用：是否阵亡
  bool get isDead => hp <= 0;

  @override
  String toString() => '$name (Lv.$level, HP:$hp)';
}

class Warrior extends Character {
  Warrior(super.name) : super(hp: 150);   // 战士血更厚

  @override
  int attack() {
    final dmg = 20 + level * 3;
    print('$name 挥剑斩击！造成 $dmg 物理伤害');
    return dmg;
  }
}

class Mage extends Character {
  int mp;  // 法力值，子类独有字段

  Mage(super.name, {this.mp = 80});

  @override
  int attack() {
    if (mp < 10) {
      print('$name 法力不足，普攻 5 点');
      return 5;
    }
    mp -= 10;
    final dmg = 35 + level * 5;
    print('$name 释放火球术！造成 $dmg 法术伤害（剩余 MP: $mp）');
    return dmg;
  }
}

void main() {
  // 多态：用父类引用持有不同子类
  final List<Character> party = [
    Warrior('阿尔斯'),
    Mage('美琪'),
  ];

  // 模拟一场战斗：每人攻击一个 Boss
  final boss = Warrior('史莱姆王')..hp = 200;

  for (final hero in party) {
    final dmg = hero.attack();
    boss.takeDamage(dmg);
    if (boss.isDead) {
      print('${boss.name} 已被击败！');
      break;
    }
  }
}
```

---

## 10. 接口与 implements

**Dart 的关键认知：每一个类都隐式地是一个接口。** 没有 TS 的 `interface` 关键字。

### 10.1 用 `implements` 实现"接口"

```dart
// 这就是一个普通类，但可以被任何类 implements
class Logger {
  void log(String msg) => print('LOG: $msg');
}

// implements 表示"我承诺有 Logger 的所有 API"，但**不会继承实现**
class FileLogger implements Logger {
  // 必须重新实现 log（因为 implements 不带实现）
  @override
  void log(String msg) {
    // 这里假装写到文件
    print('FILE: $msg');
  }
}
```

> 🆚 `extends` 一次只能一个，`implements` 可以多个，类似 TS 的 `class A implements I1, I2`。

### 10.2 抽象类作"纯接口"

实践中，"接口"通常用 `abstract class` 或 `abstract interface class`（3.0+）声明，更明确意图：

```dart
abstract interface class Repository<T> {
  Future<T?> findById(String id);
  Future<List<T>> findAll();
  Future<void> save(T item);
  Future<void> delete(String id);
}
```

### 10.3 完整场景：可序列化与可比较

```dart
// 接口 1：能转 JSON
abstract interface class JsonSerializable {
  Map<String, dynamic> toJson();
}

// 接口 2：能比较新旧
abstract interface class Versioned {
  int get version;
}

// 一个类同时实现两个接口（用逗号分隔）
class Article implements JsonSerializable, Versioned {
  final String id;
  final String title;
  @override
  final int version;

  Article(this.id, this.title, {this.version = 1});

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'version': version,
      };
}

class Comment implements JsonSerializable {
  final String text;
  Comment(this.text);

  @override
  Map<String, dynamic> toJson() => {'text': text};
}

/// 工具函数：只关心"能不能 toJson"，不关心具体类型
void persist(JsonSerializable item) {
  print('保存: ${item.toJson()}');
}

void main() {
  persist(Article('a1', 'Dart 进阶'));   // ✅
  persist(Comment('好文章'));             // ✅

  // Article 既是 JsonSerializable 又是 Versioned，可以作为两种"接口"传递
  final Versioned v = Article('a2', 'Flutter');
  print('版本: ${v.version}');
}
```

---

## 11. 类修饰符（Dart 3.0+）

Dart 3.0 引入了 **class modifiers**，给类的能力更精细的控制。这是 TS 完全没有的。

| 修饰符        | 同库 `extend` | 同库 `implement` | 跨库 `extend`                   | 跨库 `implement` | 备注                       |
| ------------- | ------------- | ---------------- | ------------------------------- | ---------------- | -------------------------- |
| 默认 `class`  | ✅            | ✅               | ✅                              | ✅               |                            |
| `abstract`    | ✅            | ✅               | ✅                              | ✅               | 不能实例化                 |
| `base`        | ✅①           | ✅①              | ✅①                             | ❌               | 强制继承实现，禁止外部实现 |
| `interface`   | ✅            | ✅               | ❌                              | ✅               | 跨库只能 implement         |
| `final`       | ✅①           | ✅①              | ❌                              | ❌               | 跨库完全封闭               |
| `sealed`      | ✅②           | ✅②              | ❌                              | ❌               | 隐式 abstract，用于穷举    |
| `mixin class` | ✅            | ✅               | ✅                              | ✅               | 还能作为 mixin 用          |

> **① 传染规则**：`base` / `final` / `sealed` 的子类也必须带 `base`、`final` 或 `sealed`，即便在同库内。修饰符在继承链上只能越来越严格，不能"解锁"回普通 `class`。
>
> **② `sealed` 额外约束**：子类必须在**同一个文件**（比同库更严格），不能跨文件。

### 11.1 `final class`：彻底封闭

```dart
final class Money {
  final int cents;
  const Money(this.cents);
}

// 跨库都不能 extends 也不能 implements，避免被误用
```

适合：值对象（Value Object）、内部工具类。

### 11.2 `base class`：强制继承实现，禁止外部 implements

```dart
base class HttpClient {
  void _log(String msg) { ... }  // 内部实现逻辑
  void send(String body) { ... }
}

// 使用方：
class MyClient extends HttpClient { ... }     // ✅ 继承基础能力
class MyClient implements HttpClient { ... }  // ❌ 禁止绕过核心实现
```

**为什么用**：你想让使用者继承你的实现（`extends`），继承链能保留 `super` 调用和内部逻辑；但不想让他们重写一套（`implements`），那样所有逻辑都会被绕过。

适合：框架基类（Widget、Controller）、有内部不变量需要保护的类。

### 11.3 `interface class`：只能被实现，不能被继承

```dart
interface class Printer {
  void print(String s) => print(s);
}

// 跨库时：
// class A extends Printer {}      // ❌
// class A implements Printer {}   // ✅
```

### 11.4 `sealed class`：闭合的子类集合（穷举模式匹配的关键）

```dart
sealed class Shape {}

final class Circle extends Shape {
  final double r;
  Circle(this.r);
}

final class Square extends Shape {
  final double side;
  Square(this.side);
}

double area(Shape s) => switch (s) {
  Circle(:final r) => 3.14 * r * r,
  Square(:final side) => side * side,
  // 不需要 default！编译器知道只有这两种情况，且自动检查
};
```

> 🌟 这是 Dart 3.0 最香的特性之一：编译器**强制穷举**，新增子类时所有 switch 立刻报错。

### 11.5 完整场景：API 响应建模

```dart
// 用 sealed 表示"响应只可能是这三种之一"
sealed class ApiResult<T> {
  const ApiResult();
}

final class Success<T> extends ApiResult<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends ApiResult<T> {
  final String message;
  final int? code;
  const Failure(this.message, {this.code});
}

final class Loading<T> extends ApiResult<T> {
  const Loading();
}

/// 把响应渲染成 UI 文本（实际项目里换成 Widget）
String render<T>(ApiResult<T> r) {
  // sealed + switch：编译器保证所有分支被处理
  return switch (r) {
    Loading() => '⏳ 加载中…',
    Success(:final data) => '✅ 数据: $data',
    Failure(:final message, :final code) => '❌ [$code] $message',
  };
}

void main() {
  print(render(const Loading<int>()));
  print(render(const Success(42)));
  print(render(const Failure<int>('网络错误', code: 500)));
}
```

### 11.6 `base` / `final` / `sealed` 使用场景对比

| 修饰符 | 一句话 | 典型场景 |
|--------|--------|---------|
| `base` | 继承我的实现，别另起炉灶 | 框架基类、有内部不变量需保护的类 |
| `final` | 我就长这样，别来沾边 | 值对象（Money、Email）、工具类 |
| `sealed` | 所有可能情况都在我这，编译器帮我查漏 | 状态机、网络结果、AST 节点 |

> 三者的共同点：跨库都**禁止 `implements`**，防止外部绕过你的实现。
> 三者的区别：对跨库 `extends` 的封锁程度不同 — `base` 开放、`final` 禁止、`sealed` 禁止且限定子类同文件。

---

## 12. 构造函数全攻略

Dart 的构造函数比 TS 灵活得多，至少有 6 种形态。

### 12.1 默认构造 + `this.x` 简写

```dart
class Book {
  final String title;
  final String author;

  // this.xxx 形参直接给字段赋值，最常用
  Book(this.title, this.author);
}
```

### 12.2 命名参数构造（推荐，可读性高）

```dart
class Book {
  final String title;
  final String author;
  final int? pages;

  Book({required this.title, required this.author, this.pages});
}

// 调用
final b = Book(title: 'Dart 实战', author: '小新');
```

### 12.3 命名构造函数：同一类多种创建方式

```dart
class Color {
  final int r, g, b;

  Color(this.r, this.g, this.b);

  // 命名构造：类名.名字
  Color.black() : r = 0, g = 0, b = 0;
  Color.white() : r = 255, g = 255, b = 255;

  // 从 hex 字符串解析
  Color.fromHex(String hex)
      : r = int.parse(hex.substring(1, 3), radix: 16),
        g = int.parse(hex.substring(3, 5), radix: 16),
        b = int.parse(hex.substring(5, 7), radix: 16);
}

void main() {
  final c1 = Color.black();
  final c2 = Color.fromHex('#FF8800');
  print('${c2.r}, ${c2.g}, ${c2.b}'); // 255, 136, 0
}
```

### 12.4 初始化列表（: 后面）

适合"字段在构造体之前就要有值，但又需要计算"的场景：

```dart
class Vector {
  final double x, y;
  final double length; // 派生字段

  Vector(this.x, this.y) : length = (x * x + y * y);
  // 注意：初始化列表里不能用 this.length，因为对象还没造好
}
```

### 12.5 重定向构造：调用同类的另一个构造

```dart
class Rect {
  final double w, h;
  Rect(this.w, this.h);

  // 重定向：把 square(side) 转化为 Rect(side, side)
  Rect.square(double side) : this(side, side);
}
```

### 12.6 工厂构造 `factory`：可以返回缓存或子类

```dart
class Logger {
  static final Map<String, Logger> _cache = {};
  final String name;

  Logger._internal(this.name);

  // factory 不要求每次返回新实例，可以返回缓存
  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }
}

void main() {
  final a = Logger('OrderService');
  final b = Logger('OrderService');
  print(identical(a, b)); // true，工厂返回了同一个实例
}
```

### 12.7 常量构造 `const`：编译期对象

```dart
class Point {
  final double x, y;
  const Point(this.x, this.y);   // 字段必须 final
}

const p1 = Point(0, 0);
const p2 = Point(0, 0);
print(identical(p1, p2));       // true！const 对象会被规范化（去重）
```

### 12.8 完整场景：HTTP 请求建模

```dart
class HttpRequest {
  final String url;
  final String method;
  final Map<String, String> headers;
  final Object? body;
  final Duration timeout;

  // 主构造（私有）：保证字段完整
  const HttpRequest._({
    required this.url,
    required this.method,
    required this.headers,
    this.body,
    this.timeout = const Duration(seconds: 30),
  });

  // 命名构造：GET 没 body
  const HttpRequest.get(
    String url, {
    Map<String, String> headers = const {},
    Duration timeout = const Duration(seconds: 30),
  }) : this._(
          url: url,
          method: 'GET',
          headers: headers,
          timeout: timeout,
        );

  // 命名构造：POST 必须有 body
  const HttpRequest.post(
    String url, {
    required Object body,
    Map<String, String> headers = const {},
  }) : this._(
          url: url,
          method: 'POST',
          headers: headers,
          body: body,
        );

  // 工厂构造：从快捷字符串解析
  factory HttpRequest.parse(String shortcut) {
    // 形如 "GET /api/users"
    final parts = shortcut.split(' ');
    if (parts.length != 2) {
      throw ArgumentError('格式错误，应为 "METHOD URL"');
    }
    final [method, url] = parts;       // 列表解构（第 21 节会讲）
    return method == 'GET'
        ? HttpRequest.get(url)
        : HttpRequest._(url: url, method: method, headers: const {});
  }

  @override
  String toString() => '$method $url ${body ?? ''}';
}

void main() {
  final r1 = HttpRequest.get('/api/posts');
  final r2 = HttpRequest.post('/api/posts', body: {'title': '测试'});
  final r3 = HttpRequest.parse('GET /api/users');
  print(r1);
  print(r2);
  print(r3);
}
```

---

## 13. Mixin

Mixin 解决了"想给类加一组能力，但又不想用继承"的问题。**TS 没有原生 mixin，要用装饰器或函数组合模拟。**

### 13.1 基本语法

```dart
// 1) mixin 类型：只能 with，不能 extends / 实例化
mixin Logging {
  void log(String msg) => print('[LOG] $msg');
}

// 2) 普通类用 with 引入 mixin
class Service with Logging {
  void doWork() {
    log('开始工作');
  }
}

void main() {
  Service().doWork();
}
```

### 13.2 多个 mixin 叠加

```dart
mixin Cacheable {
  final Map<String, Object?> _cache = {};
  T? getFromCache<T>(String key) => _cache[key] as T?;
  void putInCache(String key, Object? v) => _cache[key] = v;
}

mixin Auditable {
  final List<String> _audits = [];
  void audit(String action) => _audits.add(action);
  List<String> get audits => List.unmodifiable(_audits);
}

class UserService with Logging, Cacheable, Auditable {
  // 同时拥有三个 mixin 的能力
}

void main() {
  final s = UserService();
  s.log('启动');
  s.putInCache('u1', '小新');
  s.audit('查询用户 u1');
  print(s.getFromCache<String>('u1')); // 小新
  print(s.audits);
}
```

### 13.3 限定 mixin 适用范围：`on`

```dart
abstract class Animal {
  String get name;
}

// 只有 Animal 子类才能 with Trainable
mixin Trainable on Animal {
  void train() => print('$name 正在训练');
}

class Dog extends Animal with Trainable {
  @override
  final String name;
  Dog(this.name);
}

// class Stone with Trainable {} // ❌ Stone 不是 Animal 子类
```

### 13.4 完整场景：博客文章的能力组合

```dart
// 基础类
class Post {
  final String title;
  final String body;
  Post(this.title, this.body);
}

// Mixin 1：可点赞
mixin Likable {
  int _likes = 0;
  int get likes => _likes;
  void like() => _likes++;
  void unlike() {
    if (_likes > 0) _likes--;
  }
}

// Mixin 2：可评论
mixin Commentable {
  final List<String> _comments = [];
  List<String> get comments => List.unmodifiable(_comments);
  void comment(String text) => _comments.add(text);
}

// Mixin 3：可分享（仅适用于有 title 的 Post 子类）
mixin Sharable on Post {
  /// 复用父类的 title 字段
  String shareLink() => 'https://blog.com/share?t=${Uri.encodeComponent(title)}';
}

// 组合：一个完整的文章
class Article extends Post with Likable, Commentable, Sharable {
  Article(super.title, super.body);
}

// 另一个例子：草稿只能点赞，不能评论或分享
class Draft extends Post with Likable {
  Draft(super.title, super.body);
}

void main() {
  final a = Article('Dart Mixin 详解', '内容…');
  a.like();
  a.like();
  a.comment('好文！');
  a.comment('期待下一篇');
  print('点赞: ${a.likes}');
  print('评论: ${a.comments}');
  print('分享链接: ${a.shareLink()}');

  final d = Draft('草稿', '...');
  d.like();
  // d.comment('xxx');   // ❌ Draft 没 with Commentable
}
```

---

## 14. 泛型

### 14.1 泛型类

```dart
class Box<T> {
  T value;
  Box(this.value);

  T get content => value;
  void set(T newValue) => value = newValue;
}

void main() {
  final b1 = Box<int>(42);
  final b2 = Box<String>('hello');
  // b1.set('text');  // ❌ 类型错误
}
```

### 14.2 泛型方法

```dart
T firstOr<T>(List<T> list, T fallback) {
  return list.isEmpty ? fallback : list.first;
}

void main() {
  print(firstOr<int>([1, 2, 3], 0));   // 1
  print(firstOr(<String>[], 'NA'));    // NA（类型自动推导）
}
```

### 14.3 泛型约束：`extends`

```dart
// T 必须是 Comparable<T> 的子类
T maxOf<T extends Comparable<T>>(T a, T b) {
  return a.compareTo(b) >= 0 ? a : b;
}

void main() {
  print(maxOf(3, 7));         // 7
  print(maxOf('apple', 'banana')); // banana
  // maxOf(true, false);      // ❌ bool 不是 Comparable
}
```

### 14.4 完整场景：通用缓存仓储

```dart
/// 简易内存仓储：支持泛型 ID 与实体类型
class Repository<ID, T> {
  final Map<ID, T> _store = {};
  final ID Function(T) _idOf;     // 提取 ID 的函数

  Repository(this._idOf);

  /// 存储一个实体
  void save(T item) {
    final id = _idOf(item);
    _store[id] = item;
  }

  /// 按 ID 查找
  T? findById(ID id) => _store[id];

  /// 全部
  List<T> findAll() => _store.values.toList();

  /// 删除
  bool delete(ID id) => _store.remove(id) != null;

  /// 数量（getter）
  int get count => _store.length;
}

// 业务实体
class User {
  final int id;
  final String name;
  User(this.id, this.name);
  @override
  String toString() => 'User($id, $name)';
}

class Product {
  final String sku;
  final double price;
  Product(this.sku, this.price);
  @override
  String toString() => 'Product($sku, $price)';
}

void main() {
  // 同一个仓储类，承载不同类型实体
  final users = Repository<int, User>((u) => u.id);
  final products = Repository<String, Product>((p) => p.sku);

  users.save(User(1, '小新'));
  users.save(User(2, '美伢'));
  products.save(Product('SKU-001', 19.9));
  products.save(Product('SKU-002', 49.9));

  print(users.findById(1));         // User(1, 小新)
  print(products.findById('SKU-002')); // Product(SKU-002, 49.9)
  print('用户共 ${users.count} 人');
}
```

---

## 15. 枚举（基础与增强型）

### 15.1 基础枚举

```dart
enum Status { pending, active, inactive, deleted }

void main() {
  final s = Status.active;
  print(s);              // Status.active
  print(s.name);         // 'active'
  print(s.index);        // 1
  print(Status.values);  // [Status.pending, ...] 全部值
}
```

### 15.2 增强型枚举（Enhanced Enums）

Dart 2.17+ 起，枚举可以有字段、构造、方法，几乎像类一样强大：

```dart
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
```

### 15.3 完整场景：订单状态机

```dart
enum OrderStatus {
  /// 已下单，未支付
  created('待支付', '#FFA500'),

  /// 已支付，待发货
  paid('已支付', '#1E90FF'),

  /// 已发货
  shipped('运输中', '#9370DB'),

  /// 已签收
  completed('已完成', '#32CD32'),

  /// 已取消
  cancelled('已取消', '#A9A9A9');

  final String label;
  final String color;

  const OrderStatus(this.label, this.color);

  /// 是否可以取消
  bool get canCancel => this == OrderStatus.created || this == OrderStatus.paid;

  /// 是否是终态
  bool get isFinal => this == OrderStatus.completed || this == OrderStatus.cancelled;

  /// 合法的下一个状态（状态机迁移）
  List<OrderStatus> get nextStates => switch (this) {
        OrderStatus.created => [OrderStatus.paid, OrderStatus.cancelled],
        OrderStatus.paid => [OrderStatus.shipped, OrderStatus.cancelled],
        OrderStatus.shipped => [OrderStatus.completed],
        OrderStatus.completed || OrderStatus.cancelled => const [],
      };
}

class Order {
  final String id;
  OrderStatus status;
  Order(this.id) : status = OrderStatus.created;

  /// 安全迁移：只允许合法的下一个状态
  void transitionTo(OrderStatus next) {
    if (!status.nextStates.contains(next)) {
      throw StateError('订单 $id 不能从 $status 跳到 $next');
    }
    print('订单 $id: ${status.label} → ${next.label}');
    status = next;
  }
}

void main() {
  final o = Order('A001');
  o.transitionTo(OrderStatus.paid);
  o.transitionTo(OrderStatus.shipped);
  o.transitionTo(OrderStatus.completed);

  // 终态后再试取消会抛错
  try {
    o.transitionTo(OrderStatus.cancelled);
  } on StateError catch (e) {
    print('❌ ${e.message}');
  }
}
```

---

## 16. 异常处理与断言

### 16.1 抛 / 捕获

```dart
class InsufficientFundsException implements Exception {
  final double need;
  final double have;
  InsufficientFundsException({required this.need, required this.have});

  @override
  String toString() => '余额不足：需 $need，仅有 $have';
}

double withdraw(double balance, double amount) {
  if (amount > balance) {
    throw InsufficientFundsException(need: amount, have: balance);
  }
  return balance - amount;
}

void main() {
  try {
    withdraw(50, 100);
  } on InsufficientFundsException catch (e) {
    // 按异常类型捕获（推荐）
    print('⚠️ $e');
  } on FormatException catch (e) {
    print('格式错误: $e');
  } catch (e, stack) {
    // 兜底：捕获其他所有异常 + 堆栈
    print('未知错误: $e');
    print(stack);
  } finally {
    print('交易流程结束');
  }
}
```

> 💡 **`Exception` vs `Error`**：约定上 `Exception` 表示业务可恢复异常（要 catch），`Error` 表示程序 bug（不该 catch，比如 `TypeError`）。

### 16.2 重抛

```dart
try {
  doSomething();
} catch (e) {
  print('记录日志: $e');
  rethrow;  // 重新抛出原异常，保留堆栈
}
```

### 16.3 断言：`assert`

`assert` 只在 **debug 模式** 生效（dart run / Flutter debug build），release 模式会被剥离。

```dart
class Age {
  final int value;
  Age(this.value)
      : assert(value >= 0, '年龄不能为负'),
        assert(value <= 150, '年龄不应该超过 150');
}
```

### 16.4 完整场景：带重试的网络客户端

```dart
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
    final result = retry(api.fetch, maxRetries: 3);
    print(result);
  } on NetworkException catch (e) {
    print('最终失败: $e');
  }
}
```

---

## 17. 异步：Future / async / await

`Future<T>` 几乎等于 JS 的 `Promise<T>`，但更显式。

### 17.1 基础

```dart
// 模拟一个异步函数：1 秒后返回结果
Future<String> fetchUserName(int id) async {
  await Future.delayed(const Duration(seconds: 1));
  return '用户#$id';
}

void main() async {
  print('开始');
  final name = await fetchUserName(42);
  print('得到: $name');
  print('结束');
}
```

### 17.2 错误处理

```dart
Future<int> divide(int a, int b) async {
  if (b == 0) throw ArgumentError('除数为 0');
  return a ~/ b;
}

void main() async {
  // 推荐：try / catch（和同步代码一样）
  try {
    final r = await divide(10, 0);
    print(r);
  } catch (e) {
    print('错误: $e');
  }

  // 也可以用 Future API 风格
  divide(10, 0)
      .then((v) => print(v))
      .catchError((e) => print('链式错误: $e'));
}
```

### 17.3 并发：`Future.wait` / `Future.any`

```dart
Future<int> task(int id, int seconds) async {
  await Future.delayed(Duration(seconds: seconds));
  return id;
}

void main() async {
  // 并发：等所有完成（≈ Promise.all）
  final results = await Future.wait([
    task(1, 1),
    task(2, 2),
    task(3, 1),
  ]);
  print('全部完成: $results');

  // 谁先完成谁赢（≈ Promise.race）
  final winner = await Future.any([
    task(10, 3),
    task(20, 1),
    task(30, 2),
  ]);
  print('最快: $winner'); // 20
}
```

### 17.4 Stream：异步多次产值（≈ AsyncIterator）

```dart
/// 每秒产出一个递增的数字，共 [count] 个
Stream<int> counter(int count) async* {
  for (var i = 1; i <= count; i++) {
    await Future.delayed(const Duration(milliseconds: 500));
    yield i;     // 注意是 yield，不是 return
  }
}

void main() async {
  await for (final n in counter(5)) {
    print('收到: $n');
  }
  print('Stream 结束');
}
```

### 17.5 完整场景：并发抓取多个用户的资料

```dart
class UserProfile {
  final int id;
  final String name;
  final int posts;
  UserProfile(this.id, this.name, this.posts);
  @override
  String toString() => 'UserProfile(#$id, $name, ${posts}posts)';
}

/// 模拟"调用接口"获取一个用户的资料：随机延迟 + 偶发失败。
Future<UserProfile> fetchProfile(int id) async {
  await Future.delayed(Duration(milliseconds: 200 + id * 50));
  if (id == 7) throw Exception('用户 7 不存在');
  return UserProfile(id, '用户#$id', id * 3);
}

/// 批量并发拉取，单个失败不影响其他（用每个 future 单独 catch）。
Future<List<UserProfile>> fetchAll(List<int> ids) async {
  // 把每个 future 包装成"成功返回 UserProfile，失败返回 null"
  final futures = ids.map((id) async {
    try {
      return await fetchProfile(id);
    } catch (e) {
      print('  [跳过] id=$id 失败: $e');
      return null; // 失败用 null 占位
    }
  });

  final results = await Future.wait(futures);

  // 过滤掉 null 并断言非空
  return results.whereType<UserProfile>().toList();
}

void main() async {
  print('开始批量请求...');
  final stopwatch = Stopwatch()..start();
  final profiles = await fetchAll([1, 3, 5, 7, 9]);
  stopwatch.stop();
  print('---\n成功 ${profiles.length} 个，耗时 ${stopwatch.elapsedMilliseconds}ms');
  profiles.forEach(print);
}
```

---

## 18. 空安全（Null Safety）

Dart 2.12 起强制空安全，是 Dart 区别于很多语言的核心特性。

### 18.1 类型分两类

```dart
String s = 'hello';   // 不可为 null
String? s2 = null;    // 可为 null

// int? 字段没初始化时**默认是 null**
class A {
  int? a;             // ✅ 默认 null
  // int b;           // ❌ 必须初始化或加 ? 或加 late
}
```

### 18.2 `late`：延迟初始化的非空变量

```dart
class Service {
  // 承诺"用之前我会赋值"，但不立刻给
  late final HttpClient _client;

  void init() {
    _client = HttpClient();   // 只能赋值一次（因为 final）
  }

  void call() {
    _client.send();           // 用之前没初始化会运行时报错
  }
}
```

### 18.3 关键运算符回顾

```dart
String? maybe;

// ?. 安全调用
maybe?.length;              // null

// ?? 默认值
final n = maybe?.length ?? 0;

// ! 强制非空（断言）
maybe = 'abc';
final len = maybe!.length;  // 错误时崩，慎用
```

### 18.4 流敏感的类型提升（Type Promotion）

```dart
String? input;

// Dart 在 if 分支内自动把 input 视为 String（非空）
if (input != null) {
  print(input.length);   // ✅ 不需要 input!
}

// 但是！字段（field）不会被提升，因为可能被其他线程改
class Foo {
  String? name;
  void log() {
    if (name != null) {
      // print(name.length);  // ❌ 字段不提升
      print(name!.length);    // 必须 ! 或者拷到局部变量
    }
  }
}
```

### 18.5 完整场景：可选配置的合并

```dart
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
      host: other.host,                          // host 是必填，直接用 other
      port: other.port,                          // port 也必填
      proxy: other.proxy ?? proxy,               // 可空字段：other 没给则保留旧值
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
  const test = AppConfig(host: 'test.example.com', port: 8080, proxy: '127.0.0.1:7890');

  // 合并
  final merged = defaults.overrideWith(test);
  print(merged);
  // AppConfig(host=test.example.com, port=8080, proxy=127.0.0.1:7890, timeout=null)
}
```

---

## 19. 库系统：import / part / export / library

### 19.1 `import`：引入其他库

```dart
// 引核心库（dart:xxx 是内置）
import 'dart:async';
import 'dart:io';

// 引项目内文件
import 'models/user.dart';

// 引 pub 包
import 'package:http/http.dart' as http;

// 别名 + show / hide：精确控制可见符号
import 'utils.dart' show formatDate, parseDate;
import 'utils.dart' hide deprecatedFn;
```

### 19.2 私有：以 `_` 开头

```dart
// utils.dart
String _internal() => 'secret';   // 跨文件不可见
String public() => _internal();   // 同一库内可访问
```

### 19.3 `part` / `part of`：拆分大库

```dart
// my_lib.dart（主库）
library my_lib;
part 'models.dart';
part 'services.dart';

// models.dart（子文件）
part of 'my_lib.dart';
class User { /* 可访问主库的私有成员 */ }
```

> ⚠️ **现代 Dart 实践**：`part` 主要用于代码生成（如 freezed、json_serializable）。日常组织文件直接 `import` 就够了。

### 19.4 `export`：再导出，方便聚合

```dart
// models/index.dart  —— 入口聚合文件
export 'user.dart';
export 'order.dart';
export 'product.dart';

// 业务代码里只要一行就拿到所有
import 'models/index.dart';
```

### 19.5 完整场景：分层项目结构

```
lib/
├── shop.dart                    // 入口聚合：library shop;
├── src/
│   ├── models/
│   │   ├── user.dart
│   │   └── order.dart
│   ├── repositories/
│   │   └── order_repo.dart
│   └── utils/
│       └── _validators.dart     // _ 开头 = 内部私有，不导出
```

```dart
// shop.dart
library shop;

// 对外导出业务用得到的部分
export 'src/models/user.dart';
export 'src/models/order.dart';
export 'src/repositories/order_repo.dart';
// 注意：utils/_validators.dart 没 export，外部无法 import
```

```dart
// 使用方
import 'package:shop/shop.dart';

void main() {
  final u = User('小新');
  // ...
}
```

---

## 20. Records（元组）与解构

Dart 3.0 引入 **Records**，是真正的元组类型。**TS 用数组模拟元组，Dart 是独立类型。**

### 20.1 字面量与类型

```dart
// 位置字段
(int, String) pair = (1, 'one');
print(pair.$1);  // 1
print(pair.$2);  // one

// 命名字段（更推荐，可读性好）
({int x, int y}) point = (x: 3, y: 4);
print(point.x);  // 3
print(point.y);  // 4

// 混合：位置 + 命名
(int, String, {bool active}) row = (1, 'Alice', active: true);
print(row.$1);
print(row.active);
```

### 20.2 函数返回多值（Records 杀手锏）

```dart
({double mean, double max, double min}) stats(List<double> xs) {
  if (xs.isEmpty) return (mean: 0, max: 0, min: 0);
  final sum = xs.fold<double>(0, (a, b) => a + b);
  return (
    mean: sum / xs.length,
    max: xs.reduce((a, b) => a > b ? a : b),
    min: xs.reduce((a, b) => a < b ? a : b),
  );
}

void main() {
  final s = stats([3.0, 5.0, 2.0, 8.0]);
  print('avg=${s.mean}, max=${s.max}, min=${s.min}');
}
```

### 20.3 解构（Destructuring）

```dart
final point = (x: 3, y: 4);
final (x: a, y: b) = point;        // 改名解构
print('a=$a, b=$b');

// 列表解构
final [first, second, ...rest] = [1, 2, 3, 4, 5];
print('$first $second $rest');     // 1 2 [3, 4, 5]

// Map 解构
final {'name': name, 'age': age} = {'name': '小新', 'age': 5};
print('$name $age');
```

### 20.4 完整场景：分页查询返回多字段

```dart
/// 分页参数
typedef PageQuery = ({int page, int size, String? keyword});

/// 分页结果（Record 当返回类型，写起来比建一个类轻量）
typedef PageResult<T> = ({
  List<T> items,
  int total,
  int totalPages,
  bool hasMore,
});

/// 模拟：根据 keyword 在 source 里搜索并分页
PageResult<String> queryPage(List<String> source, PageQuery q) {
  // 1) 关键词过滤
  final filtered = q.keyword == null || q.keyword!.isEmpty
      ? source
      : source.where((x) => x.contains(q.keyword!)).toList();

  final total = filtered.length;
  final totalPages = (total / q.size).ceil();

  // 2) 切片
  final start = (q.page - 1) * q.size;
  final end = (start + q.size).clamp(0, total);
  final items = start >= total ? <String>[] : filtered.sublist(start, end);

  return (
    items: items,
    total: total,
    totalPages: totalPages,
    hasMore: q.page < totalPages,
  );
}

void main() {
  final cities = ['北京', '上海', '广州', '深圳', '杭州', '成都', '苏州', '南京'];

  // 解构返回值
  final (:items, :total, :totalPages, :hasMore) =
      queryPage(cities, (page: 2, size: 3, keyword: null));

  print('总数=$total, 总页数=$totalPages, 当前页结果=$items, 还有？$hasMore');
}
```

---

## 21. 模式匹配 Patterns（Dart 3.0+）

Patterns 是 Dart 3.0 最大的语法升级。用一句话总结：**把"判断结构"和"取值"合并成一步**。

### 21.1 三大使用位置

```dart
// 1) switch 表达式
final desc = switch (value) { /* ... */ };

// 2) if-case
if (value case <pattern>) { /* ... */ }

// 3) 解构（变量声明）
final <pattern> = expression;
```

### 21.2 常用模式

```dart
final value = (1, 'hi', [10, 20]);

// 解构 record + 列表 + 通配符
if (value case (final n, _, [final first, ...])) {
  print('n=$n, first=$first');  // n=1, first=10
}

// 类型 + 字段（对象模式）
class User {
  final String name;
  final int age;
  User(this.name, this.age);
}

final u = User('小新', 5);
if (u case User(name: 'Alice', age: > 18)) {
  print('成年的 Alice');
} else if (u case User(:final name, :final age) when age < 10) {
  print('小朋友 $name'); // ✅
}
```

### 21.3 守卫 `when`

```dart
String classify(int x) => switch (x) {
  0 => '零',
  > 0 && < 10 => '小正数',
  > 0 when x.isEven => '大偶数',     // when 加额外条件
  > 0 => '大奇数',
  _ => '负数',
};
```

### 21.4 与 sealed 配合：穷举 + 解构

```dart
sealed class Event {}

class Click extends Event {
  final int x, y;
  Click(this.x, this.y);
}

class KeyPress extends Event {
  final String key;
  KeyPress(this.key);
}

class Scroll extends Event {
  final double dy;
  Scroll(this.dy);
}

String describe(Event e) => switch (e) {
  Click(:final x, :final y) when x == 0 && y == 0 => '点了原点',
  Click(:final x, :final y) => '点击 ($x, $y)',
  KeyPress(:final key) => '按下 $key',
  Scroll(:final dy) => '滚动 $dy',
  // 不需要 default，sealed 编译期保证完整
};
```

### 21.5 完整场景：解析 JSON 配置

```dart
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
```

---

## 22. 扩展方法（Extension Methods）

给现有类型加方法，不需要改源代码、不需要继承。**JS 用 prototype 也能做，但污染全局；TS 没原生支持。**

### 22.1 基础

```dart
extension StringExt on String {
  /// 反转字符串
  String reversed() => split('').reversed.join();

  /// 是否回文
  bool get isPalindrome => this == reversed();
}

void main() {
  print('hello'.reversed());     // olleh
  print('level'.isPalindrome);   // true
}
```

### 22.2 给数字加方法

```dart
extension DurationShortcut on int {
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
}

void main() async {
  await Future.delayed(2.seconds);   // 比 Duration(seconds: 2) 短得多
  print('${5.minutes.inSeconds} 秒'); // 300 秒
}
```

### 22.3 泛型扩展

```dart
extension ListExt<T> on List<T> {
  /// 安全地取索引，越界返回 null
  T? getOrNull(int i) => i >= 0 && i < length ? this[i] : null;

  /// 按谓词分组（返回符合 / 不符合两组）
  ({List<T> matched, List<T> rest}) partition(bool Function(T) test) {
    final matched = <T>[];
    final rest = <T>[];
    for (final x in this) {
      if (test(x)) {
        matched.add(x);
      } else {
        rest.add(x);
      }
    }
    return (matched: matched, rest: rest);
  }
}

void main() {
  final nums = [1, 2, 3, 4, 5];
  print(nums.getOrNull(10));     // null

  final (:matched, :rest) = nums.partition((x) => x.isEven);
  print('偶数=$matched 奇数=$rest');
}
```

### 22.4 完整场景：DateTime 友好工具

```dart
extension DateTimeFriendly on DateTime {
  /// 是否是今天
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// 友好显示：刚刚 / N 分钟前 / N 小时前 / N 天前 / 完整日期
  String get humanize {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60) return '刚刚';
    if (diff.inMinutes < 60) return '${diff.inMinutes} 分钟前';
    if (diff.inHours < 24) return '${diff.inHours} 小时前';
    if (diff.inDays < 7) return '${diff.inDays} 天前';
    return '$year-${_pad(month)}-${_pad(day)}';
  }

  /// 私有辅助：补 0
  String _pad(int n) => n.toString().padLeft(2, '0');
}

void main() {
  final now = DateTime.now();
  print(now.isToday);                     // true
  print(now.subtract(const Duration(minutes: 3)).humanize); // 3 分钟前
  print(now.subtract(const Duration(days: 10)).humanize);   // 类似 2026-04-17
}
```

---

## 23. 扩展类型（Extension Types，Dart 3.3+）

`extension type` 是 Dart 3.3 新增的"零成本包装"。运行时它就是底层值，编译时给它一层独立的类型外衣。**类似 TS 的"opaque type / branded type"，但 Dart 是语言级原生支持。**

### 23.1 类型安全的 ID

```dart
// 同样是 String，但编译期完全不能混用
extension type UserId(String value) {}
extension type OrderId(String value) {}

void deleteUser(UserId id) {
  print('删除用户 $id');
}

void main() {
  final uid = UserId('u-123');
  final oid = OrderId('o-456');

  deleteUser(uid);          // ✅
  // deleteUser(oid);       // ❌ 编译错误
  // deleteUser('u-789');   // ❌ 编译错误，普通 String 也不行
}
```

> 🌟 这是 TS 用 `type Brand<T, B> = T & { __brand: B }` 玩了多年的 hack 终于变成原生语法。

### 23.2 给底层类型加方法（接近 extension，但有"类型隔离"）

```dart
extension type Email(String value) {
  bool get isValid => RegExp(r'^.+@.+\..+$').hasMatch(value);
  String get domain => value.split('@').last;
}

void main() {
  final e = Email('alice@example.com');
  print(e.isValid);   // true
  print(e.domain);    // example.com
}
```

### 23.3 完整场景：金额（货币安全）

```dart
/// 用 cents（分）作为底层类型，避免浮点误差
extension type Money(int cents) {
  /// 命名构造：从元转换
  Money.fromYuan(double yuan) : this((yuan * 100).round());

  /// 加法：返回新 Money
  Money operator +(Money other) => Money(cents + other.cents);

  /// 减法
  Money operator -(Money other) => Money(cents - other.cents);

  /// 乘以数量
  Money operator *(int n) => Money(cents * n);

  /// 显示成 ¥xx.xx
  String format() {
    final yuan = cents ~/ 100;
    final rest = (cents % 100).toString().padLeft(2, '0');
    return '¥$yuan.$rest';
  }
}

void main() {
  final unit = Money.fromYuan(19.9);    // 1990 cents
  final total = unit * 3;               // 5970 cents
  final after = total - Money.fromYuan(5); // 5470
  print('${unit.format()} × 3 - ¥5 = ${after.format()}'); // ¥19.90 × 3 - ¥5 = ¥54.70

  // ❌ 不能和普通 int 混用，避免"忘了单位"导致的 bug
  // final wrong = unit + 100;   // 编译错误
}
```

> ⚠️ `extension type` 默认**不是 subtype**：`Money` 不是 `int`，不能直接传给收 `int` 的函数；要透传时加 `implements int`。

---

## 24. 单例模式

Dart 单例最优雅的写法（其他语言要绕一圈，Dart 有 factory 一招制敌）：

### 24.1 工厂构造法（推荐）

```dart
class Database {
  // 1) 静态字段缓存唯一实例
  static final Database _instance = Database._internal();

  // 2) 私有命名构造
  Database._internal() {
    print('Database 初始化（只会执行一次）');
  }

  // 3) 默认构造做成 factory，永远返回同一个
  factory Database() => _instance;

  // 业务方法
  void query(String sql) => print('执行: $sql');
}

void main() {
  final a = Database();
  final b = Database();
  print(identical(a, b)); // true
  a.query('SELECT 1');
}
```

### 24.2 完整场景：全局配置中心

```dart
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
```

---

## 25. 协变与方法重写规则

### 25.1 Dart 集合默认是协变的

```dart
class Animal {}
class Dog extends Animal {}

void main() {
  List<Dog> dogs = [Dog(), Dog()];
  List<Animal> animals = dogs;  // ✅ 允许（协变）
  // animals.add(Animal());     // 运行时报错：实际是 List<Dog>
}
```

> 🆚 这点和 Java 不一样（Java 的 `List<Dog>` 不是 `List<Animal>`）。Dart 默认**协变**，灵活但要小心。

### 25.2 方法重写的参数类型规则

**默认规则**：子类重写时，参数类型不能比父类更窄（必须更宽或一致）。

```dart
class AnimalShelter {
  void take(Animal a) {}
}

class DogShelter extends AnimalShelter {
  // ❌ 默认情况下编译错误：参数 Dog 比父类 Animal 窄
  // @override
  // void take(Dog a) {}
}
```

### 25.3 用 `covariant` 显式放宽

```dart
class AnimalShelter {
  // 标记 covariant：允许子类把参数收窄
  void take(covariant Animal a) {}
}

class DogShelter extends AnimalShelter {
  @override
  void take(Dog a) {        // 现在 OK
    print('狗舍只收狗');
  }
}
```

### 25.4 完整场景：动物医院的诊疗系统

```dart
abstract class Animal {
  final String name;
  Animal(this.name);
}

class Cat extends Animal {
  Cat(super.name);
  void purr() => print('$name 在咕噜咕噜');
}

class Dog extends Animal {
  Dog(super.name);
  void wag() => print('$name 摇尾巴');
}

abstract class Hospital {
  /// covariant 关键字：允许专科医院收窄类型
  void treat(covariant Animal patient);
}

/// 综合医院：处理任何动物
class GeneralHospital extends Hospital {
  @override
  void treat(Animal patient) {
    print('给 ${patient.name} 做基础检查');
  }
}

/// 猫专科：只收猫
class CatClinic extends Hospital {
  @override
  void treat(Cat patient) {       // 收窄到 Cat（合法因为父类标了 covariant）
    print('给猫 ${patient.name} 做猫专属检查');
    patient.purr();
  }
}

void main() {
  final hospitals = <Hospital>[GeneralHospital(), CatClinic()];

  // 注意：当 CatClinic 用 Hospital 引用调用、传入 Dog 时，
  // 静态类型检查能过，但运行时会因类型不匹配抛 TypeError。
  // 这就是 covariant 的"权力换责任"——你来保证类型正确。
  for (final h in hospitals) {
    try {
      h.treat(Cat('咪咪'));
    } catch (e) {
      print('  ⚠️ $e');
    }
  }
}
```

---

## 附录 A：与 TypeScript 的差异速查表

| 场景             | TypeScript                        | Dart 3.x                                                                   |
| ---------------- | --------------------------------- | -------------------------------------------------------------------------- |
| 变量             | `let x = 1` / `const PI = 3.14`   | `var x = 1` / `final x = 1` / `const PI = 3.14`                            |
| 字符串模板       | `` `Hello, ${name}` ``            | `'Hello, $name'`，复杂表达式 `'${a + b}'`                                  |
| 类型断言         | `value as number`                 | `value as int`（运行时检查，失败抛错）                                     |
| 类型守卫         | `typeof v === 'number'`           | `v is int`                                                                 |
| 可选属性         | `interface A { x?: number }`      | `class A { int? x; }` 或命名参数省略                                       |
| 默认参数         | `function f(x = 0)`               | `void f({int x = 0})` 或 `void f([int x = 0])`                             |
| 必填命名参数     | （没原生）                        | `void f({required String name})`                                           |
| 元组             | `[number, string]`                | `(int, String)` 或 `({int x, String y})`                                   |
| 解构             | `const { a, b } = obj`            | `final (a: a, b: b) = record;` / `final {'a': a, 'b': b} = map;`           |
| 接口             | `interface I { ... }`             | `abstract interface class I { ... }`，或任何 class 都隐式当接口            |
| 实现 / 继承      | `implements I` / `extends C`      | `implements I` / `extends C` / `with M`（mixin）                           |
| 泛型             | `<T extends Comparable>`          | `<T extends Comparable<T>>`                                                |
| 不可空           | `string` (with strictNullChecks)  | `String`（默认就不可空）                                                   |
| 可空             | `string \| null` 或 `string?`     | `String?`                                                                  |
| 链式安全         | `obj?.x?.y`                       | `obj?.x?.y`                                                                |
| 默认值           | `x ?? 0`                          | `x ?? 0`                                                                   |
| 不可变集合       | `readonly T[]` / `Object.freeze`  | `const [1, 2, 3]` / `List.unmodifiable(...)`                               |
| 模式匹配         | （没有，只能 if-else）            | `switch (x) { Pattern1 => ..., Pattern2 => ... }`                          |
| 枚举             | `enum E { A, B }`                 | `enum E { a, b; ... }`，可加字段、构造、方法                               |
| 异步             | `async function ... Promise<T>`   | `Future<T> ... async {}`                                                   |
| 流               | `AsyncIterator<T>` / `Observable` | `Stream<T>` / `async*` / `yield`                                           |
| 装饰器           | `@decorator`                      | 无装饰器；用 mixin / 代码生成（freezed、json_serializable）替代            |
| 单例             | 自己写或用 IoC                    | `factory` 默认构造 + 私有构造，3 行搞定                                    |
| Branded type     | `type X = string & { _: 'X' }`    | `extension type X(String value) {}` 原生支持                               |

---

## 附录 B：需要你补充确认的问题

下列问题与具体项目相关，本教程没有展开。如有需要，可基于本教程进一步深入：

1. **构建产物**：你的目标是命令行工具（`dart compile exe`）、Flutter 移动端、还是 Dart Web？不同目标对 `dart:io`、`dart:html`、`Isolate` 的可用性不同。
2. **状态管理**：如果是 Flutter，要不要进一步介绍 Provider / Riverpod / Bloc？
3. **JSON 序列化**：是否计划接入 `json_serializable` / `freezed` 等代码生成？这会涉及 `part`、`build_runner` 等工程化话题。
4. **Isolate 并发**：业务里有 CPU 密集任务吗？需要的话可补充 `Isolate.run` 与消息传递。
5. **测试**：是否需要 `package:test` 用法、`mockito`/`mocktail` 介绍？
6. **代码风格**：是否启用 `analysis_options.yaml` 的更严格 lints（如 `very_good_analysis`）？

如果对其中任意一项感兴趣，把对应的需求告诉我，可以为它单独写一份扩展教程。
