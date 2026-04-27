# Dart 从入门到进阶（面向 JS/TS 开发者）

> 本文档基于 `bin/` 目录下 100+ 个示例文件总结整理，按主题重新组织。每节末尾会附上对应的源文件链接，方便对照原始代码。
>
> 适合读者：**有 JS / TS 经验**，希望快速掌握 Dart 全部核心语法及 3.x 新特性的开发者。

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

| 维度       | JS/TS                            | Dart                                                                           |
| ---------- | -------------------------------- | ------------------------------------------------------------------------------ |
| 类型系统   | TS 是结构化类型（Structural）    | **名义类型（Nominal）**：声明 `implements X` 才算实现 X                        |
| 一切皆对象 | 数字 / 字符串是基本类型          | **一切皆对象**，`int` / `double` 也是对象，可以 `1.toString()`                 |
| `null`     | TS 通过 `strictNullChecks` 控制  | **强制空安全**：`String` 不能为 null，`String?` 才能                           |
| 私有       | TS 用 `private` 关键字（编译时） | 通过**变量名以 `_` 开头**实现，且**以文件（库）为边界**                        |
| 异步       | `Promise` + `async/await`        | `Future` + `async/await`，几乎一一对应                                         |
| 接口       | TS 的 `interface` 关键字         | **没有专门的 interface 关键字**（3.0 之前），任何类都可作为接口被 `implements` |
| 元组       | TS 用 `[T1, T2]`                 | Dart 3.0 引入 `Records`：`(T1, T2)`                                            |
| 模式匹配   | 几乎没有                         | Dart 3.0 引入完整的模式匹配系统                                                |

**思维转换要点：**

1. **没有 `===`**，所有 `==` 都可以被重载，默认比较 identity。
2. **没有 truthy/falsy**：`if (x)` 中 `x` 必须是 `bool`，`if (str)` 编译报错。
3. **变量未初始化的对象类型不能直接使用**，必须显式给值或加 `late` / `?`。
4. **构造函数特别强大**：命名构造函数、工厂构造函数、常量构造函数、初始化列表、重定向…

---

## 1. 程序入口、注释与运行

### 1.1 程序入口

```dart
void main() {
  print('你好，野原新之助！');
}
```

合法签名：

```dart
void main() {}
void main(List<String> args) {}                // 接收命令行参数
Future<void> main(List<String> args) async {}  // 异步入口
```

### 1.2 注释

```dart
// 单行注释

/* 多行注释 */

/// 文档注释（生成 API doc）
/// [a] 是第一个参数
int add(int a, int b) => a + b;
```

### 1.3 运行

```bash
dart run bin/dart_1.dart
```

> 源文件：[`bin/dart_1.dart`](bin/dart_1.dart) · [`bin/dart_2.dart`](bin/dart_2.dart) · [`bin/dart_13.dart`](bin/dart_13.dart)

---

## 2. 变量与基础类型

### 2.1 `var` / `final` / `const` / `late`

| 关键字  | 含义                     | 类比 TS             |
| ------- | ------------------------ | ------------------- |
| `var`   | 类型推断的可变变量       | `let`               |
| `final` | 运行时常量，只能赋值一次 | `const`（引用层面） |
| `const` | **编译期**常量           | `as const` 字面量   |
| `late`  | 延迟初始化               | TS 的 `!:`          |

```dart
void main() {
  const a = 1;
  var c = 3;
  final int d;

  c = 4;
  d = 5;
  // d = 6; // ❌

  // const f = DateTime.now(); // ❌ 不是编译期常量
  final DateTime e = DateTime.now(); // ✅
}
```

**`late` 典型用法：**

```dart
class Person {
  late String address;   // 承诺稍后赋值，避免 String?
  void init() => address = '北京';
}
```

> 源文件：[`bin/dart_4.dart`](bin/dart_4.dart) · [`bin/dart_35.dart`](bin/dart_35.dart) · [`bin/dart_95.dart`](bin/dart_95.dart)

### 2.2 数值：`int` / `double` / `num`

```dart
int a = 100;
double f1 = 100.1;
// int b = 100.1; // ❌ 不会自动截断

print(a.toDouble());       // 100.0
print(f1.toInt());         // 100
print((5 / 2).toInt());    // 2，注意 / 返回 double
num n = 1;
print(n is int);           // true
```

> 源文件：[`bin/dart_3.dart`](bin/dart_3.dart) · [`bin/dart_6.dart`](bin/dart_6.dart)

### 2.3 字符串

