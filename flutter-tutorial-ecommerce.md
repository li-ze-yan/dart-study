# Flutter 实战扩展 · 电商 App 专题（freezed + 三方登录 + 完整电商实战）

> **前置阅读**：[`dart-tutorial-new.md`](dart-tutorial-new.md) → [`flutter-tutorial.md`](flutter-tutorial.md)。本文是主教程的**实战扩展**，替代主教程 Part 15 的新闻 App，把所有概念串成一个能跑的电商 App。
>
> **业务方向**：移动端电商（iOS / Android）。
> **后端协议**：RESTful，响应包统一为 `{code, message, data}`。
> **代码生成**：全面启用 freezed + json_serializable + riverpod_generator + go_router_builder。
> **登录方式**：Apple Sign-In + Google Sign-In + 邮箱兜底。

---

## 目录

### Part 1 · freezed + json_serializable 完整工作流
- [1.1 它们各解决什么问题](#11-它们各解决什么问题)
- [1.2 装备与配置](#12-装备与配置)
- [1.3 第一个模型：Product](#13-第一个模型product)
- [1.4 build_runner 三种用法](#14-build_runner-三种用法)
- [1.5 嵌套 / List / Map / DateTime](#15-嵌套--list--map--datetime)
- [1.6 sealed union：状态机 / Result](#16-sealed-union状态机--result)
- [1.7 自定义 JSON 字段名 / 默认值](#17-自定义-json-字段名--默认值)
- [1.8 JsonConverter：复杂字段（如金额、枚举、自定义日期）](#18-jsonconverter复杂字段如金额枚举自定义日期)
- [1.9 与 Riverpod 联动：模型即状态](#19-与-riverpod-联动模型即状态)
- [1.10 标准电商响应包装](#110-标准电商响应包装)
- [1.11 常见坑与最佳实践](#111-常见坑与最佳实践)

### Part 2 · Apple ID + Google 三方登录
- [2.1 总体架构与时序图](#21-总体架构与时序图)
- [2.2 后端 RESTful 协议约定](#22-后端-restful-协议约定)
- [2.3 平台原生配置](#23-平台原生配置)
- [2.4 Apple Sign-In 实现](#24-apple-sign-in-实现)
- [2.5 Google Sign-In 实现](#25-google-sign-in-实现)
- [2.6 邮箱密码登录（兜底）](#26-邮箱密码登录兜底)
- [2.7 统一 AuthService 抽象](#27-统一-authservice-抽象)
- [2.8 Token 持久化与自动刷新](#28-token-持久化与自动刷新)
- [2.9 Riverpod authStateProvider](#29-riverpod-authstateprovider)
- [2.10 go_router 守卫联动](#210-go_router-守卫联动)
- [2.11 退出登录与账户切换](#211-退出登录与账户切换)
- [2.12 真机 / 模拟器测试与上架要点](#212-真机--模拟器测试与上架要点)

### Part 3 · 电商 App 完整实战
- [3.1 需求清单与页面树](#31-需求清单与页面树)
- [3.2 后端接口定义（节选）](#32-后端接口定义节选)
- [3.3 项目骨架（feature-first + 强分层）](#33-项目骨架feature-first--强分层)
- [3.4 数据层：freezed 模型库](#34-数据层freezed-模型库)
- [3.5 网络层装配](#35-网络层装配)
- [3.6 Repository 与 DataSource](#36-repository-与-datasource)
- [3.7 状态层：Riverpod Notifier](#37-状态层riverpod-notifier)
- [3.8 路由与守卫](#38-路由与守卫)
- [3.9 启动页 + 登录页](#39-启动页--登录页)
- [3.10 首页（轮播 + 分类 + 推荐）](#310-首页轮播--分类--推荐)
- [3.11 商品详情（轮播 + 规格 + 加购）](#311-商品详情轮播--规格--加购)
- [3.12 购物车页](#312-购物车页)
- [3.13 下单流程（地址 + 优惠券 + 提交）](#313-下单流程地址--优惠券--提交)
- [3.14 订单列表与详情](#314-订单列表与详情)
- [3.15 我的与设置](#315-我的与设置)
- [3.16 主题 / i18n / 错误处理装配](#316-主题--i18n--错误处理装配)
- [3.17 测试用例选录](#317-测试用例选录)
- [3.18 上线前 checklist](#318-上线前-checklist)

---

# Part 1 · freezed + json_serializable 完整工作流

## 1.1 它们各解决什么问题

### freezed

写 Dart 业务模型时，你会反复手写：

```dart
// 没有 freezed 时的"标准模板"
class Product {
  final String id;
  final String title;
  final double price;

  const Product({required this.id, required this.title, required this.price});

  Product copyWith({String? id, String? title, double? price}) =>
      Product(id: id ?? this.id, title: title ?? this.title, price: price ?? this.price);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product && other.id == id && other.title == title && other.price == price);

  @override
  int get hashCode => Object.hash(id, title, price);

  @override
  String toString() => 'Product(id: $id, title: $title, price: $price)';
}
```

5 个字段以上时，模板代码占文件 80%，还容易漏字段（加了字段忘了改 copyWith / `==`）。

**freezed 让你只写一次字段定义，剩下全自动生成。**

### json_serializable

它是 freezed 的搭档，专门生成 `fromJson` / `toJson`。

### 二者关系

```
你写 product.dart（带 @freezed 注解）
   ↓
freezed → 生成 product.freezed.dart（copyWith / == / toString / 解构 …）
json_serializable → 生成 product.g.dart（fromJson / toJson）
   ↓
你的代码 import 'product.dart' 就拿到完整 API
```

---

## 1.2 装备与配置

```bash
# 运行时依赖
flutter pub add freezed_annotation json_annotation

# 代码生成依赖（dev）
flutter pub add --dev build_runner freezed json_serializable
```

`pubspec.yaml` 应该长这样：

```yaml
dependencies:
  freezed_annotation: ^2.4.4
  json_annotation: ^4.9.0

dev_dependencies:
  build_runner: ^2.4.13
  freezed: ^2.5.7
  json_serializable: ^6.8.0
```

`analysis_options.yaml` 增加忽略生成文件的规则：

```yaml
analyzer:
  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
```

> 💡 freezed 即将发布 3.0（带 sealed class 风格、Dart 3 patterns 增强），目前 2.x 是生产稳定线。本文以 2.x 为准。

---

## 1.3 第一个模型：Product

新建 `lib/features/product/domain/product.dart`：

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';
part 'product.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    required double price,
    @Default('') String description,
    @Default([]) List<String> images,
    @Default(false) bool inStock,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
}
```

跑一次代码生成：

```bash
dart run build_runner build --delete-conflicting-outputs
```

会自动生成 `product.freezed.dart` 和 `product.g.dart`（**别手动改这两个文件**）。

使用：

```dart
final p1 = Product(id: '1', title: '机械键盘', price: 599);
final p2 = p1.copyWith(price: 499, inStock: true);
print(p2);                       // Product(id: 1, title: 机械键盘, price: 499, ...)
print(p1 == Product(id: '1', title: '机械键盘', price: 599));  // true（值相等）

// JSON
final json = p1.toJson();
final p3 = Product.fromJson(json);
```

> 🌟 关键语法解释：
> - `class Product with _$Product`：with 一个生成的 mixin，拿到所有自动生成的方法。
> - `const factory Product(...)` = `_Product`：声明工厂构造，私有具体类 `_Product` 由 freezed 生成。
> - `@Default(...)`：字段默认值。
> - 字段都是 final（freezed 强制不可变）。

---

## 1.4 build_runner 三种用法

```bash
# 单次构建
dart run build_runner build

# 删除冲突文件后单次构建（推荐用这个）
dart run build_runner build --delete-conflicting-outputs

# 监听模式（开发期保持开着，文件变了自动重建）
dart run build_runner watch --delete-conflicting-outputs

# 清理产物
dart run build_runner clean
```

> 💡 **VS Code 用户**：装一个 `Build Runner` 插件，按 Ctrl+Shift+B 弹菜单选构建模式。

> ⚠️ **build_runner 慢**：大型项目 build 可能 30s+。watch 模式启动慢但增量构建只要 1-2 秒，**强烈建议常驻**。
> 如果某次报错或行为奇怪，先 `clean` 再 `build`。

---

## 1.5 嵌套 / List / Map / DateTime

freezed + json_serializable **自动递归处理**嵌套类型，前提是嵌套类型也实现了 `fromJson`：

```dart
@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
  }) = _Category;
  factory Category.fromJson(Map<String, dynamic> j) => _$CategoryFromJson(j);
}

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    required double price,

    // 嵌套对象：自动调 Category.fromJson
    Category? category,

    // 嵌套对象列表：自动逐个 fromJson
    @Default(<String>[]) List<String> images,
    @Default(<Sku>[]) List<Sku> skus,

    // Map
    @Default(<String, String>{}) Map<String, String> attrs,

    // DateTime：JSON 里要是 ISO8601 字符串
    DateTime? publishedAt,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> j) => _$ProductFromJson(j);
}

@freezed
class Sku with _$Sku {
  const factory Sku({
    required String id,
    required String name,
    required double price,
    @Default(0) int stock,
  }) = _Sku;
  factory Sku.fromJson(Map<String, dynamic> j) => _$SkuFromJson(j);
}
```

约定：
- `int` ↔ `int`，`double` ↔ `num`（接收）
- `bool` ↔ `bool`
- `DateTime` ↔ `"2026-04-27T10:00:00Z"`（ISO8601）
- `Duration` 默认序列化成微秒；用 JsonConverter 改格式（见 1.8）

---

## 1.6 sealed union：状态机 / Result

freezed 最强大的能力之一：用一个文件声明"几种可能形态"，配合 Dart 3 patterns 优雅消费。

### 1.6.1 经典 Result

```dart
@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.ok(T value) = ResultOk<T>;
  const factory Result.err(String message, {int? code}) = ResultErr<T>;
}
```

使用：

```dart
Result<Product> r = ...;

// switch + 解构（最现代）
final str = switch (r) {
  ResultOk(:final value) => '成功: ${value.title}',
  ResultErr(:final message, :final code) => '失败 [$code]: $message',
};

// when（freezed 内置，老风格）
final str2 = r.when(
  ok: (v) => '成功: ${v.title}',
  err: (msg, code) => '失败 [$code]: $msg',
);
```

### 1.6.2 异步加载状态

```dart
@freezed
sealed class CartState with _$CartState {
  const factory CartState.idle() = CartIdle;
  const factory CartState.loading() = CartLoading;
  const factory CartState.ready(List<CartItem> items, double subtotal) = CartReady;
  const factory CartState.error(String message) = CartError;
}
```

```dart
Widget build(BuildContext context, WidgetRef ref) {
  final state = ref.watch(cartProvider);
  return switch (state) {
    CartIdle() || CartLoading() => const _LoadingView(),
    CartReady(:final items, :final subtotal) => _CartList(items: items, subtotal: subtotal),
    CartError(:final message) => _ErrorView(message: message),
  };
}
```

### 1.6.3 sealed 与 Dart 3 的 switch 穷举检查

freezed 2.5+ 生成的 union 使用 Dart 3 的 `sealed class`，**switch 漏一个分支编译就会报错**——加新状态时所有 switch 自动暴露未处理位置。

---

## 1.7 自定义 JSON 字段名 / 默认值

后端字段命名常常和 Dart 风格不一致（snake_case / camelCase），用 `@JsonKey`：

```dart
@freezed
class User with _$User {
  const factory User({
    required String id,

    @JsonKey(name: 'nick_name') required String nickname,

    @JsonKey(name: 'avatar_url') @Default('') String avatar,

    // 接收时如果服务端没给，用默认值
    @JsonKey(defaultValue: 0) @Default(0) int level,

    // 输出时跳过这个字段（toJson 不会包含）
    @JsonKey(includeToJson: false) String? localOnly,

    // 接收时跳过
    @JsonKey(includeFromJson: false) DateTime? lastSeenLocal,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> j) => _$UserFromJson(j);
}
```

**全局命名风格**（避免每个字段都写 `@JsonKey`）：

```yaml
# build.yaml（项目根目录）
targets:
  $default:
    builders:
      json_serializable:
        options:
          field_rename: snake     # 全局 snake_case
          explicit_to_json: true
          include_if_null: false  # toJson 忽略 null
```

之后 `String publishedAt` 自动对应 JSON 的 `published_at`，无需 `@JsonKey`。

---

## 1.8 JsonConverter：复杂字段（如金额、枚举、自定义日期）

### 1.8.1 金额：服务端给"分"，App 内用 `Money` 扩展类型

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

extension type Money(int cents) {
  static const Money zero = Money(0);
  String format() {
    final yuan = cents ~/ 100;
    final rest = (cents % 100).toString().padLeft(2, '0');
    return '¥$yuan.$rest';
  }
}

class MoneyConverter implements JsonConverter<Money, int> {
  const MoneyConverter();
  @override
  Money fromJson(int json) => Money(json);
  @override
  int toJson(Money value) => value.cents;
}
```

应用到字段：

```dart
@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    @MoneyConverter() required Money price,
    @MoneyConverter() Money? originalPrice,
  }) = _Product;
  factory Product.fromJson(Map<String, dynamic> j) => _$ProductFromJson(j);
}
```

### 1.8.2 枚举

```dart
enum OrderStatus {
  pending('PENDING'),
  paid('PAID'),
  shipped('SHIPPED'),
  completed('COMPLETED'),
  cancelled('CANCELLED');

  final String code;
  const OrderStatus(this.code);
}

class OrderStatusConverter implements JsonConverter<OrderStatus, String> {
  const OrderStatusConverter();
  @override
  OrderStatus fromJson(String code) =>
      OrderStatus.values.firstWhere((e) => e.code == code, orElse: () => OrderStatus.pending);
  @override
  String toJson(OrderStatus value) => value.code;
}
```

> 💡 **更简单**：让枚举的字面量名和服务端 code 一致，可以直接用 `@JsonValue`：
>
> ```dart
> enum OrderStatus {
>   @JsonValue('PENDING') pending,
>   @JsonValue('PAID') paid,
> }
> ```
> json_serializable 会自动处理，不用写 Converter。

### 1.8.3 自定义日期格式

服务端返回 `1714200000`（秒级时间戳）：

```dart
class EpochSecondsConverter implements JsonConverter<DateTime, int> {
  const EpochSecondsConverter();
  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json * 1000);
  @override
  int toJson(DateTime value) => value.millisecondsSinceEpoch ~/ 1000;
}

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    @EpochSecondsConverter() required DateTime createdAt,
  }) = _Order;
  factory Order.fromJson(Map<String, dynamic> j) => _$OrderFromJson(j);
}
```

---

## 1.9 与 Riverpod 联动：模型即状态

freezed 模型作为 NotifierProvider 的 state，天然支持 `copyWith` 增量更新：

```dart
@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required Product product,
    required Sku sku,
    required int quantity,
  }) = _CartItem;
  factory CartItem.fromJson(Map<String, dynamic> j) => _$CartItemFromJson(j);
}

@riverpod
class CartController extends _$CartController {
  @override
  List<CartItem> build() => const [];

  void add(Product p, Sku sku, {int qty = 1}) {
    final idx = state.indexWhere((it) => it.sku.id == sku.id);
    if (idx == -1) {
      state = [...state, CartItem(product: p, sku: sku, quantity: qty)];
    } else {
      state = [
        for (var i = 0; i < state.length; i++)
          if (i == idx)
            state[i].copyWith(quantity: state[i].quantity + qty)   // ★ copyWith 用上了
          else
            state[i],
      ];
    }
  }

  void updateQty(String skuId, int qty) {
    state = [
      for (final it in state)
        if (it.sku.id == skuId) it.copyWith(quantity: qty) else it,
    ];
  }

  void remove(String skuId) {
    state = state.where((it) => it.sku.id != skuId).toList();
  }
}
```

> 💡 freezed 的 `==` 是值相等，所以 Riverpod 的"前后状态一致就不通知"语义自动生效，不会触发无用重建。

---

## 1.10 标准电商响应包装

电商后端常见响应：

```json
{
  "code": 0,
  "message": "OK",
  "data": { ... }
}
```

包装类用 freezed 泛型：

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_response.freezed.dart';
part 'api_response.g.dart';

@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const ApiResponse._();   // ★ 必须，才能加自定义 getter / 方法

  const factory ApiResponse({
    required int code,
    required String message,
    T? data,
  }) = _ApiResponse<T>;

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$ApiResponseFromJson(json, fromJsonT);

  bool get isOk => code == 0;
}
```

`@Freezed(genericArgumentFactories: true)` 是关键：让 fromJson 接收一个"如何把 Object 转成 T"的回调。

使用：

```dart
final raw = await dio.get('/api/products/123');

// 解析包装层
final res = ApiResponse<Product>.fromJson(
  raw.data as Map<String, dynamic>,
  (j) => Product.fromJson(j as Map<String, dynamic>),
);

if (res.isOk) {
  final product = res.data!;
  // ...
} else {
  throw ServerError(res.code, res.message);
}
```

带分页的：

```dart
@Freezed(genericArgumentFactories: true)
class Page<T> with _$Page<T> {
  const factory Page({
    required List<T> list,
    required int total,
    required int page,
    required int size,
  }) = _Page<T>;

  factory Page.fromJson(Map<String, dynamic> j, T Function(Object?) fromJsonT) =>
      _$PageFromJson(j, fromJsonT);
}
```

```dart
final raw = await dio.get('/api/products', queryParameters: {'page': 1, 'size': 20});
final res = ApiResponse<Page<Product>>.fromJson(
  raw.data as Map<String, dynamic>,
  (j) => Page.fromJson(
    j as Map<String, dynamic>,
    (p) => Product.fromJson(p as Map<String, dynamic>),
  ),
);
final page = res.data!;
print('共 ${page.total} 条，当前 ${page.list.length} 条');
```

> 这套写法稍微"绕"，但**类型一路安全**，是 Flutter 电商项目接 RESTful 的标准姿势。Part 3 会进一步封装。

---

## 1.11 常见坑与最佳实践

### 坑 1：忘了重新生成

改了字段没跑 build_runner → 编译报错 `_$ProductFromJson is not defined`。
→ 解决：开 `dart run build_runner watch`。

### 坑 2：私有构造冲突

```dart
@freezed
class User with _$User {
  // ❌ 加了私有构造但没加额外字段/方法时，会和 freezed 默认行为冲突
  const User._();
  const factory User({...}) = _User;
}
```

→ 只在**真的需要写自定义 getter / 方法**时才加 `const ClassName._();`，否则别加。

### 坑 3：JSON 来了 null，但字段是 `String`（非空）

```dart
const factory Product({required String title}) = _Product;
// JSON: {"title": null}
// 抛 TypeError: Null check failed
```

→ 解决：要么字段加 `?` 改成 `String? title`，要么加 `@Default('')`，要么用 `@JsonKey(defaultValue: '')`。

### 坑 4：`int` 和 `double` 类型对接

```json
{"price": 100}    // 服务端有时返回 int，有时返回 double
```

```dart
final factory Product({required double price}) = _Product;
// 当返回是 int(100) 时，Dart 直接 100 as double 会失败
```

→ 解决：
- 用 `num`：`required num price`
- 或者用 JsonConverter 兼容
- 或者要求后端**永远返回浮点**

### 坑 5：嵌套对象列表反序列化失败

```dart
const factory Order({
  required List<Product> products,    // ✅ 列表里是已注解类型，自动处理
  required List<Map<String, dynamic>> raw,  // ✅ 也行
}) = _Order;
```

但如果你写 `List<dynamic>` 装 Product，服务端给的 List 里是 Map，类型对不上。**永远显式标注 List<具体类型>**。

### 坑 6：copyWith 不能把字段改成 null

```dart
final p = Product(originalPrice: Money(199), ...);
final p2 = p.copyWith(originalPrice: null);   // ❌ freezed 2.x 会忽略
```

→ freezed 2.x 没法区分"传了 null"和"没传"。要清空 nullable 字段：
- 升级 freezed 3.x（即将稳定，原生支持）。
- 或者自己定义一个 sentinel：`copyWith(originalPrice: const Wrapped(null))`（freezed 暗黑魔法）。
- **最稳**的做法：业务上别让"清空"出现，用 `copyWith(originalPrice: Money.zero)` 表达"没有原价"。

### 最佳实践清单

- ✅ 一个文件一个/一组紧密关联的模型，导出方便。
- ✅ 业务实体用 freezed，DTO（接口形状）也用 freezed，但写在 `data/dto/` 目录下；Repository 负责 DTO → 实体的 mapping，避免接口变动污染领域层。
- ✅ 全局 `field_rename: snake` 让 90% 字段不需要 `@JsonKey`。
- ✅ 跟 `riverpod_generator` 共用 build_runner，一次 watch 双工生成。
- ✅ 把 `*.freezed.dart` 和 `*.g.dart` 加进 `.gitignore` 还是入仓库？**入仓库**，避免 CI 必须跑 build_runner，IDE 跳转更友好。

---

# Part 2 · Apple ID + Google 三方登录

## 2.1 总体架构与时序图

三方登录的本质是**用第三方做"用户身份证明"**，最终发给你后端的是一个 idToken / authorizationCode，由你的后端去校验，再换成你自己的会话 token。

```
[App]                          [Apple/Google SDK]                [你的后端]
  |                                    |                              |
  | 1. tap 登录                        |                              |
  | -------- start sign-in --------->  |                              |
  |                                    |                              |
  |                              2. 弹原生授权页                       |
  |                                    |                              |
  |                              3. 用户同意                           |
  |                                    |                              |
  | <-- idToken / authCode ----------- |                              |
  |                                                                   |
  | 4. POST /auth/oauth/{provider}                                    |
  | { idToken: "...", platform: "ios" }                               |
  | ----------------------------------------------------------------> |
  |                                                              5. 校验 idToken
  |                                                              6. 查/建用户
  |                                                              7. 签发 access/refresh
  | <-- { accessToken, refreshToken, user } ------------------------- |
  |                                                                   |
  | 8. 持久化 token                                                   |
  | 9. 进首页                                                          |
```

关键点：
- **`idToken` 不是你后端的 token**——它是 Apple / Google 给的"身份凭证"，你后端要验证签名、过期、aud 等。
- **绝不要让 App 把 Apple/Google 的 token 当成自己的 access token 用**。一律换成自有 token。
- **绑定逻辑由后端决定**：相同邮箱的 Apple 和 Google 账号是不是同一个 user？后端拍板，App 不操心。

---

## 2.2 后端 RESTful 协议约定

下面是一份和后端可以直接对齐的协议（所有响应都被 `{code, message, data}` 包裹）。

### 2.2.1 三方登录

```
POST /api/v1/auth/oauth/{provider}    # provider = apple | google
Headers: Content-Type: application/json
Body:
{
  "idToken": "<Apple/Google 给的 ID Token>",
  "authorizationCode": "<可选，Apple 才有，用于服务端换 refresh>",
  "platform": "ios | android | web",
  "deviceId": "<App 唯一 ID>",
  "appVersion": "1.0.0"
}

Response.data:
{
  "accessToken": "...",
  "refreshToken": "...",
  "expiresIn": 3600,            // 秒
  "user": {
    "id": "u-001",
    "nickname": "小新",
    "avatar": "https://...",
    "email": "...@privaterelay.appleid.com",
    "phone": null
  },
  "isNewUser": true             // 用于决定要不要弹"完善资料"页
}
```

### 2.2.2 邮箱密码（兜底）

```
POST /api/v1/auth/login
Body: { "email": "...", "password": "..." }
```

### 2.2.3 刷新 token

```
POST /api/v1/auth/refresh
Body: { "refreshToken": "..." }
Response.data: { "accessToken": "...", "refreshToken": "...", "expiresIn": 3600 }
```

### 2.2.4 退出

```
POST /api/v1/auth/logout
Headers: Authorization: Bearer <accessToken>
```

### 2.2.5 当前用户

```
GET /api/v1/users/me
Headers: Authorization: Bearer <accessToken>
```

---

## 2.3 平台原生配置

### 2.3.1 Apple Sign-In

#### iOS

1. **Apple Developer Portal**：
   - App ID 启用 "Sign In with Apple" Capability。
   - 准备一个 Service ID（如果要 Web 登录或服务端换 token）。

2. **Xcode**：
   - Signing & Capabilities → `+` → Sign in with Apple。
   - 这一步会自动改 entitlements 文件。

3. **依赖**：

```bash
flutter pub add sign_in_with_apple
```

#### Android（Apple Sign-In 通过 Web 流程实现）

需要一个能托管的回调 URL（你的后端域名）。配置 Service ID 时把 `https://your-backend.com/auth/apple/callback` 加为 Return URL。Android 端体验是"打开浏览器走 OAuth"，不如 iOS 原生。

> 业务建议：**Apple Sign-In 在 Android 上仅用于"已经用 Apple ID 注册过的用户登录"**，不主推。

#### iOS 上架强制要求

> 如果 App 提供任何**第三方登录**（Google / Facebook / 微信），按 App Store Review Guidelines **4.8** 必须**同时提供 Sign in with Apple**。这条是硬规则，漏了就拒审。

### 2.3.2 Google Sign-In

#### iOS

1. Google Cloud Console → 创建 OAuth Client ID（iOS 类型），填 Bundle ID。
2. 下载 `GoogleService-Info.plist`（其实只需要 `REVERSED_CLIENT_ID`）。
3. `ios/Runner/Info.plist` 添加：

```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>com.googleusercontent.apps.YOUR_CLIENT_ID</string>
    </array>
  </dict>
</array>
```

#### Android

1. Google Cloud Console → 创建 OAuth Client ID（Android 类型），填包名 + SHA-1。
2. 准备 SHA-1：

```bash
# debug
cd android && ./gradlew signingReport
```

3. 把 SHA-1 填进 Cloud Console。
4. **生产签名也要加一个 SHA-1**，否则上架后登录失败。

#### 依赖

```bash
flutter pub add google_sign_in
```

---

## 2.4 Apple Sign-In 实现

```dart
// lib/features/auth/data/apple_auth_provider.dart
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleAuthCredential {
  final String idToken;
  final String? authorizationCode;
  final String? email;          // Apple 只在首次登录时给 email/name
  final String? givenName;
  final String? familyName;

  const AppleAuthCredential({
    required this.idToken,
    this.authorizationCode,
    this.email,
    this.givenName,
    this.familyName,
  });
}

class AppleAuthProvider {
  Future<AppleAuthCredential> signIn() async {
    if (!await SignInWithApple.isAvailable()) {
      throw const AuthException(
        code: 'apple_unavailable',
        message: '当前设备不支持 Apple 登录（需要 iOS 13+ 或 macOS 10.15+）',
      );
    }

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // Android / Web 走 webAuthenticationOptions（这里只给 iOS 示例）
    );

    if (credential.identityToken == null) {
      throw const AuthException(code: 'apple_no_token', message: '未获取到 Apple ID Token');
    }

    return AppleAuthCredential(
      idToken: credential.identityToken!,
      authorizationCode: credential.authorizationCode,
      email: credential.email,
      givenName: credential.givenName,
      familyName: credential.familyName,
    );
  }
}
```

> ⚠️ **Apple 只在用户首次登录时返回 email / name**。第二次登录这些字段都是 null。
> → **必须在第一次登录就把 email / name 上报给后端**，后端落库。

---

## 2.5 Google Sign-In 实现

```dart
// lib/features/auth/data/google_auth_provider.dart
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthCredential {
  final String idToken;
  final String? accessToken;
  final String email;
  final String displayName;
  final String? photoUrl;

  const GoogleAuthCredential({
    required this.idToken,
    this.accessToken,
    required this.email,
    required this.displayName,
    this.photoUrl,
  });
}

class GoogleAuthProvider {
  // 7.x 起改用 GoogleSignIn.instance + initialize；下面是一份兼容主流版本的写法
  static final _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    // serverClientId: '<your-server-client-id>',  // 后端校验时可能需要
  );

  Future<GoogleAuthCredential> signIn() async {
    final account = await _googleSignIn.signIn();
    if (account == null) {
      throw const AuthException(code: 'google_cancelled', message: '用户取消了 Google 登录');
    }
    final auth = await account.authentication;
    if (auth.idToken == null) {
      throw const AuthException(code: 'google_no_token', message: '未获取到 Google ID Token');
    }
    return GoogleAuthCredential(
      idToken: auth.idToken!,
      accessToken: auth.accessToken,
      email: account.email,
      displayName: account.displayName ?? '',
      photoUrl: account.photoUrl,
    );
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
```

> ⚠️ `google_sign_in` **8.x** 改成了 `GoogleSignIn.instance.initialize(...)` 模式（要先 `initialize` 才能 `authenticate()`）。本文以 6.x / 7.x 主流版本为准；升级到 8.x 时按官方迁移指南调整。

---

## 2.6 邮箱密码登录（兜底）

```dart
// lib/features/auth/data/email_auth_provider.dart
class EmailAuthCredential {
  final String email;
  final String password;
  const EmailAuthCredential({required this.email, required this.password});
}

class EmailAuthProvider {
  // 这一步只是收集表单输入，没走任何 SDK
  EmailAuthCredential collect({required String email, required String password}) {
    if (!email.contains('@')) {
      throw const AuthException(code: 'invalid_email', message: '邮箱格式不正确');
    }
    if (password.length < 6) {
      throw const AuthException(code: 'invalid_password', message: '密码至少 6 位');
    }
    return EmailAuthCredential(email: email, password: password);
  }
}
```

---

## 2.7 统一 AuthService 抽象

把三种登录的输出**收敛到同一个流程**：拿凭据 → 调后端 → 拿到 AuthSession → 持久化。

```dart
// lib/features/auth/domain/auth_session.dart
@freezed
class AuthSession with _$AuthSession {
  const factory AuthSession({
    required String accessToken,
    required String refreshToken,
    required DateTime expiresAt,
    required AuthUser user,
  }) = _AuthSession;
  factory AuthSession.fromJson(Map<String, dynamic> j) => _$AuthSessionFromJson(j);
}

@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String id,
    required String nickname,
    @Default('') String avatar,
    String? email,
    String? phone,
  }) = _AuthUser;
  factory AuthUser.fromJson(Map<String, dynamic> j) => _$AuthUserFromJson(j);
}

@freezed
class AuthException with _$AuthException implements Exception {
  const factory AuthException({
    required String code,
    required String message,
  }) = _AuthException;
}
```

```dart
// lib/features/auth/data/auth_remote_ds.dart
class AuthRemoteDataSource {
  final Dio _dio;
  AuthRemoteDataSource(this._dio);

  Future<AuthSession> oauthApple({
    required String idToken,
    String? authorizationCode,
    String? email,
    String? givenName,
    String? familyName,
  }) async {
    final r = await _dio.post('/auth/oauth/apple', data: {
      'idToken': idToken,
      'authorizationCode': authorizationCode,
      'email': email,
      'givenName': givenName,
      'familyName': familyName,
      'platform': _platform(),
    });
    return _parseSession(r.data as Map<String, dynamic>);
  }

  Future<AuthSession> oauthGoogle({required String idToken}) async {
    final r = await _dio.post('/auth/oauth/google', data: {
      'idToken': idToken,
      'platform': _platform(),
    });
    return _parseSession(r.data as Map<String, dynamic>);
  }

  Future<AuthSession> emailLogin({required String email, required String password}) async {
    final r = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return _parseSession(r.data as Map<String, dynamic>);
  }

  Future<AuthSession> refresh({required String refreshToken}) async {
    final r = await _dio.post('/auth/refresh', data: {'refreshToken': refreshToken});
    return _parseSession(r.data as Map<String, dynamic>);
  }

  Future<void> logout({required String accessToken}) async {
    await _dio.post(
      '/auth/logout',
      options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
    );
  }

  AuthSession _parseSession(Map<String, dynamic> wrapped) {
    // 假设拦截器已经剥过 ApiResponse 包装；如果没有，这里再剥一层
    final data = wrapped['data'] as Map<String, dynamic>;
    return AuthSession(
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
      expiresAt: DateTime.now().add(Duration(seconds: data['expiresIn'] as int)),
      user: AuthUser.fromJson(data['user'] as Map<String, dynamic>),
    );
  }

  String _platform() {
    if (kIsWeb) return 'web';
    return defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';
  }
}
```

```dart
// lib/features/auth/domain/auth_service.dart
class AuthService {
  final AppleAuthProvider _apple;
  final GoogleAuthProvider _google;
  final EmailAuthProvider _email;
  final AuthRemoteDataSource _api;
  final SecureSessionStorage _storage;

  AuthService(this._apple, this._google, this._email, this._api, this._storage);

  Future<AuthSession> signInWithApple() async {
    final cred = await _apple.signIn();
    final session = await _api.oauthApple(
      idToken: cred.idToken,
      authorizationCode: cred.authorizationCode,
      email: cred.email,
      givenName: cred.givenName,
      familyName: cred.familyName,
    );
    await _storage.save(session);
    return session;
  }

  Future<AuthSession> signInWithGoogle() async {
    final cred = await _google.signIn();
    final session = await _api.oauthGoogle(idToken: cred.idToken);
    await _storage.save(session);
    return session;
  }

  Future<AuthSession> signInWithEmail({required String email, required String password}) async {
    final cred = _email.collect(email: email, password: password);
    final session = await _api.emailLogin(email: cred.email, password: cred.password);
    await _storage.save(session);
    return session;
  }

  Future<void> signOut() async {
    final session = await _storage.read();
    if (session != null) {
      try {
        await _api.logout(accessToken: session.accessToken);
      } catch (_) {/* 忽略：本地必须清掉 */}
    }
    await _google.signOut();
    await _storage.clear();
  }

  Future<AuthSession?> restoreSession() async {
    final s = await _storage.read();
    if (s == null) return null;
    if (s.expiresAt.isAfter(DateTime.now().add(const Duration(seconds: 30)))) {
      return s;
    }
    // 过期或快过期：用 refreshToken 续
    try {
      final fresh = await _api.refresh(refreshToken: s.refreshToken);
      await _storage.save(fresh);
      return fresh;
    } catch (_) {
      await _storage.clear();
      return null;
    }
  }
}
```

---

## 2.8 Token 持久化与自动刷新

```dart
// lib/features/auth/data/secure_session_storage.dart
class SecureSessionStorage {
  static const _key = 'auth_session_v1';
  final FlutterSecureStorage _storage;
  SecureSessionStorage(this._storage);

  Future<void> save(AuthSession s) async {
    await _storage.write(key: _key, value: jsonEncode(s.toJson()));
  }

  Future<AuthSession?> read() async {
    final raw = await _storage.read(key: _key);
    if (raw == null) return null;
    try {
      return AuthSession.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      await clear();
      return null;
    }
  }

  Future<void> clear() => _storage.delete(key: _key);
}
```

主教程 Part 6.34 已经有"队列 + 锁"的 Dio AuthInterceptor 完整代码——把 `_refresh` 替换成调 `AuthService.restoreSession()` 即可：

```dart
@Riverpod(keepAlive: true)
Dio authedDio(Ref ref) {
  final dio = Dio(BaseOptions(baseUrl: AppEnv.apiBase));
  dio.interceptors.addAll([
    // 注入 token
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        final session = await ref.read(secureSessionStorageProvider).read();
        if (session != null) {
          options.headers['Authorization'] = 'Bearer ${session.accessToken}';
        }
        handler.next(options);
      },
    ),
    // 401 自动刷新（见主教程 6.34）
    AuthInterceptor(dio, () async {
      final fresh = await ref.read(authServiceProvider).restoreSession();
      return fresh?.accessToken;
    }),
    // 剥离 ApiResponse 外层
    ApiResponseUnwrapInterceptor(),
  ]);
  return dio;
}
```

---

## 2.9 Riverpod authStateProvider

整个 App 的"是否登录、当前用户"由这个 Notifier 决定：

```dart
// lib/features/auth/presentation/auth_controller.dart
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  Future<AuthSession?> build() async {
    return ref.watch(authServiceProvider).restoreSession();
  }

  Future<void> signInWithApple() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(authServiceProvider).signInWithApple());
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(authServiceProvider).signInWithGoogle());
  }

  Future<void> signInWithEmail({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return ref.read(authServiceProvider).signInWithEmail(email: email, password: password);
    });
  }

  Future<void> signOut() async {
    await ref.read(authServiceProvider).signOut();
    state = const AsyncData(null);
  }
}

// 派生：是否已登录（用 select 避免无关字段触发重建）
@riverpod
bool isLoggedIn(Ref ref) {
  return ref.watch(authControllerProvider).valueOrNull != null;
}

// 派生：当前用户
@riverpod
AuthUser? currentUser(Ref ref) {
  return ref.watch(authControllerProvider).valueOrNull?.user;
}
```

---

## 2.10 go_router 守卫联动

```dart
// lib/core/routing/router.dart
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // 用 Listenable 桥接 Riverpod -> go_router 的 refreshListenable
  final notifier = AuthRouterNotifier(ref);

  return GoRouter(
    refreshListenable: notifier,
    initialLocation: '/splash',
    routes: $appRoutes,                 // go_router_builder 生成
    redirect: (ctx, state) {
      final asyncAuth = ref.read(authControllerProvider);

      // 启动期还在恢复 session：留在启动页
      if (asyncAuth.isLoading) return '/splash';

      final loggedIn = asyncAuth.valueOrNull != null;
      final loc = state.matchedLocation;
      final inAuthFlow = loc == '/login' || loc == '/splash';

      if (!loggedIn && !inAuthFlow) return '/login';
      if (loggedIn && inAuthFlow) return '/home';
      return null;
    },
  );
}

class AuthRouterNotifier extends ChangeNotifier {
  AuthRouterNotifier(Ref ref) {
    ref.listen(authControllerProvider, (_, __) => notifyListeners());
  }
}
```

> 🌟 这套写法的精髓：登录态变化 → Riverpod 通知 → AuthRouterNotifier 通知 → go_router 重新跑 redirect。
> 用户登录成功 / 退出 → 自动跳转，**不需要手动 push**。

---

## 2.11 退出登录与账户切换

```dart
// 退出
await ref.read(authControllerProvider.notifier).signOut();
// router 会自动跳到 /login（因为 redirect 重新评估）

// 账户切换 = 退出 + 再登录
await ref.read(authControllerProvider.notifier).signOut();
await ref.read(authControllerProvider.notifier).signInWithApple();
```

---

## 2.12 真机 / 模拟器测试与上架要点

### 测试

| 平台 | Apple 登录 | Google 登录 |
| --- | --- | --- |
| iOS 模拟器 | ✅ 模拟器要登录 iCloud | ✅ |
| iOS 真机 | ✅ | ✅ |
| Android 模拟器 | 需走 Web 流程 | ✅ 装了 Google Play 服务的镜像 |
| Android 真机（无 GMS） | 需走 Web 流程 | ❌ Huawei / 国内厂家无 GMS 时不行 |

### 上架 checklist

- [ ] App Store：项目同时支持 Apple 登录（Guideline 4.8）。
- [ ] App Store：明确声明使用了什么用户数据（Privacy Manifest）。
- [ ] Google Play：在 Cloud Console 把**生产签名 SHA-1** 都加进 OAuth Client。
- [ ] 后端：**校验 idToken 签名**（不要相信 App 自报的 user.id）。
- [ ] 后端：Apple 的 idToken `aud` 必须是你的 Bundle ID / Service ID。
- [ ] 后端：禁止用 idToken 做长期会话；只换一次。
- [ ] 隐私：Apple Hide-My-Email 给的是 `xxx@privaterelay.appleid.com`，**不能用作市场触达邮箱**，要写清楚。

---

# Part 3 · 电商 App 完整实战

## 3.1 需求清单与页面树

最小可上线 V1 范围：

```
启动页 (Splash)
登录页 (Login: Apple / Google / Email)
└── 主页 (BottomNavBar)
    ├── 首页 Tab
    │   ├── 顶部搜索栏
    │   ├── 轮播 Banner
    │   ├── 分类入口
    │   ├── 限时秒杀
    │   └── 推荐商品列表
    ├── 分类 Tab
    │   ├── 左侧一级分类
    │   └── 右侧二级分类 + 商品网格
    ├── 购物车 Tab
    └── 我的 Tab
        ├── 用户卡片
        ├── 我的订单（4 状态入口）
        ├── 收货地址
        ├── 优惠券
        ├── 设置
        └── 退出登录

商品详情页 (Product Detail)
├── 图片轮播
├── 价格 / 标题 / 简介
├── 规格选择面板 (BottomSheet)
├── 评价区
├── 加入购物车 / 立即购买

订单确认页 (Checkout)
├── 收货地址（点击进选择页）
├── 商品列表
├── 优惠券（点击进选择页）
├── 备注
└── 提交订单

订单结果页 (PaymentResult: 成功 / 失败)

订单列表页 (Orders)
订单详情页 (Order Detail)
地址管理页 / 编辑地址页
搜索结果页
```

---

## 3.2 后端接口定义（节选）

按 RESTful + `{code, message, data}` 包装，关键接口：

```
# 认证（见 Part 2）
POST /auth/oauth/apple
POST /auth/oauth/google
POST /auth/login
POST /auth/refresh
POST /auth/logout
GET  /users/me

# 首页
GET  /home/banners                       → List<Banner>
GET  /home/categories                    → List<Category>
GET  /home/flash-sales                   → List<FlashSale>
GET  /home/recommendations?page&size     → Page<Product>

# 分类
GET  /categories                         → List<Category>（含 children）
GET  /categories/{id}/products?page&size → Page<Product>

# 商品
GET  /products/{id}                      → ProductDetail（含 skus、reviews、attrs）
GET  /products/search?q=&page&size       → Page<Product>

# 购物车（服务端可有可无；下面假设服务端有）
GET  /cart                                → CartView
POST /cart/items                          → CartView（{ skuId, quantity }）
PUT  /cart/items/{skuId}                  → CartView（{ quantity }）
DELETE /cart/items/{skuId}                → CartView

# 地址
GET  /addresses                           → List<Address>
POST /addresses                           → Address
PUT  /addresses/{id}                      → Address
DELETE /addresses/{id}                    → void
PUT  /addresses/{id}/default              → void

# 优惠券
GET  /coupons/usable?totalCents=          → List<Coupon>

# 订单
POST /orders/preview                      → CheckoutPreview（{ skuIds, addressId, couponId? }）
POST /orders                              → Order（提交订单）
GET  /orders?status=&page&size            → Page<Order>
GET  /orders/{id}                         → Order
POST /orders/{id}/cancel                  → Order
POST /orders/{id}/pay                     → PayParams（用于唤起支付，本文不展开）
```

---

## 3.3 项目骨架（feature-first + 强分层）

```
lib/
├── main.dart
├── app.dart                             # MaterialApp.router
│
├── core/                                # 跨 feature 公共
│   ├── env.dart
│   ├── error/
│   │   ├── app_error.dart               # sealed AppError
│   │   └── error_mapper.dart            # DioException → AppError
│   ├── network/
│   │   ├── api_response.dart            # ApiResponse<T>, Page<T>
│   │   ├── api_response_interceptor.dart
│   │   ├── auth_interceptor.dart
│   │   └── dio_provider.dart
│   ├── storage/
│   │   ├── secure_storage_provider.dart
│   │   └── shared_prefs_provider.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── app_palette.dart             # ThemeExtension
│   │   └── theme_mode_provider.dart
│   ├── i18n/locale_provider.dart
│   ├── routing/
│   │   ├── routes.dart                  # @TypedGoRoute
│   │   └── router.dart
│   ├── utils/
│   │   ├── money.dart                   # extension type Money
│   │   ├── money_converter.dart
│   │   └── format.dart
│   └── widgets/                         # 跨 feature 通用 Widget
│       ├── empty_view.dart
│       ├── error_view.dart
│       ├── skeleton.dart
│       └── price_text.dart
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── login_page.dart
│   │       └── auth_controller.dart
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │       ├── home_page.dart
│   │       └── home_controller.dart
│   ├── catalog/                         # 分类 + 搜索
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── product/
│   ├── cart/
│   ├── checkout/                        # 下单流程
│   ├── order/
│   ├── address/
│   ├── coupon/
│   └── profile/
│
├── shell/
│   └── main_scaffold.dart               # 底部 Tab 容器
│
└── l10n/
```

---

## 3.4 数据层：freezed 模型库

完整建模一次跑通。以下都放在 `lib/features/<x>/domain/` 下，每个文件配套 `.freezed.dart` + `.g.dart`。

### 3.4.1 通用：金额、分页、响应包

`core/utils/money.dart` + `core/utils/money_converter.dart` 见 Part 1.8.1。

`core/network/api_response.dart`：

```dart
@Freezed(genericArgumentFactories: true)
class ApiResponse<T> with _$ApiResponse<T> {
  const ApiResponse._();
  const factory ApiResponse({
    required int code,
    required String message,
    T? data,
  }) = _ApiResponse<T>;
  factory ApiResponse.fromJson(Map<String, dynamic> j, T Function(Object?) fromJsonT) =>
      _$ApiResponseFromJson(j, fromJsonT);
  bool get isOk => code == 0;
}

@Freezed(genericArgumentFactories: true)
class Page<T> with _$Page<T> {
  const factory Page({
    required List<T> list,
    required int total,
    required int page,
    required int size,
  }) = _Page<T>;
  factory Page.fromJson(Map<String, dynamic> j, T Function(Object?) fromJsonT) =>
      _$PageFromJson(j, fromJsonT);
}
```

### 3.4.2 商品 / Sku / 分类

```dart
// features/product/domain/product.dart
@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String title,
    @Default('') String subtitle,
    @MoneyConverter() required Money price,
    @MoneyConverter() Money? originalPrice,
    @Default(<String>[]) List<String> images,
    @Default(0) int salesCount,
    @Default(false) bool inStock,
  }) = _Product;
  factory Product.fromJson(Map<String, dynamic> j) => _$ProductFromJson(j);
}

@freezed
class Sku with _$Sku {
  const factory Sku({
    required String id,
    required String productId,
    required String name,
    @MoneyConverter() required Money price,
    @Default(0) int stock,
    @Default(<String, String>{}) Map<String, String> attrs, // 颜色:红色, 尺寸:XL
  }) = _Sku;
  factory Sku.fromJson(Map<String, dynamic> j) => _$SkuFromJson(j);
}

@freezed
class ProductDetail with _$ProductDetail {
  const factory ProductDetail({
    required Product base,
    @Default('') String description,
    @Default(<Sku>[]) List<Sku> skus,
    @Default(<Review>[]) List<Review> reviews,
  }) = _ProductDetail;
  factory ProductDetail.fromJson(Map<String, dynamic> j) => _$ProductDetailFromJson(j);
}

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    required String userNickname,
    required String avatar,
    required int rating,            // 1-5
    required String content,
    @Default(<String>[]) List<String> images,
    required DateTime createdAt,
  }) = _Review;
  factory Review.fromJson(Map<String, dynamic> j) => _$ReviewFromJson(j);
}

// features/catalog/domain/category.dart
@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    @Default('') String icon,
    @Default(<Category>[]) List<Category> children,
  }) = _Category;
  factory Category.fromJson(Map<String, dynamic> j) => _$CategoryFromJson(j);
}
```

### 3.4.3 购物车

```dart
// features/cart/domain/cart_item.dart
@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required Product product,
    required Sku sku,
    required int quantity,
    @Default(true) bool selected,
  }) = _CartItem;
  factory CartItem.fromJson(Map<String, dynamic> j) => _$CartItemFromJson(j);
}

@freezed
class CartView with _$CartView {
  const CartView._();
  const factory CartView({@Default(<CartItem>[]) List<CartItem> items}) = _CartView;
  factory CartView.fromJson(Map<String, dynamic> j) => _$CartViewFromJson(j);

  // 派生属性（私有构造让我们能加 getter）
  List<CartItem> get selectedItems => items.where((it) => it.selected).toList();
  int get totalCents => selectedItems.fold(0, (s, it) => s + it.sku.price.cents * it.quantity);
  Money get total => Money(totalCents);
  bool get isEmpty => items.isEmpty;
  bool get allSelected => items.isNotEmpty && items.every((it) => it.selected);
}
```

### 3.4.4 地址

```dart
// features/address/domain/address.dart
@freezed
class Address with _$Address {
  const factory Address({
    required String id,
    required String name,
    required String phone,
    required String province,
    required String city,
    required String district,
    required String detail,
    @Default(false) bool isDefault,
  }) = _Address;
  factory Address.fromJson(Map<String, dynamic> j) => _$AddressFromJson(j);
}
```

### 3.4.5 优惠券

```dart
// features/coupon/domain/coupon.dart
@freezed
class Coupon with _$Coupon {
  const factory Coupon({
    required String id,
    required String name,
    @MoneyConverter() required Money discount,    // 减多少
    @MoneyConverter() required Money minTotal,    // 满多少可用
    required DateTime expiresAt,
  }) = _Coupon;
  factory Coupon.fromJson(Map<String, dynamic> j) => _$CouponFromJson(j);
}
```

### 3.4.6 订单

```dart
// features/order/domain/order.dart
enum OrderStatus {
  @JsonValue('PENDING_PAYMENT') pendingPayment,
  @JsonValue('PAID') paid,
  @JsonValue('SHIPPED') shipped,
  @JsonValue('COMPLETED') completed,
  @JsonValue('CANCELLED') cancelled,
  @JsonValue('REFUNDING') refunding,
}

@freezed
class Order with _$Order {
  const factory Order({
    required String id,
    required String orderNo,
    required OrderStatus status,
    required List<OrderItem> items,
    required Address address,
    @MoneyConverter() required Money subtotal,
    @MoneyConverter() required Money discount,
    @MoneyConverter() required Money shipping,
    @MoneyConverter() required Money total,
    @Default('') String remark,
    required DateTime createdAt,
    DateTime? paidAt,
    DateTime? shippedAt,
    DateTime? completedAt,
  }) = _Order;
  factory Order.fromJson(Map<String, dynamic> j) => _$OrderFromJson(j);
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String productId,
    required String productTitle,
    required String productCover,
    required String skuId,
    required String skuName,
    @MoneyConverter() required Money price,
    required int quantity,
  }) = _OrderItem;
  factory OrderItem.fromJson(Map<String, dynamic> j) => _$OrderItemFromJson(j);
}

@freezed
class CheckoutPreview with _$CheckoutPreview {
  const factory CheckoutPreview({
    required List<CartItem> items,
    Address? address,
    Coupon? coupon,
    @MoneyConverter() required Money subtotal,
    @MoneyConverter() required Money discount,
    @MoneyConverter() required Money shipping,
    @MoneyConverter() required Money total,
  }) = _CheckoutPreview;
  factory CheckoutPreview.fromJson(Map<String, dynamic> j) => _$CheckoutPreviewFromJson(j);
}
```

### 3.4.7 错误模型

```dart
// core/error/app_error.dart
@freezed
sealed class AppError with _$AppError implements Exception {
  const factory AppError.network(String message) = NetworkError;
  const factory AppError.unauthorized() = UnauthorizedError;
  const factory AppError.server({required int code, required String message}) = ServerError;
  const factory AppError.notFound(String resource) = NotFoundError;
  const factory AppError.validation(String message) = ValidationError;
  const factory AppError.unknown(String message) = UnknownError;
}
```

---

## 3.5 网络层装配

### 3.5.1 ApiResponse 拦截器（剥包装层）

```dart
// core/network/api_response_interceptor.dart
class ApiResponseUnwrapInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final data = response.data;
    if (data is Map<String, dynamic> && data.containsKey('code')) {
      final code = data['code'] as int;
      final message = data['message'] as String? ?? '';
      if (code == 0) {
        // 成功：把 data 部分作为 response.data，下游直接拿到业务数据
        response.data = data['data'];
        return handler.next(response);
      }
      // 失败：抛 ServerError，让上层 catch
      return handler.reject(DioException(
        requestOptions: response.requestOptions,
        response: response,
        error: AppError.server(code: code, message: message),
        message: message,
      ));
    }
    handler.next(response);
  }
}
```

> 🌟 这一招让所有 Repository 的代码都不用 `data['data']`，直接 `response.data` 就是业务对象，**省 50% 模板**。

### 3.5.2 错误映射

```dart
// core/error/error_mapper.dart
AppError mapDioException(DioException e) {
  // 拦截器已经把 ServerError 塞进 e.error
  if (e.error is AppError) return e.error as AppError;

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const AppError.network('网络超时');
    case DioExceptionType.connectionError:
      return const AppError.network('网络不可用');
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode ?? 0;
      if (code == 401) return const AppError.unauthorized();
      if (code == 404) return const AppError.notFound('资源');
      return AppError.server(code: code, message: e.message ?? '服务异常');
    default:
      return AppError.unknown(e.message ?? '未知错误');
  }
}
```

### 3.5.3 Dio 装配

```dart
// core/network/dio_provider.dart
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(
    baseUrl: AppEnv.apiBase,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 15),
    headers: {'Accept': 'application/json'},
  ));

  dio.interceptors.addAll([
    // 1) 注入 token
    InterceptorsWrapper(onRequest: (opt, handler) async {
      final session = await ref.read(secureSessionStorageProvider).read();
      if (session != null) {
        opt.headers['Authorization'] = 'Bearer ${session.accessToken}';
      }
      handler.next(opt);
    }),
    // 2) 401 自动刷新
    AuthInterceptor(dio, () async {
      final fresh = await ref.read(authServiceProvider).restoreSession();
      return fresh?.accessToken;
    }),
    // 3) 剥 ApiResponse
    ApiResponseUnwrapInterceptor(),
    // 4) 日志（仅 debug）
    if (kDebugMode) LogInterceptor(requestBody: true, responseBody: true),
  ]);

  return dio;
}
```

---

## 3.6 Repository 与 DataSource

### 3.6.1 Product

```dart
// features/product/data/product_remote_ds.dart
class ProductRemoteDataSource {
  final Dio _dio;
  ProductRemoteDataSource(this._dio);

  Future<ProductDetail> detail(String id) async {
    final r = await _dio.get('/products/$id');
    return ProductDetail.fromJson(r.data as Map<String, dynamic>);
  }

  Future<Page<Product>> search({required String q, int page = 1, int size = 20}) async {
    final r = await _dio.get('/products/search', queryParameters: {'q': q, 'page': page, 'size': size});
    return Page.fromJson(
      r.data as Map<String, dynamic>,
      (j) => Product.fromJson(j as Map<String, dynamic>),
    );
  }
}

// features/product/domain/product_repository.dart
abstract interface class ProductRepository {
  Future<ProductDetail> detail(String id);
  Future<Page<Product>> search({required String q, int page, int size});
}

// features/product/data/product_repository_impl.dart
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _remote;
  ProductRepositoryImpl(this._remote);
  @override
  Future<ProductDetail> detail(String id) => _remote.detail(id);
  @override
  Future<Page<Product>> search({required String q, int page = 1, int size = 20}) =>
      _remote.search(q: q, page: page, size: size);
}

// providers
@Riverpod(keepAlive: true)
ProductRepository productRepository(Ref ref) =>
    ProductRepositoryImpl(ProductRemoteDataSource(ref.watch(dioProvider)));
```

> 🌟 其他模块（Home / Catalog / Cart / Order / Address / Coupon）结构完全一致，只是接口和模型不同。下面只展示几个有特殊套路的。

### 3.6.2 Cart（前后端混合：本地缓存 + 服务端）

实战常见做法：登录前购物车在本地，登录后合并到服务端。简化版：登录后只走服务端，登录前禁用购物车。

```dart
class CartRemoteDataSource {
  final Dio _dio;
  CartRemoteDataSource(this._dio);

  Future<CartView> view() async {
    final r = await _dio.get('/cart');
    return CartView.fromJson(r.data as Map<String, dynamic>);
  }

  Future<CartView> add(String skuId, int qty) async {
    final r = await _dio.post('/cart/items', data: {'skuId': skuId, 'quantity': qty});
    return CartView.fromJson(r.data as Map<String, dynamic>);
  }

  Future<CartView> updateQty(String skuId, int qty) async {
    final r = await _dio.put('/cart/items/$skuId', data: {'quantity': qty});
    return CartView.fromJson(r.data as Map<String, dynamic>);
  }

  Future<CartView> remove(String skuId) async {
    final r = await _dio.delete('/cart/items/$skuId');
    return CartView.fromJson(r.data as Map<String, dynamic>);
  }
}

abstract interface class CartRepository {
  Future<CartView> view();
  Future<CartView> add(String skuId, int qty);
  Future<CartView> updateQty(String skuId, int qty);
  Future<CartView> remove(String skuId);
  Future<CartView> toggleSelect(String skuId, bool selected);
  Future<CartView> selectAll(bool selected);
}
```

### 3.6.3 Order

```dart
class OrderRemoteDataSource {
  final Dio _dio;
  OrderRemoteDataSource(this._dio);

  Future<CheckoutPreview> preview({
    required List<String> skuIds,
    required String? addressId,
    String? couponId,
  }) async {
    final r = await _dio.post('/orders/preview', data: {
      'skuIds': skuIds,
      'addressId': addressId,
      if (couponId != null) 'couponId': couponId,
    });
    return CheckoutPreview.fromJson(r.data as Map<String, dynamic>);
  }

  Future<Order> create({
    required List<String> skuIds,
    required String addressId,
    String? couponId,
    String? remark,
  }) async {
    final r = await _dio.post('/orders', data: {
      'skuIds': skuIds,
      'addressId': addressId,
      if (couponId != null) 'couponId': couponId,
      if (remark != null) 'remark': remark,
    });
    return Order.fromJson(r.data as Map<String, dynamic>);
  }

  Future<Page<Order>> list({OrderStatus? status, int page = 1, int size = 20}) async {
    final r = await _dio.get('/orders', queryParameters: {
      if (status != null) 'status': _statusCode(status),
      'page': page,
      'size': size,
    });
    return Page.fromJson(r.data as Map<String, dynamic>, (j) => Order.fromJson(j as Map<String, dynamic>));
  }

  String _statusCode(OrderStatus s) => switch (s) {
    OrderStatus.pendingPayment => 'PENDING_PAYMENT',
    OrderStatus.paid => 'PAID',
    OrderStatus.shipped => 'SHIPPED',
    OrderStatus.completed => 'COMPLETED',
    OrderStatus.cancelled => 'CANCELLED',
    OrderStatus.refunding => 'REFUNDING',
  };
}
```

---

## 3.7 状态层：Riverpod Notifier

### 3.7.1 首页

```dart
// features/home/presentation/home_controller.dart
@freezed
class HomeData with _$HomeData {
  const factory HomeData({
    required List<Banner> banners,
    required List<Category> categories,
    required List<FlashSale> flashSales,
    required List<Product> recommendations,
  }) = _HomeData;
}

@riverpod
class HomeController extends _$HomeController {
  @override
  Future<HomeData> build() async {
    final repo = ref.watch(homeRepositoryProvider);
    // 并发拉首页四个区块
    final results = await Future.wait([
      repo.banners(),
      repo.categories(),
      repo.flashSales(),
      repo.recommendations(page: 1, size: 20),
    ]);
    return HomeData(
      banners: results[0] as List<Banner>,
      categories: results[1] as List<Category>,
      flashSales: results[2] as List<FlashSale>,
      recommendations: (results[3] as Page<Product>).list,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => build());
  }
}
```

### 3.7.2 商品详情

```dart
@riverpod
Future<ProductDetail> productDetail(Ref ref, String productId) async {
  return ref.watch(productRepositoryProvider).detail(productId);
}
```

> ⚠️ 注意这里用的是函数式 Provider，参数会自动变成 family。每次进不同商品都是独立的 provider 实例。

### 3.7.3 购物车

```dart
@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  @override
  Future<CartView> build() async {
    if (!ref.watch(isLoggedInProvider)) {
      return const CartView();
    }
    return ref.watch(cartRepositoryProvider).view();
  }

  Future<void> add(String skuId, int qty) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(cartRepositoryProvider).add(skuId, qty));
  }

  Future<void> updateQty(String skuId, int qty) async {
    // 乐观更新
    final prev = state.valueOrNull;
    if (prev != null) {
      state = AsyncData(CartView(items: [
        for (final it in prev.items)
          if (it.sku.id == skuId) it.copyWith(quantity: qty) else it,
      ]));
    }
    try {
      final view = await ref.read(cartRepositoryProvider).updateQty(skuId, qty);
      state = AsyncData(view);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> remove(String skuId) async {
    final prev = state.valueOrNull;
    if (prev != null) {
      state = AsyncData(CartView(items: prev.items.where((it) => it.sku.id != skuId).toList()));
    }
    try {
      final view = await ref.read(cartRepositoryProvider).remove(skuId);
      state = AsyncData(view);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> toggleSelect(String skuId, bool selected) async {
    final prev = state.valueOrNull;
    if (prev == null) return;
    state = AsyncData(CartView(items: [
      for (final it in prev.items)
        if (it.sku.id == skuId) it.copyWith(selected: selected) else it,
    ]));
    // 这里通常 fire-and-forget，不阻塞 UI
    ref.read(cartRepositoryProvider).toggleSelect(skuId, selected).ignore();
  }
}

// 派生：购物车数量徽标
@riverpod
int cartBadgeCount(Ref ref) {
  return ref.watch(cartControllerProvider).maybeWhen(
    data: (v) => v.items.fold<int>(0, (s, it) => s + it.quantity),
    orElse: () => 0,
  );
}
```

### 3.7.4 订单列表（分页）

```dart
@freezed
class OrderListState with _$OrderListState {
  const factory OrderListState({
    @Default([]) List<Order> items,
    @Default(1) int page,
    @Default(false) bool hasMore,
    @Default(false) bool loading,
  }) = _OrderListState;
}

@riverpod
class OrderListController extends _$OrderListController {
  @override
  Future<OrderListState> build(OrderStatus? status) async {
    final r = await ref.watch(orderRepositoryProvider).list(status: status, page: 1, size: 20);
    return OrderListState(items: r.list, page: 1, hasMore: r.list.length >= 20);
  }

  Future<void> loadMore() async {
    final cur = state.valueOrNull;
    if (cur == null || cur.loading || !cur.hasMore) return;
    state = AsyncData(cur.copyWith(loading: true));
    try {
      final next = await ref.read(orderRepositoryProvider).list(status: status, page: cur.page + 1, size: 20);
      state = AsyncData(cur.copyWith(
        items: [...cur.items, ...next.list],
        page: cur.page + 1,
        hasMore: next.list.length >= 20,
        loading: false,
      ));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final r = await ref.read(orderRepositoryProvider).list(status: status, page: 1, size: 20);
      return OrderListState(items: r.list, page: 1, hasMore: r.list.length >= 20);
    });
  }
}
```

---

## 3.8 路由与守卫

`lib/core/routing/routes.dart`（go_router_builder）：

```dart
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

@TypedGoRoute<SplashRoute>(path: '/splash')
class SplashRoute extends GoRouteData {
  const SplashRoute();
  @override
  Widget build(BuildContext ctx, GoRouterState s) => const SplashPage();
}

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData {
  const LoginRoute();
  @override
  Widget build(BuildContext ctx, GoRouterState s) => const LoginPage();
}

@TypedStatefulShellRoute<MainShellRoute>(
  branches: [
    TypedStatefulShellBranch(routes: [TypedGoRoute<HomeRoute>(path: '/home')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<CatalogRoute>(path: '/catalog')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<CartRoute>(path: '/cart')]),
    TypedStatefulShellBranch(routes: [TypedGoRoute<ProfileRoute>(path: '/profile')]),
  ],
)
class MainShellRoute extends StatefulShellRouteData {
  const MainShellRoute();
  @override
  Widget builder(BuildContext ctx, GoRouterState s, StatefulNavigationShell shell) =>
      MainScaffold(shell: shell);
}

class HomeRoute extends GoRouteData {
  const HomeRoute();
  @override
  Widget build(BuildContext c, GoRouterState s) => const HomePage();
}

@TypedGoRoute<ProductDetailRoute>(path: '/product/:id')
class ProductDetailRoute extends GoRouteData {
  final String id;
  const ProductDetailRoute({required this.id});
  @override
  Widget build(BuildContext c, GoRouterState s) => ProductDetailPage(id: id);
}

@TypedGoRoute<CheckoutRoute>(path: '/checkout')
class CheckoutRoute extends GoRouteData {
  final String? skuIds;        // 用 ',' 分隔；也可以 push extra
  const CheckoutRoute({this.skuIds});
  @override
  Widget build(BuildContext c, GoRouterState s) =>
      CheckoutPage(skuIds: skuIds?.split(',') ?? const []);
}

@TypedGoRoute<OrdersRoute>(path: '/orders')
class OrdersRoute extends GoRouteData {
  final String? status;
  const OrdersRoute({this.status});
  @override
  Widget build(BuildContext c, GoRouterState s) => OrdersPage(initialStatus: _parse(status));
  static OrderStatus? _parse(String? s) => switch (s) {
    'pending' => OrderStatus.pendingPayment,
    'paid' => OrderStatus.paid,
    'shipped' => OrderStatus.shipped,
    _ => null,
  };
}

@TypedGoRoute<AddressListRoute>(path: '/addresses')
class AddressListRoute extends GoRouteData {
  final bool select;
  const AddressListRoute({this.select = false});
  @override
  Widget build(BuildContext c, GoRouterState s) => AddressListPage(selectMode: select);
}
```

跳转：

```dart
const ProductDetailRoute(id: '123').push(context);
const CheckoutRoute(skuIds: 'sku-1,sku-2').push(context);
const OrdersRoute(status: 'pending').go(context);
```

---

## 3.9 启动页 + 登录页

### 3.9.1 启动页

```dart
// features/auth/presentation/splash_page.dart
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // authControllerProvider 在 build 时会调 restoreSession。
    // 完成后 router 守卫会自动跳走，这里只显示 loading。
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlutterLogo(size: 96),
            SizedBox(height: 24),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
```

### 3.9.2 登录页

```dart
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 监听登录状态，错误时弹 SnackBar
    ref.listen(authControllerProvider, (prev, next) {
      next.whenOrNull(error: (e, _) {
        final msg = e is AppError ? _errorMessage(e) : '$e';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
      });
    });

    final loading = ref.watch(authControllerProvider).isLoading;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),
              const Text('欢迎来到 ShopX', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('选择登录方式', style: TextStyle(color: Colors.grey.shade600)),
              const Spacer(),

              // Apple 登录（iOS 必有；Android 也可显示走 Web）
              SignInButton.apple(
                loading: loading,
                onTap: () => ref.read(authControllerProvider.notifier).signInWithApple(),
              ),
              const SizedBox(height: 12),
              SignInButton.google(
                loading: loading,
                onTap: () => ref.read(authControllerProvider.notifier).signInWithGoogle(),
              ),
              const SizedBox(height: 24),
              Row(children: const [
                Expanded(child: Divider()),
                Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('或')),
                Expanded(child: Divider()),
              ]),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: loading ? null : () => _showEmailSheet(context, ref),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 14)),
                child: const Text('邮箱登录'),
              ),
              const SizedBox(height: 24),
              const Text(
                '登录即代表同意《用户协议》和《隐私政策》',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showEmailSheet(BuildContext ctx, WidgetRef ref) async {
    await showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) => const _EmailLoginSheet(),
    );
  }

  String _errorMessage(AppError e) => switch (e) {
    NetworkError(:final message) => '网络问题：$message',
    UnauthorizedError() => '账号或密码错误',
    ServerError(:final message) => message,
    _ => '登录失败',
  };
}

class SignInButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg, fg;
  final bool loading;
  final VoidCallback onTap;
  const SignInButton({super.key, required this.icon, required this.label, required this.bg, required this.fg, required this.loading, required this.onTap});

  factory SignInButton.apple({Key? key, required bool loading, required VoidCallback onTap}) =>
      SignInButton(key: key, icon: Icons.apple, label: '使用 Apple 登录', bg: Colors.black, fg: Colors.white, loading: loading, onTap: onTap);
  factory SignInButton.google({Key? key, required bool loading, required VoidCallback onTap}) =>
      SignInButton(key: key, icon: Icons.g_mobiledata, label: '使用 Google 登录', bg: Colors.white, fg: Colors.black87, loading: loading, onTap: onTap);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        padding: const EdgeInsets.symmetric(vertical: 14),
        side: bg == Colors.white ? BorderSide(color: Colors.grey.shade300) : BorderSide.none,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}

class _EmailLoginSheet extends ConsumerStatefulWidget {
  const _EmailLoginSheet();
  @override
  ConsumerState<_EmailLoginSheet> createState() => _EmailLoginSheetState();
}

class _EmailLoginSheetState extends ConsumerState<_EmailLoginSheet> {
  final _email = TextEditingController();
  final _pwd = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _email.dispose();
    _pwd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loading = ref.watch(authControllerProvider).isLoading;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: '邮箱'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) => (v ?? '').contains('@') ? null : '邮箱格式不对',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pwd,
                decoration: const InputDecoration(labelText: '密码'),
                obscureText: true,
                validator: (v) => (v?.length ?? 0) >= 6 ? null : '至少 6 位',
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: loading ? null : () async {
                  if (!_formKey.currentState!.validate()) return;
                  await ref.read(authControllerProvider.notifier).signInWithEmail(
                    email: _email.text,
                    password: _pwd.text,
                  );
                },
                child: loading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Text('登录'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## 3.10 首页（轮播 + 分类 + 推荐）

```dart
// features/home/presentation/home_page.dart
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncHome = ref.watch(homeControllerProvider);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.read(homeControllerProvider.notifier).refresh(),
        child: asyncHome.when(
          loading: () => const _HomeSkeleton(),
          error: (e, _) => _ErrorView(error: e, onRetry: () => ref.read(homeControllerProvider.notifier).refresh()),
          data: (data) => CustomScrollView(
            slivers: [
              const _SearchBar(),
              SliverToBoxAdapter(child: _BannerCarousel(banners: data.banners)),
              SliverToBoxAdapter(child: _CategoryGrid(categories: data.categories)),
              SliverToBoxAdapter(child: _FlashSaleSection(sales: data.flashSales)),
              const SliverToBoxAdapter(child: _SectionTitle('猜你喜欢')),
              SliverPadding(
                padding: const EdgeInsets.all(8),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => ProductCard(product: data.recommendations[i]),
                    childCount: data.recommendations.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: GestureDetector(
        onTap: () => const SearchRoute().push(context),
        child: Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Icon(Icons.search, size: 18, color: Colors.grey.shade600),
              const SizedBox(width: 8),
              Text('搜索商品', style: TextStyle(color: Colors.grey.shade600)),
            ],
          ),
        ),
      ),
    );
  }
}

class _BannerCarousel extends StatefulWidget {
  final List<Banner> banners;
  const _BannerCarousel({required this.banners});
  @override
  State<_BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<_BannerCarousel> {
  final _ctrl = PageController();
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!_ctrl.hasClients) return;
      _index = (_index + 1) % widget.banners.length;
      _ctrl.animateToPage(_index, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 7,
      child: PageView.builder(
        controller: _ctrl,
        itemCount: widget.banners.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (ctx, i) {
          final b = widget.banners[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(imageUrl: b.image, fit: BoxFit.cover),
            ),
          );
        },
      ),
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  final List<Category> categories;
  const _CategoryGrid({required this.categories});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: categories.take(10).map((c) => InkWell(
          onTap: () => CatalogRoute(categoryId: c.id).go(context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(radius: 22, backgroundImage: NetworkImage(c.icon)),
              const SizedBox(height: 4),
              Text(c.name, style: const TextStyle(fontSize: 12)),
            ],
          ),
        )).toList(),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});
  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).extension<AppPalette>()!;
    return InkWell(
      onTap: () => ProductDetailRoute(id: product.id).push(context),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: CachedNetworkImage(
                imageUrl: product.images.firstOrNull ?? '',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                       style: const TextStyle(fontSize: 13, height: 1.3)),
                  const SizedBox(height: 6),
                  Text(product.price.format(),
                       style: TextStyle(color: palette.price, fontSize: 16, fontWeight: FontWeight.bold)),
                  if (product.originalPrice != null)
                    Text(product.originalPrice!.format(),
                         style: const TextStyle(color: Colors.grey, fontSize: 11, decoration: TextDecoration.lineThrough)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 3.11 商品详情（轮播 + 规格 + 加购）

```dart
class ProductDetailPage extends ConsumerWidget {
  final String id;
  const ProductDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDetail = ref.watch(productDetailProvider(id));
    return Scaffold(
      body: asyncDetail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(error: e, onRetry: () => ref.invalidate(productDetailProvider(id))),
        data: (detail) => CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 360,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: _ImageGallery(images: detail.base.images),
              ),
            ),
            SliverToBoxAdapter(child: _PriceCard(product: detail.base)),
            SliverToBoxAdapter(child: _AttrsRow(detail: detail)),
            SliverToBoxAdapter(child: _ReviewsSection(reviews: detail.reviews)),
            SliverToBoxAdapter(child: _DescriptionSection(html: detail.description)),
            const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
          ],
        ),
      ),
      bottomNavigationBar: asyncDetail.maybeWhen(
        data: (d) => _DetailBottomBar(detail: d),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}

class _DetailBottomBar extends ConsumerWidget {
  final ProductDetail detail;
  const _DetailBottomBar({required this.detail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartCount = ref.watch(cartBadgeCountProvider);
    return SafeArea(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: Colors.grey.shade300)),
        ),
        child: Row(
          children: [
            _IconLabel(icon: Icons.support_agent, label: '客服'),
            Stack(children: [
              _IconLabel(
                icon: Icons.shopping_cart_outlined,
                label: '购物车',
                onTap: () => const CartRoute().go(context),
              ),
              if (cartCount > 0)
                Positioned(
                  right: 8,
                  top: 4,
                  child: _Badge(count: cartCount),
                ),
            ]),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () => _showSkuPicker(context, ref, detail, addToCartOnly: true),
                child: const Text('加入购物车'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(),
                ),
                onPressed: () => _showSkuPicker(context, ref, detail, buyNow: true),
                child: const Text('立即购买'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _showSkuPicker(
  BuildContext ctx,
  WidgetRef ref,
  ProductDetail detail, {
  bool addToCartOnly = false,
  bool buyNow = false,
}) async {
  final result = await showModalBottomSheet<({Sku sku, int qty})>(
    context: ctx,
    isScrollControlled: true,
    builder: (_) => SkuPickerSheet(detail: detail),
  );
  if (result == null) return;
  if (addToCartOnly) {
    await ref.read(cartControllerProvider.notifier).add(result.sku.id, result.qty);
    if (ctx.mounted) {
      ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text('已加入购物车')));
    }
  } else if (buyNow) {
    if (ctx.mounted) {
      // 直接进结算页（不进购物车）
      CheckoutRoute(skuIds: result.sku.id).push(ctx);
    }
  }
}

class SkuPickerSheet extends StatefulWidget {
  final ProductDetail detail;
  const SkuPickerSheet({super.key, required this.detail});
  @override
  State<SkuPickerSheet> createState() => _SkuPickerSheetState();
}

class _SkuPickerSheetState extends State<SkuPickerSheet> {
  Sku? _selected;
  int _qty = 1;

  @override
  void initState() {
    super.initState();
    _selected = widget.detail.skus.firstWhereOrNull((s) => s.stock > 0);
  }

  @override
  Widget build(BuildContext context) {
    final cur = _selected;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.detail.base.title, style: Theme.of(context).textTheme.titleMedium),
          if (cur != null) Text(cur.price.format(), style: const TextStyle(color: Colors.red, fontSize: 18)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: widget.detail.skus.map((s) {
              final selected = s.id == _selected?.id;
              final disabled = s.stock <= 0;
              return ChoiceChip(
                label: Text(s.name),
                selected: selected,
                onSelected: disabled ? null : (_) => setState(() => _selected = s),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('数量'),
              const Spacer(),
              IconButton(onPressed: _qty > 1 ? () => setState(() => _qty--) : null, icon: const Icon(Icons.remove_circle_outline)),
              Text('$_qty'),
              IconButton(onPressed: cur != null && _qty < cur.stock ? () => setState(() => _qty++) : null, icon: const Icon(Icons.add_circle_outline)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: cur == null ? null : () => Navigator.pop(context, (sku: cur, qty: _qty)),
              child: const Text('确定'),
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 3.12 购物车页

```dart
class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCart = ref.watch(cartControllerProvider);
    final palette = Theme.of(context).extension<AppPalette>()!;

    return Scaffold(
      appBar: AppBar(title: const Text('购物车')),
      body: asyncCart.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(error: e, onRetry: () => ref.invalidate(cartControllerProvider)),
        data: (cart) {
          if (cart.isEmpty) return const _EmptyCartView();
          return ListView.separated(
            itemCount: cart.items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (_, i) => _CartItemTile(item: cart.items[i]),
          );
        },
      ),
      bottomNavigationBar: asyncCart.maybeWhen(
        data: (cart) => cart.isEmpty ? null : _CartBottomBar(cart: cart, palette: palette),
        orElse: () => null,
      ),
    );
  }
}

class _CartItemTile extends ConsumerWidget {
  final CartItem item;
  const _CartItemTile({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(item.sku.id),
      direction: DismissDirection.endToStart,
      background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 24), child: const Icon(Icons.delete, color: Colors.white)),
      onDismissed: (_) => ref.read(cartControllerProvider.notifier).remove(item.sku.id),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Checkbox(
              value: item.selected,
              onChanged: (v) => ref.read(cartControllerProvider.notifier).toggleSelect(item.sku.id, v ?? false),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: item.product.images.firstOrNull ?? '',
                width: 80, height: 80, fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.product.title, maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(item.sku.name, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(item.sku.price.format(), style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      _QtyStepper(
                        value: item.quantity,
                        onChanged: (q) => ref.read(cartControllerProvider.notifier).updateQty(item.sku.id, q),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QtyStepper extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;
  const _QtyStepper({required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(4)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        InkWell(onTap: value > 1 ? () => onChanged(value - 1) : null, child: const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.remove, size: 16))),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 8), child: Text('$value')),
        InkWell(onTap: () => onChanged(value + 1), child: const Padding(padding: EdgeInsets.all(4), child: Icon(Icons.add, size: 16))),
      ]),
    );
  }
}

class _CartBottomBar extends ConsumerWidget {
  final CartView cart;
  final AppPalette palette;
  const _CartBottomBar({required this.cart, required this.palette});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = cart.selectedItems;
    return SafeArea(
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade300))),
        child: Row(
          children: [
            Checkbox(
              value: cart.allSelected,
              onChanged: (v) => ref.read(cartRepositoryProvider).selectAll(v ?? false),
            ),
            const Text('全选'),
            const Spacer(),
            const Text('合计: '),
            Text(cart.total.format(), style: TextStyle(color: palette.price, fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(width: 12),
            FilledButton(
              onPressed: selected.isEmpty
                  ? null
                  : () => CheckoutRoute(skuIds: selected.map((it) => it.sku.id).join(',')).push(context),
              child: Text('结算 (${selected.length})'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 3.13 下单流程（地址 + 优惠券 + 提交）

```dart
class CheckoutPage extends ConsumerStatefulWidget {
  final List<String> skuIds;
  const CheckoutPage({super.key, required this.skuIds});
  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  String? _addressId;
  String? _couponId;
  final _remarkCtl = TextEditingController();

  @override
  void dispose() {
    _remarkCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncPreview = ref.watch(checkoutPreviewProvider((
      skuIds: widget.skuIds,
      addressId: _addressId,
      couponId: _couponId,
    )));

    return Scaffold(
      appBar: AppBar(title: const Text('确认订单')),
      body: asyncPreview.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(error: e, onRetry: () => ref.invalidate(checkoutPreviewProvider)),
        data: (preview) => ListView(
          children: [
            _AddressTile(address: preview.address, onTap: () async {
              final picked = await const AddressListRoute(select: true).push<Address>(context);
              if (picked != null) setState(() => _addressId = picked.id);
            }),
            const Divider(height: 1),
            ...preview.items.map((it) => _CheckoutItemTile(item: it)),
            const Divider(height: 1),
            ListTile(
              title: const Text('优惠券'),
              subtitle: Text(preview.coupon?.name ?? '不使用'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final picked = await CouponPickerRoute(totalCents: preview.subtotal.cents).push<Coupon>(context);
                setState(() => _couponId = picked?.id);
              },
            ),
            const Divider(height: 1),
            ListTile(
              title: const Text('备注'),
              subtitle: TextField(
                controller: _remarkCtl,
                decoration: const InputDecoration(hintText: '选填', border: InputBorder.none),
              ),
            ),
            const Divider(height: 1),
            _AmountSummary(preview: preview),
          ],
        ),
      ),
      bottomNavigationBar: asyncPreview.maybeWhen(
        data: (preview) => SafeArea(
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text('合计: ${preview.total.format()}',
                    style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                FilledButton(
                  onPressed: preview.address == null ? null : () => _submit(preview),
                  child: const Text('提交订单'),
                ),
              ],
            ),
          ),
        ),
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }

  Future<void> _submit(CheckoutPreview preview) async {
    final order = await ref.read(orderRepositoryProvider).create(
          skuIds: widget.skuIds,
          addressId: _addressId!,
          couponId: _couponId,
          remark: _remarkCtl.text,
        );
    if (mounted) {
      // 清掉购物车里下单的商品（或者刷新）
      ref.invalidate(cartControllerProvider);
      // 跳转支付（这里简化为订单详情）
      OrderDetailRoute(id: order.id).pushReplacement(context);
    }
  }
}

@riverpod
Future<CheckoutPreview> checkoutPreview(
  Ref ref,
  ({List<String> skuIds, String? addressId, String? couponId}) args,
) async {
  return ref.watch(orderRepositoryProvider).preview(
    skuIds: args.skuIds,
    addressId: args.addressId,
    couponId: args.couponId,
  );
}
```

---

## 3.14 订单列表与详情

订单列表用 Tab 分状态，复用 `OrderListController`：

```dart
class OrdersPage extends StatelessWidget {
  final OrderStatus? initialStatus;
  const OrdersPage({super.key, this.initialStatus});

  @override
  Widget build(BuildContext context) {
    final tabs = const [
      (label: '全部', status: null),
      (label: '待付款', status: OrderStatus.pendingPayment),
      (label: '待发货', status: OrderStatus.paid),
      (label: '待收货', status: OrderStatus.shipped),
      (label: '已完成', status: OrderStatus.completed),
    ];
    final initialIndex = tabs.indexWhere((t) => t.status == initialStatus);

    return DefaultTabController(
      length: tabs.length,
      initialIndex: initialIndex >= 0 ? initialIndex : 0,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('我的订单'),
          bottom: TabBar(tabs: tabs.map((t) => Tab(text: t.label)).toList(), isScrollable: true),
        ),
        body: TabBarView(
          children: tabs.map((t) => _OrderListView(status: t.status)).toList(),
        ),
      ),
    );
  }
}

class _OrderListView extends ConsumerWidget {
  final OrderStatus? status;
  const _OrderListView({this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(orderListControllerProvider(status));
    return RefreshIndicator(
      onRefresh: () => ref.read(orderListControllerProvider(status).notifier).refresh(),
      child: asyncList.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => _ErrorView(error: e, onRetry: () => ref.invalidate(orderListControllerProvider(status))),
        data: (s) {
          if (s.items.isEmpty) return const _EmptyView(text: '没有订单');
          return ListView.separated(
            itemCount: s.items.length + (s.hasMore ? 1 : 0),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              if (i == s.items.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(orderListControllerProvider(status).notifier).loadMore();
                });
                return const Padding(padding: EdgeInsets.all(12), child: Center(child: CircularProgressIndicator()));
              }
              return _OrderCard(order: s.items[i]);
            },
          );
        },
      ),
    );
  }
}
```

订单详情 / 地址管理 / 优惠券选择 略——结构同上，省略以控制篇幅。

---

## 3.15 我的与设置

```dart
class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    return Scaffold(
      body: ListView(
        children: [
          _UserHeader(user: user),
          _OrderEntryRow(),
          _MenuSection(items: [
            _MenuItem(icon: Icons.location_on_outlined, label: '收货地址', onTap: () => const AddressListRoute().push(context)),
            _MenuItem(icon: Icons.confirmation_number_outlined, label: '优惠券', onTap: () => const MyCouponsRoute().push(context)),
            _MenuItem(icon: Icons.support_agent, label: '客服', onTap: () {}),
          ]),
          _MenuSection(items: [
            _MenuItem(icon: Icons.color_lens_outlined, label: '主题', onTap: () => _showThemeSheet(context, ref)),
            _MenuItem(icon: Icons.language, label: '语言', onTap: () => _showLocaleSheet(context, ref)),
            _MenuItem(icon: Icons.info_outline, label: '关于', onTap: () {}),
          ]),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton(
              onPressed: () async {
                await ref.read(authControllerProvider.notifier).signOut();
              },
              child: const Text('退出登录'),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderEntryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final entries = const [
      (icon: Icons.payment, label: '待付款', status: 'pending'),
      (icon: Icons.local_shipping_outlined, label: '待发货', status: 'paid'),
      (icon: Icons.inventory_2_outlined, label: '待收货', status: 'shipped'),
      (icon: Icons.rate_review_outlined, label: '已完成', status: 'completed'),
    ];
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: entries.map((e) => InkWell(
            onTap: () => OrdersRoute(status: e.status).push(context),
            child: Column(children: [
              Icon(e.icon, size: 28),
              const SizedBox(height: 4),
              Text(e.label, style: const TextStyle(fontSize: 12)),
            ]),
          )).toList(),
        ),
      ),
    );
  }
}
```

---

## 3.16 主题 / i18n / 错误处理装配

### 3.16.1 主题装配

```dart
// app.dart
class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'ShopX',
      debugShowCheckedModeBanner: false,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system,
      locale: ref.watch(localeProvider).valueOrNull,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(routerProvider),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 全局未捕获异常
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    // Sentry.captureException(details.exception, stackTrace: details.stack);
  };
  runApp(const ProviderScope(child: App()));
}
```

### 3.16.2 全局错误展示

业务里抛 `AppError`，UI 用 select 监听并统一展示：

```dart
// core/widgets/error_view.dart
class _ErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback? onRetry;
  const _ErrorView({required this.error, this.onRetry});

  @override
  Widget build(BuildContext context) {
    final msg = switch (error) {
      AppError e => switch (e) {
        NetworkError(:final message) => '网络问题：$message',
        UnauthorizedError() => '请重新登录',
        ServerError(:final message) => message,
        NotFoundError(:final resource) => '$resource 不存在',
        ValidationError(:final message) => message,
        UnknownError(:final message) => message,
      },
      _ => '$error',
    };
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.grey),
          const SizedBox(height: 12),
          Text(msg),
          if (onRetry != null) ...[
            const SizedBox(height: 12),
            TextButton(onPressed: onRetry, child: const Text('重试')),
          ],
        ],
      ),
    );
  }
}
```

---

## 3.17 测试用例选录

```dart
// test/features/cart/cart_controller_test.dart
class _MockRepo extends Mock implements CartRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(const CartView());
  });

  group('CartController', () {
    late ProviderContainer container;
    late _MockRepo repo;

    setUp(() {
      repo = _MockRepo();
      when(() => repo.view()).thenAnswer((_) async => const CartView());
      container = ProviderContainer(overrides: [
        cartRepositoryProvider.overrideWithValue(repo),
        // 假装登录
        isLoggedInProvider.overrideWith((ref) => true),
      ]);
      addTearDown(container.dispose);
    });

    test('add updates state with new view', () async {
      final newView = CartView(items: [
        CartItem(
          product: Product(id: 'p1', title: 'T', price: const Money(100)),
          sku: Sku(id: 'sku1', productId: 'p1', name: 'S', price: const Money(100)),
          quantity: 1,
        ),
      ]);
      when(() => repo.add('sku1', 1)).thenAnswer((_) async => newView);

      await container.read(cartControllerProvider.future);   // 等初始 build 完成
      await container.read(cartControllerProvider.notifier).add('sku1', 1);

      expect(container.read(cartControllerProvider).valueOrNull?.items.length, 1);
    });
  });
}

// test/features/auth/login_page_test.dart（widget test）
void main() {
  testWidgets('Apple button triggers signInWithApple', (tester) async {
    final controller = _SpyAuthController();
    await tester.pumpWidget(ProviderScope(
      overrides: [
        authControllerProvider.overrideWith(() => controller),
      ],
      child: const MaterialApp(home: LoginPage()),
    ));
    await tester.tap(find.text('使用 Apple 登录'));
    await tester.pump();
    expect(controller.appleCalled, true);
  });
}
```

更详细的测试约定参考主教程 Part 10。

---

## 3.18 上线前 checklist

- **代码质量**
  - [ ] `flutter analyze` 无错无警
  - [ ] `dart format .` 统一格式
  - [ ] 关键 Notifier 单测覆盖率 ≥ 70%
  - [ ] 关键页面 widget 测试覆盖
- **性能**
  - [ ] 首屏加载 < 2s（DevTools Frame 时间检查）
  - [ ] 列表滚动稳定 60fps（开 Performance Overlay）
  - [ ] 启动后内存 < 150MB
- **登录与安全**
  - [ ] Apple 登录在 iOS 真机走通
  - [ ] Google 登录在 Android 真机（带 GMS 设备）走通
  - [ ] 退出后 secure_storage 清空
  - [ ] 接口在抓包工具下不泄漏 token（HTTPS + 请求头不打 log）
- **业务关键路径冒烟**
  - [ ] 浏览商品 → 加购 → 下单 → 支付（真实金额测试）
  - [ ] 优惠券前后金额计算一致（前端预览 vs 服务端实际）
  - [ ] 网络中断后重连可恢复（拦截器测试）
- **上架材料**
  - [ ] 隐私政策 / 用户协议 URL
  - [ ] App Store Privacy Manifest（Apple/Google 登录都要声明数据用途）
  - [ ] 应用图标 / 启动图（至少 iOS @1x/2x/3x，Android mipmap-* 全套）
  - [ ] 应用截图（5 张，覆盖主要功能）
  - [ ] 版本号 + 构建号同步

---

> 📚 **本扩展到此结束**。三个专题（freezed 工作流 / 三方登录 / 电商实战）已经互相打通成可落地的工程模板。下一步建议：
>
> 1. 把 `lib/` 骨架按 §3.3 搭起来，先跑通登录 + 首页两条线。
> 2. 在 mock 模式下写完整业务流（用第 36 节的 MockInterceptor）。
> 3. 接到真后端时，仅替换 MockInterceptor，业务代码不动——这就是分层架构的回报。
>
> 仍有几个开放问题留给你确认（**支付方式 / IM 客服 / 推送 / 数据上报**）——任意一项告诉我，我可以为它再写一份专题扩展。