```dart
String s1 = 'hello';
String s2 = "world";
print('$s1 ${s2.length}');        // 插值

String multi = '''
hello
world
''';

print('张三' == '张三');            // true，按内容比较
```

> 源文件：[`bin/dart_3.dart`](bin/dart_3.dart)

### 2.4 布尔

```dart
bool ok = true;
print(1 == 2);        // false
print(1 != 2);        // true
// if ('str') { }     // ❌ 非 bool 不能作为条件
```

> 源文件：[`bin/dart_24.dart`](bin/dart_24.dart)

### 2.5 `dynamic`（类似 TS 的 `any`）

```dart
dynamic c = 10;
print(c is int);         // true
c = "hello";
print(c is String);      // true
print(c?.length);        // 5
```

注意 `Object` 和 `dynamic` 的区别：`Object` 严格，必须断言或检查；`dynamic` 可以直接调方法（运行时可能崩）。

> 源文件：[`bin/dart_8.dart`](bin/dart_8.dart) · [`bin/dart_103.dart`](bin/dart_103.dart)

### 2.6 类型判断与转换

```dart
var a = 1;
print(a is int);          // true
print(a is! double);      // true

int i = int.parse('123');
double d = double.parse('123.456');
String s = i.toString();

dynamic x = 'hello';
String s2 = x as String;  // as 强转
```

> 源文件：[`bin/dart_5.dart`](bin/dart_5.dart) · [`bin/dart_18.dart`](bin/dart_18.dart) · [`bin/dart_25.dart`](bin/dart_25.dart) · [`bin/dart_29.dart`](bin/dart_29.dart) · [`bin/dart_52.dart`](bin/dart_52.dart)

### 2.7 可选类型 `T?`

```dart
int? a;
a = null;

String? c;
print(c?.isEmpty);       // null（安全调用）
```

> 源文件：[`bin/dart_9.dart`](bin/dart_9.dart) · [`bin/dart_28.dart`](bin/dart_28.dart)

---

## 3. 运算符

### 3.1 算术 / 自增自减 / 复合赋值

```dart
int a = 1 + 2;
double d = 5 / 2;        // / 返回 double
int e = 5 ~/ 2;          // ~/ 整除

var x = 1;
print(x++);              // 1
print(++x);              // 3

double n = 1;
n += 1; n -= 1; n *= 2; n /= 2; n %= 1;
```

> 源文件：[`bin/dart_7.dart`](bin/dart_7.dart) · [`bin/dart_14.dart`](bin/dart_14.dart)

### 3.2 三目 / 空合并

```dart
var a = 1 == 2 ? 'a' : 'b';

String? name;
String n1 = name ?? 'Guest';        // 空合并
name ??= 'default';                 // 仅当为 null 时赋值
```

> 源文件：[`bin/dart_27.dart`](bin/dart_27.dart) · [`bin/dart_94.dart`](bin/dart_94.dart)

### 3.3 级联操作符 `..` / `?..`（Dart 独有）

```dart
class Person {
  String name = '张三';
  int age = 20;
  void showInfo() => print("$name, $age");
  void action() => print("action");
}

void main() {
  Person()
    ..action()
    ..showInfo()
    ..name = '李四'
    ..showInfo();

  Person? p;
  p?..action()..showInfo();  // 对象为 null 时整条链跳过
}
```

> 源文件：[`bin/dart_43.dart`](bin/dart_43.dart) · [`bin/dart_93.dart`](bin/dart_93.dart)

### 3.4 展开运算符 `...` / `...?`

```dart
var a = [1, 2, 3];
var b = [...a, 4, 5];

List<int>? maybe;
var c = [0, ...?maybe];      // maybe 为 null 时跳过

var m = {...{'a': 1}, 'b': 2};
```

> 源文件：[`bin/dart_16.dart`](bin/dart_16.dart) · [`bin/dart_19.dart`](bin/dart_19.dart)

---

## 4. 控制流

### 4.1 `if` / `while` / `do-while`

```dart
int count = 0;
while (count < 10) { count++; }

int n = 0;
do { n++; } while (n < 10);
```

### 4.2 `for` 三种形态

```dart
final list = [1, 2, 3];

for (var i = 0; i < list.length; i++) print(list[i]);
for (var item in list) print(item);
list.forEach((item) => print(item));
```

### 4.3 `switch`（Dart 3.0+ 大幅增强）

```dart
var color = 'red';
switch (color) {
  case 'red':   print('红'); break;
  case 'green':
  case 'blue':  print('绿或蓝'); break;
  default:      print('未知');
}

// switch 表达式
var label = switch (color) {
  'red' => '红',
  'green' || 'blue' => '绿或蓝',
  _ => '未知',
};
```

> 源文件：[`bin/dart_15.dart`](bin/dart_15.dart) · [`bin/dart_71.dart`](bin/dart_71.dart) · [`bin/dart_76.dart`](bin/dart_76.dart)

---

## 5. 集合：List / Set / Map / Iterable

### 5.1 List

```dart
List<int> list = [1, 2, 3];
List<int> zeros = List.filled(5, 0);
List<int> gen = List.generate(5, (i) => i * 2);   // [0,2,4,6,8]

list.add(4);
list.addAll([5, 6]);
list.remove(1);
list.removeAt(0);
list.removeLast();

print(list.first);
print(list.length);
print(list.contains(3));
print(list.indexOf(3));

list.where((x) => x > 1).toList();
list.map((x) => x * 2).toList();
list.sort();
list.reversed.toList();
list.sublist(1, 3);
list.join(',');
```

> 源文件：[`bin/dart_10.dart`](bin/dart_10.dart) · [`bin/dart_16.dart`](bin/dart_16.dart) · [`bin/dart_30.dart`](bin/dart_30.dart) · [`bin/dart_107.dart`](bin/dart_107.dart)

### 5.2 Set（无序不重复）

```dart
Set<int> s = {1, 2, 3};
s.add(4);
s.remove(1);
s.contains(2);

var a = {1, 2, 3, 4};
var b = {3, 4, 5, 6};
print(a.union(b));         // {1,2,3,4,5,6}
print(a.intersection(b));  // {3,4}
print(a.difference(b));    // {1,2}

// identity 比较而非 ==
var idSet = Set.identity();
```

> 源文件：[`bin/dart_17.dart`](bin/dart_17.dart)

### 5.3 Map

```dart
Map<String, int> m = {'a': 1, 'b': 2};
m['c'] = 3;
m.containsKey('a');
m.remove('a');
m.addAll({'d': 4});
m.addEntries([MapEntry('e', 5)]);

for (var k in m.keys) print(k);
for (var v in m.values) print(v);
for (var e in m.entries) print('${e.key}=${e.value}');
m.forEach((k, v) => print('$k=$v'));

// 合并（后者覆盖前者）
var merged = {...m, 'a': 100};

// List → Map
var pairs = [MapEntry('a', 1), MapEntry('b', 2)];
var map = Map.fromEntries(pairs);
```

> 源文件：[`bin/dart_19.dart`](bin/dart_19.dart) - [`bin/dart_23.dart`](bin/dart_23.dart)

### 5.4 Iterable vs List

`List` 是 `Iterable` 的子类型。`.map() / .where()` 返回 `Iterable`，需要 `.toList()` 物化。

> 源文件：[`bin/dart_26.dart`](bin/dart_26.dart)

---

## 6. 函数

### 6.1 基础

```dart
int add(int a, int b) { return a + b; }
int add2(int a, int b) => a + b;          // 箭头函数（仅单表达式）
```

### 6.2 可选参数：`[]` 位置 vs `{}` 命名

```dart
// [] 位置可选：顺序不能换，可省略
func2(int a, [int? b, int? c]) {}
func2(1);
func2(1, 2);
func2(1, 2, 3);

// {} 命名可选：必须按名字传，顺序可换；required 强制必传
func3(int a, {int b = 1, int? c, required int d}) {}
func3(1, d: 4);
func3(1, c: 3, d: 4, b: 2);
```

**对照 TS：**

- `[]` ≈ TS `(a: number, b?: number)`
- `{}` ≈ TS `({a, b}: {a: number, b?: number})`

> 源文件：[`bin/dart_31.dart`](bin/dart_31.dart)

### 6.3 函数类型 / `typedef` / 匿名函数

```dart
typedef Add = int Function(int, int);

int add(int a, int b) => a + b;

void main() {
  Add fn1 = add;
  int Function(int, int) fn2 = (a, b) => a + b;
  Function fn3 = () => print('hello');   // 最宽泛的函数类型

  // 立即执行（IIFE）
  ((String v) => print(v))('cat');
}
```

> 源文件：[`bin/dart_11.dart`](bin/dart_11.dart) · [`bin/dart_12.dart`](bin/dart_12.dart) · [`bin/dart_32.dart`](bin/dart_32.dart)

---

## 7. 作用域与闭包

```dart
int globalVariable = 10;

Function createClosure(int captured) {
  int local = 30;
  return () {
    print('global: $globalVariable');
    print('captured: $captured');
    print('local: $local');
  };
}

void main() {
  var f = createClosure(20);
  f();
  globalVariable = 999;
  f();   // global 输出 999：闭包持有变量引用
}
```

行为与 JS 闭包一致。

> 源文件：[`bin/dart_33.dart`](bin/dart_33.dart) · [`bin/dart_34.dart`](bin/dart_34.dart)

---

## 8. 类（基础）

### 8.1 最简类与构造函数简写

```dart
class Person {
  String name;
  int age;
  late String address;   // 延迟初始化

  Person(this.name, this.age);  // this 简写：自动把参数赋给同名字段

  void greet() {
    print('Hello, my name is $name and I am $age years old.');
  }
}

void main() {
  Person p = Person('John', 30);   // new 可省略
  p.greet();
  p.address = 'New York';
}
```

> 源文件：[`bin/dart_35.dart`](bin/dart_35.dart) · [`bin/dart_36.dart`](bin/dart_36.dart)

### 8.2 私有字段、Getter / Setter

**下划线 `_` 开头 = 库私有**。注意：**库（文件）级别的私有**，同一文件的其他类也能访问 `_xxx`。

```dart
class Student {
  String _name = '张三';
  int _age = 20;

  String get name => _name;

  set name(String value) {
    if (value.isNotEmpty) _name = value;
    else print('名字不能为空');
  }

  int get age => _age;
  set age(int v) {
    if (v > 0) _age = v; else print('年龄不能 < 0');
  }
}

var s = Student();
s.name = '李四';   // 调 setter（不写括号）
print(s.name);     // 调 getter
```

> 源文件：[`bin/dart_40.dart`](bin/dart_40.dart) · [`bin/outer/student.dart`](bin/outer/student.dart) · [`bin/outer/animal.dart`](bin/outer/animal.dart)

### 8.3 静态成员

```dart
class Student {
  String name = '张三';
  static String address = '北京';

  static void show() => print(address);

  void show2() {
    show();       // 实例方法可以调静态方法
    print(name);
  }
}

Student.show();           // 类名直接调
Student.address = '上海';
```

> 源文件：[`bin/dart_39.dart`](bin/dart_39.dart)

### 8.4 重写 `==` 与 `hashCode`

默认 `==` 比较的是对象 identity。要按值比较，**必须同时**重写两者：

```dart
class Person {
  String name;
  int age;
  Person(this.name, this.age);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Person && other.name == name && other.age == age;
  }

  @override
  int get hashCode => Object.hash(name, age);
}

print(Person('A', 1) == Person('A', 1));   // true
var s = {Person('A', 1), Person('A', 1)};
print(s.length);                            // 1
```

> 源文件：[`bin/dart_37.dart`](bin/dart_37.dart) · [`bin/dart_38.dart`](bin/dart_38.dart)

---

## 9. 继承、抽象类、多态

### 9.1 `extends` 与 super 简写

```dart
class Person {
  String name;
  int age;
  Person(this.name, this.age);
  void showInfo() => print("$name, $age");
  void action()   => print("Person action");
}

class Worker extends Person {
  String job;
  // super.name 是 Dart 2.17+ 的简写，等价于 : super(name, age)
  Worker(super.name, super.age, this.job);

  @override
  void showInfo() => print("$name, $age, $job");

  @override
  void action() => print("Worker action");
}
```

**Dart 是单继承**：一个类只能 `extends` 一个父类。

> 源文件：[`bin/dart_44.dart`](bin/dart_44.dart)

### 9.2 抽象类 `abstract`

抽象类不能被实例化；可以同时有抽象方法（无方法体）和普通方法。

```dart
abstract class Person {
  action();              // 抽象方法，子类必须实现
  void breath() {        // 普通方法，子类可不重写
    print('breath');
  }
}

class Worker extends Person {
  @override
  action() => print('实现 action');
}
```

> 源文件：[`bin/dart_45.dart`](bin/dart_45.dart)

### 9.3 多态

```dart
abstract class Person { action(); }
class Worker extends Person { @override action() => print('worker'); }
class Student extends Person { @override action() => print('student'); }

void perform(Person p) => p.action();

void main() {
  Person p = Worker();   // 父类引用指向子类对象
  p.action();            // 运行 Worker 的方法
  perform(Student());
}
```

> 源文件：[`bin/dart_46.dart`](bin/dart_46.dart)

---

## 10. 接口与 implements

**Dart 没有专用的 `interface` 关键字**（3.0 之前），**任何类都能作为接口被另一个类 `implements`**。

- `extends`：继承父类的实现。**只能一个**。
- `implements`：只借用类型形状。**必须实现接口的所有方法（哪怕父类已经给了实现也要重写）**。**可以多个**。

```dart
class Person {
  String name;
  int age;
  Person(this.name, this.age);
  void say() => print('$name, $age');
}

abstract class Work {
  String work;
  Work(this.work);
  workFor() => print('工作');
  workBy()  => print('学习');
}

class Worker extends Person implements Work {
  @override
  String work;          // implements 时，即便父类有字段也要重新声明
  String job;
  Worker(super.name, super.age, this.job, this.work);

  @override workFor() => print('我的工作');
  @override workBy()  => print('我的学习');
  @override say()     => print('$name-$age-$job-$work');
}
```

**关键点**：`implements` 不会继承实现，只借类型形状，全部方法都要重写。

> 源文件：[`bin/dart_47.dart`](bin/dart_47.dart)

---

## 11. 类修饰符（Dart 3.0+）

新增一组细粒度修饰符，控制类的**继承能力**与**实现能力**。

| 修饰符            | 库内 extends | 库外 extends | 库外 implements | 可实例化 |
| ----------------- | :----------: | :----------: | :-------------: | :------: |
| 默认 `class`      |      ✅      |      ✅      |       ✅        |    ✅    |
| `abstract class`  |      ✅      |      ✅      |       ✅        |    ❌    |
| `base class`      |      ✅      |      ✅      |       ❌        |    ✅    |
| `interface class` |      ✅      |      ❌      |       ✅        |    ✅    |
| `final class`     |      ❌      |      ❌      |       ❌        |    ✅    |
| `sealed class`    | ✅（限同库） |      ❌      |       ❌        |    ❌    |

### 11.1 `base`：禁止库外 implements

```dart
// bin/baseClass/base_class.dart
base class MyBaseClass {
  void myMethod() => print('base method');
}

// 在另一个文件里 import
// ❌ class Update extends MyBaseClass {}  // 库外不能 extends base 类
//   除非自己也是 base/final/sealed
```

> 源文件：[`bin/dart_88.dart`](bin/dart_88.dart) · [`bin/baseClass/base_class.dart`](bin/baseClass/base_class.dart)

### 11.2 `final`：完全禁止继承与实现

```dart
final class MyFinalClass {
  int id;
  String name;
  MyFinalClass(this.id, this.name);
}
// 任何文件都不能 extends / implements / with
```

> 源文件：[`bin/dart_89.dart`](bin/dart_89.dart)

### 11.3 `interface`：库外只能 implements，不能 extends

```dart
interface class Textable {
  void getText() => print('interface Text');
}

abstract interface class Drawable {
  void draw();   // 纯接口
}

class Damn implements Textable {
  @override
  void getText() => print('Damn Text');
}
```

> 源文件：[`bin/dart_90.dart`](bin/dart_90.dart)

### 11.4 `sealed`：封闭类型层级，支持穷尽性 switch

```dart
sealed class Vehicle {}
class Car extends Vehicle {}
class Truck extends Vehicle {}
class Bicycle extends Vehicle {}

String getType(Vehicle? v) => switch (v) {
  Car()     => 'car',
  Truck()   => 'truck',
  Bicycle() => 'bicycle',
  _         => 'unknown',
};
```

`sealed` 类本身不能实例化，也不能在库外被扩展或实现。编译器因此可以知道所有子类，做穷尽性检查。

> 源文件：[`bin/dart_78.dart`](bin/dart_78.dart)

---

## 12. 构造函数全攻略

### 12.1 命名构造函数

```dart
class Person {
  late String name;
  late int age;

  Person(this.name, this.age);

  Person.fromJson(Map json) {
    name = json['name'];
    age  = json['age'];
  }
}

var p = Person.fromJson({'name': 'John', 'age': 30});
```

> 源文件：[`bin/dart_38.dart`](bin/dart_38.dart) · [`bin/dart_42.dart`](bin/dart_42.dart)

### 12.2 初始化列表（Initializer List）

在构造函数体执行前给 `final` 字段赋值，或调父类构造。

```dart
class Person {
  String? name;
  late int age;
  late final String address;

  // 三目表达式决定字段值
  Person(this.name, this.age, [String? address])
      : address = age > 18 ? '上海' : '北京';

  // 命名构造函数也能用
  Person.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        age = json['age'],
        address = json['address'];
}
```

### 12.3 工厂构造函数 `factory`

`factory` 不必返回新对象，可返回缓存、子类、已有对象。

```dart
class Person {
  String name;
  int age;
  Person._init(this.name, this.age);

  factory Person(name, age) => Person._init(name, age);
}
```

> 源文件：[`bin/dart_59.dart`](bin/dart_59.dart)

### 12.4 常量构造函数 `const`

允许编译期创建对象。要求**所有字段都是 `final`**，且没有方法体。

```dart
class Person {
  final String name;
  final int age;
  const Person(this.name, this.age);
}

void main() {
  var p1 = const Person('张三', 15);
  var p2 = const Person('张三', 15);

  print(identical(p1, p2));   // true，常量复用同一对象
  print(p1 == p2);

  var p3 = Person('张三', 15);  // 省略 const 后是普通对象
  print(identical(p1, p3));   // false

  // 嵌套 const：传入对象也必须是 const
  const list = [1, 2, 3];
}

class TextStyle {
  final int? fontSize;
  const TextStyle({this.fontSize});
}
class Text {
  final String data;
  final TextStyle style;
  const Text(this.data, this.style);
}

const Text('2', TextStyle(fontSize: 12));   // 内层 const 可省略
```

> 源文件：[`bin/dart_54.dart`](bin/dart_54.dart) · [`bin/dart_55.dart`](bin/dart_55.dart) · [`bin/dart_56.dart`](bin/dart_56.dart)

### 12.5 构造函数的可选参数

```dart
class Person {
  String name;
  int? age;
  Person({required this.name, this.age});
}

class Worker extends Person {
  String? job;
  Worker({required super.name, super.age, this.job});
}

class Animal {
  String? name;
  int? age;
  Animal([this.name = '鲍勃', this.age]);
}

class Cat extends Animal {
  String? color;
  Cat([super.name = '鲍勃', super.age, this.color]);
}
```

> 源文件：[`bin/dart_57.dart`](bin/dart_57.dart)

---

## 13. Mixin

Mixin 解决"多重继承"问题：把可复用的方法/属性**混入**到类中。

```dart
mixin Printable {
  void printMessage() => print('Printable');
  void printMessage2();   // 抽象方法，强制宿主类实现
}

class Drawable {
  void draw() => print('Drawable.draw');
}

// on 关键字：DrawableMixin 只能混入到 Drawable 的子类
mixin DrawableMixin on Drawable {
  void draw2() {
    print('DrawableMixin.draw2');
    super.draw();      // 有了 on 之后 super 才能指向 Drawable
  }
}

class MyClass extends Drawable with DrawableMixin, Printable {
  @override
  void printMessage2() => print('MyClass.printMessage2');
}
```

**使用要点：**

- `with A, B, C`，多个 mixin 按**从左到右**顺序应用，**后面会覆盖前面**。
- Mixin 不能有构造函数；宿主类用 `with` 不会调用 mixin 的构造。
- `on` 限制了混入目标，才允许在 mixin 内调 `super`。

> 源文件：[`bin/dart_91.dart`](bin/dart_91.dart) · [`bin/dart_50.dart`](bin/dart_50.dart)

---

## 14. 泛型

### 14.1 泛型函数

```dart
void show<T>(T row, T line) {
  print('row=${row.runtimeType}, T=$T');
}

void show2<T, K>(T row, K line) { }

show<int>(1, 2);
show2<int, String>(1, 'hi');
```

### 14.2 泛型类

```dart
class Box<T> {
  T value;
  Box(this.value);
  T get() => value;
}

var b = Box<int>(11);

class ListPoison<T> {
  final _list = <T>[];
  void add(T v) => _list.add(v);
  T get(int i) => _list[i];
}
```

### 14.3 泛型约束 `extends`

```dart
class Animal { makeSound() => print('animal'); }
class Dog extends Animal { @override makeSound() => print('Bark'); }

class AnimalList<T extends Animal> {
  final _list = <T>[];
  void add(T v) => _list.add(v);
  T get(int i) => _list[i];
}

// 也可以用 mixin 作为约束
mixin YongChun { attack() => print('attack'); }
class FighterList<T extends YongChun> { }
```

### 14.4 泛型接口

```dart
abstract class Repo<T> {
  T readId(T id);
}

class Worker<T> implements Repo<T> {
  T id;
  Worker(this.id);
  @override
  T readId(T id) { print(T); return id; }  // 运行时能拿到 T
}
```

> 源文件：[`bin/dart_48.dart`](bin/dart_48.dart) · [`bin/dart_49.dart`](bin/dart_49.dart) · [`bin/dart_50.dart`](bin/dart_50.dart) · [`bin/dart_51.dart`](bin/dart_51.dart)

---

## 15. 枚举（基础与增强型）

### 15.1 基础枚举

```dart
enum Color { red, yellow, blue }

void main() {
  var c = Color.red;
  print(c.index);    // 0
  print(c.name);     // 'red'

  for (var k in Color.values) print('${k.index}: $k');

  switch (c) {
    case Color.red:    print('red');    break;
    case Color.yellow: print('yellow'); break;
    case Color.blue:   print('blue');   break;
  }
}
```

### 15.2 增强型枚举（Dart 2.17+）

枚举可以**带字段、构造函数、方法**。

```dart
enum Person {
  child(tall: 150, weight: 40),
  adult(tall: 180, weight: 80);

  final int tall;
  final int weight;
  const Person({required this.tall, required this.weight});  // 必须是 const

  String describe() => 'tall=$tall, weight=$weight';
}

for (var p in Person.values) print('$p ${p.tall} ${p.weight}');
```

> 源文件：[`bin/dart_71.dart`](bin/dart_71.dart) · [`bin/dart_72.dart`](bin/dart_72.dart)

---

## 16. 异常处理与断言

### 16.1 `assert`

**仅在 debug 模式生效**，release 模式被擦除。

```dart
assert(2 + 2 == 4);
assert(x > 0, '必须为正数');
```

### 16.2 `throw` / `try-catch-on-finally`

```dart
try {
  throw Exception('抛出异常');
} on FormatException catch (e) {
  print('format: $e');
} on Exception catch (e, stack) {
  print('exception: $e\n$stack');
} catch (e) {
  print('其他: $e');
} finally {
  print('一定执行');
}
```

> 源文件：[`bin/dart_58.dart`](bin/dart_58.dart)

---

## 17. 异步：Future / async / await

### 17.1 `Future` 创建

```dart
import 'dart:io';

void main() {
  print('1');
  Future(() {
    print('start');
    sleep(Duration(seconds: 2));
    print('end');
  });
  print('2');
  // 输出：1, 2, start, end
}
```

### 17.2 链式 `then`

```dart
Future(() => 'abc')
    .then((v) { print(v); return 'def'; })
    .then((v) { print(v); return null; })
    .whenComplete(() => print('完成'))        // 类似 finally
    .catchError((e) => print('err $e'));
```

### 17.3 静态构造方法

```dart
Future.value('abc');                                   // 立即完成
Future.delayed(Duration(seconds: 2), () => 'x');       // 延时
Future.error(Exception('err'));                        // 立即失败
```

### 17.4 Future 泛型

```dart
Future<String> getName() => Future.value('abc');
getName().then((name) => print(name));
```

### 17.5 `async` / `await`

```dart
Future<void> main() async {
  print('1');
  await Future.delayed(Duration(seconds: 2));
  print('2 (2 秒后)');
}
```

- 标记 `async` 的函数**自动返回 `Future<T>`**。
- `await` 只能在 `async` 函数里用。
- 几乎等价于 JS `async/await`。

> 源文件：[`bin/dart_61.dart`](bin/dart_61.dart) · [`bin/dart_62.dart`](bin/dart_62.dart) · [`bin/dart_63.dart`](bin/dart_63.dart) · [`bin/dart_64.dart`](bin/dart_64.dart) · [`bin/dart_65.dart`](bin/dart_65.dart) · [`bin/dart_66.dart`](bin/dart_66.dart) · [`bin/dart_8.dart`](bin/dart_8.dart) · [`bin/dart_13.dart`](bin/dart_13.dart)

---

## 18. 空安全（Null Safety）

Dart 2.12+ 强制空安全。**默认非空**，nullable 必须显式加 `?`。

### 18.1 五套语法

```dart
// 1) ?. 安全调用
String? s;
print(s?.length);

// 2) ?? 空合并
String name = s ?? 'Guest';

// 3) ??= 空时赋值
s ??= 'default';

// 4) ! 强制解包（若为 null 抛 TypeError）
String s2 = s!;

// 5) ?[] 安全索引
Map<String, String>? m;
String? v = m?['key'];
```

### 18.2 空安全级联

```dart
Person? p = Person();
p
  ?..setName('John')
  ..setAge(30)
  ..printInfo();
```

### 18.3 `late` 替代 `?`

```dart
class Person {
  late String name;
  late int age;
  late String address;
  Person(this.name, this.age, this.address);
}
```

代价：**访问前未初始化会抛 `LateInitializationError`**。

### 18.4 类型提升

```dart
String? s;
if (s != null) {
  print(s.length);    // s 自动被提升为 String
}
```

Dart 3.2+ 也对 **final private 字段** 做了类型提升。

> 源文件：[`bin/dart_9.dart`](bin/dart_9.dart) · [`bin/dart_28.dart`](bin/dart_28.dart) · [`bin/dart_93.dart`](bin/dart_93.dart) · [`bin/dart_94.dart`](bin/dart_94.dart) · [`bin/dart_95.dart`](bin/dart_95.dart) · [`bin/dart_96.dart`](bin/dart_96.dart)

---

## 19. 库系统：import / part / export / library

### 19.1 `import`

```dart
import 'dart:math';                 // 内置库
import 'dart:math' as math;         // 别名
import 'dart:math' show max, min;   // 只导入指定名字
import 'dart:math' hide pi;         // 排除指定名字
import 'package:time/time.dart';    // pub 依赖
import './outer/animal.dart';       // 相对路径
```

> 源文件：[`bin/dart_53.dart`](bin/dart_53.dart) · [`bin/dart_41.dart`](bin/dart_41.dart)

### 19.2 文件即库 / 跨文件私有

`_xxx` 是**库级私有**，不是类级私有。同一文件内的不同类可以互相访问 `_xxx`。

### 19.3 `library` + `part` / `part of`：多文件拼一个库

适合拆分大库。

```dart
// bin/partExport/tankxlib.dart
library tankxlib;

export 'dart:io';

part 'p1.dart';
part 'p2.dart';
part 'p3.dart';
```

```dart
// bin/partExport/p1.dart
part of tankxlib;

class P1 {
  show() => print('p1 show 执行了');
}
```

```dart
// 使用方
import 'partExport/tankxlib.dart';

void main() {
  P1().show();
}
```

**`part` 与 `import` 区别：**

|              | `import`        | `part`             |
| ------------ | --------------- | ------------------ |
| 引入对象     | 另一个完整的库  | 同一个库的另一部分 |
| 私有访问     | 不能访问 `_xxx` | 可以（同库）       |
| 顶层命名空间 | 各自独立        | 共享               |

### 19.4 `export`

让自己成为别人的"门面"：

```dart
// my_lib.dart
export 'src/foo.dart';
export 'src/bar.dart' show Bar;
```

> 源文件：[`bin/dart_68.dart`](bin/dart_68.dart) · [`bin/partExport/`](bin/partExport)

### 19.5 同名冲突 —— `as`

```dart
import './extensiontype/stringa.dart' as m1;
import './extensiontype/stringb.dart' as m2;

m1.StringA('1').parseInt();
m2.StringB('hello').parseInt();
```

> 源文件：[`bin/dart_101.dart`](bin/dart_101.dart) · [`bin/extensiontype/`](bin/extensiontype)

---

## 20. Records（元组）与解构

Dart 3.0 引入 **Records**，类似 TS 元组 + 命名字段对象的混合体。

### 20.1 创建与访问

```dart
// 位置字段：用 $1, $2 ... 访问
var r = (1, 2, 3, 'hello');
print(r.$1);   // 1
print(r.$4);   // hello

// 类型注释
(int, int, int, String) r2 = (1, 2, 3, 'hello');

// 命名字段：用名字访问
var r3 = (a: 1, b: 'hello', 400, 'shit');
print(r3.a);   // 命名字段
print(r3.$1);  // 位置字段（命名字段不参与 $n 编号）

// 类型注释（命名字段）
({int a, String b}) r4 = (a: 1, b: 'hello');
```

### 20.2 结构相等性

```dart
(int a, int b) r6 = (1, 2);
(int c, int d) r7 = (1, 2);
print(r6 == r7);   // true，字段名只是类型标注，不参与运行时
```

### 20.3 多返回值

```dart
(String, int) userInfo() => ('张三', 18);

var (name, age) = userInfo();   // 解构
```

> 源文件：[`bin/dart_73.dart`](bin/dart_73.dart) · [`bin/dart_74.dart`](bin/dart_74.dart)

### 20.4 解构赋值

```dart
var (a, b) = (100, 200);
var (c, _, d) = (100, 200, 'hello');       // _ 忽略
var [x, y, z] = [1, 2, 3];                  // List 解构
var [first, ...rest] = [1, 2, 3, 4, 5];    // rest 收集

// 已有变量交换
var (m, n) = (10, 20);
(n, m) = (m, n);
```
