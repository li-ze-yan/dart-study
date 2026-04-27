# Flutter 从入门到企业级实战（面向 Web 前端 · Dart 3.x · Flutter 3.27+）

> **前置阅读**：[`dart-tutorial-new.md`](dart-tutorial-new.md) — 本教程默认你已掌握 Dart 3 语法（Records / Patterns / sealed / extension type / null safety / async）。
>
> **目标读者**：有 React / Vue / Angular 等 Web 前端经验，希望系统进入 Flutter 移动端开发并具备企业级工程能力的开发者。
>
> **状态管理**：本教程以 **Riverpod 2.x** 为主，是当下 Flutter 官方文档力推、最现代的方案；Bloc / Provider 在附录略作对比。
>
> **平台覆盖**：移动端（iOS / Android）为主线；Flutter Web / Desktop 的差异与陷阱在附录单独讲。
>
> **学习路径**：Part 0–3 是地基（必读），Part 4–6 是日常业务能力，Part 7–11 是工程化武器，Part 12–15 是企业级架构与实战项目。

---

## 目录

### Part 0 · 心智模型
- [0. 写在前面：Web 前端 vs Flutter 的世界观差异](#0-写在前面web-前端-vs-flutter-的世界观差异)

### Part 1 · 环境与第一个项目
- [1. 环境搭建](#1-环境搭建)
- [2. 项目结构与运行调试](#2-项目结构与运行调试)

### Part 2 · Widget 基础（一切皆 Widget）
- [3. 第一性原理：Widget 是描述](#3-第一性原理widget-是描述)
- [4. StatelessWidget vs StatefulWidget](#4-statelesswidget-vs-statefulwidget)
- [5. 基础显示类 Widget](#5-基础显示类-widget)
- [6. 容器与装饰](#6-容器与装饰)
- [7. 布局：Row / Column / Stack / Flex](#7-布局row--column--stack--flex)
- [8. 滚动与列表（含 Slivers）](#8-滚动与列表含-slivers)
- [9. 输入与表单](#9-输入与表单)
- [10. 基础导航：Navigator 1.0](#10-基础导航navigator-10)

### Part 3 · Widget 进阶
- [11. 生命周期](#11-生命周期)
- [12. BuildContext 详解](#12-buildcontext-详解)
- [13. 三棵树：Widget / Element / RenderObject](#13-三棵树widget--element--renderobject)
- [14. Keys 详解](#14-keys-详解)
- [15. InheritedWidget：状态管理的根基](#15-inheritedwidget状态管理的根基)
- [16. 主题与 Material 3](#16-主题与-material-3)
- [17. 动画：隐式 / 显式 / Hero](#17-动画隐式--显式--hero)
- [18. 手势与触摸](#18-手势与触摸)

### Part 4 · 状态管理（Riverpod）
- [19. 为什么需要 Riverpod](#19-为什么需要-riverpod)
- [20. Riverpod 入门：Provider 全家桶](#20-riverpod-入门provider-全家桶)
- [21. ref.watch / read / listen 三剑客](#21-refwatch--read--listen-三剑客)
- [22. AsyncValue 与异步状态](#22-asyncvalue-与异步状态)
- [23. autoDispose / family / scope](#23-autodispose--family--scope)
- [24. Riverpod 实战：Todo App](#24-riverpod-实战todo-app)
- [25. Riverpod 最佳实践与陷阱](#25-riverpod-最佳实践与陷阱)

### Part 5 · 路由（go_router）
- [26. 为什么 Navigator 不够用](#26-为什么-navigator-不够用)
- [27. go_router 入门](#27-go_router-入门)
- [28. 嵌套路由 / Shell / Tab](#28-嵌套路由--shell--tab)
- [29. 路由守卫与重定向](#29-路由守卫与重定向)
- [30. 深链接（Deep Link）](#30-深链接deep-link)
- [31. 类型安全路由：go_router_builder](#31-类型安全路由go_router_builder)

### Part 6 · 网络层（Dio）
- [32. Dio 入门](#32-dio-入门)
- [33. 拦截器：日志 / Token / 错误](#33-拦截器日志--token--错误)
- [34. Token 自动刷新（队列 + 锁）](#34-token-自动刷新队列--锁)
- [35. RestClient 封装与 Repository 集成](#35-restclient-封装与-repository-集成)
- [36. Mock 与离线开发](#36-mock-与离线开发)

### Part 7 · 本地存储
- [37. 存储方案选型决策树](#37-存储方案选型决策树)
- [38. shared_preferences（KV）](#38-shared_preferenceskv)
- [39. Hive（NoSQL）](#39-hivenosql)
- [40. Isar（高性能）](#40-isar高性能)
- [41. Drift（SQL）](#41-driftsql)
- [42. flutter_secure_storage（安全存储）](#42-flutter_secure_storage安全存储)

### Part 8 · 主题与暗黑模式
- [43. ThemeData / ColorScheme / Material 3](#43-themedata--colorscheme--material-3)
- [44. 暗黑模式：跟随系统 + 手动切换](#44-暗黑模式跟随系统--手动切换)
- [45. ThemeExtension：自定义主题字段](#45-themeextension自定义主题字段)
- [46. 字体与图标资源](#46-字体与图标资源)

### Part 9 · 国际化
- [47. flutter_localizations + intl 标准方案](#47-flutter_localizations--intl-标准方案)
- [48. ARB 文件与 gen-l10n](#48-arb-文件与-gen-l10n)
- [49. 动态切换语言](#49-动态切换语言)
- [50. 复数 / 占位符 / 日期格式](#50-复数--占位符--日期格式)

### Part 10 · 测试金字塔
- [51. 测试分层与策略](#51-测试分层与策略)
- [52. 单元测试与 mocktail](#52-单元测试与-mocktail)
- [53. Widget 测试](#53-widget-测试)
- [54. 集成测试 integration_test](#54-集成测试-integration_test)
- [55. Golden Test（视觉回归）](#55-golden-test视觉回归)
- [56. 测试 Riverpod](#56-测试-riverpod)
- [57. 覆盖率与 CI 集成](#57-覆盖率与-ci-集成)

### Part 11 · DevTools 与性能优化
- [58. DevTools 总览](#58-devtools-总览)
- [59. 重建定位（Rebuild Indicator）](#59-重建定位rebuild-indicator)
- [60. 内存与对象泄漏](#60-内存与对象泄漏)
- [61. Frame / 60fps / Jank 分析](#61-frame--60fps--jank-分析)
- [62. Skia / Impeller 渲染管线简介](#62-skia--impeller-渲染管线简介)
- [63. Isolate 处理 CPU 密集任务](#63-isolate-处理-cpu-密集任务)
- [64. 图片优化与缓存](#64-图片优化与缓存)
- [65. 列表性能：RepaintBoundary / itemExtent](#65-列表性能repaintboundary--itemextent)

### Part 12 · 原生集成
- [66. Method Channel 基础](#66-method-channel-基础)
- [67. Pigeon：类型安全的桥](#67-pigeon类型安全的桥)
- [68. EventChannel：流式数据](#68-eventchannel流式数据)
- [69. FFI：调用 C/C++ 库](#69-ffi调用-cc-库)
- [70. 制作平台插件](#70-制作平台插件)

### Part 13 · CI/CD 与发布
- [71. 多环境 Flavor 配置](#71-多环境-flavor-配置)
- [72. 自动签名（Android / iOS）](#72-自动签名android--ios)
- [73. GitHub Actions 流水线](#73-github-actions-流水线)
- [74. fastlane / Codemagic 对比](#74-fastlane--codemagic-对比)
- [75. 灰度发布与热更新策略](#75-灰度发布与热更新策略)

### Part 14 · 架构思维
- [76. 项目结构：Feature-First vs Layer-First](#76-项目结构feature-first-vs-layer-first)
- [77. 分层架构：Presentation / Domain / Data](#77-分层架构presentation--domain--data)
- [78. Repository 与 Use Case 模式](#78-repository-与-use-case-模式)
- [79. 结果建模：sealed Result / Either](#79-结果建模sealed-result--either)
- [80. 错误处理与日志规范](#80-错误处理与日志规范)
- [81. 模块化与 melos 多包工程](#81-模块化与-melos-多包工程)

### Part 15 · 企业级实战项目
- [82. 项目目标：极简新闻阅读 App](#82-项目目标极简新闻阅读-app)
- [83. 模块拆分与目录骨架](#83-模块拆分与目录骨架)
- [84. 数据层：API + Repository + 缓存](#84-数据层api--repository--缓存)
- [85. 状态层：Riverpod Notifier](#85-状态层riverpod-notifier)
- [86. UI 层：列表 / 详情 / 收藏](#86-ui-层列表--详情--收藏)
- [87. 路由 + 主题 + i18n 装配](#87-路由--主题--i18n-装配)
- [88. 测试 + DevTools 调优](#88-测试--devtools-调优)

### 附录
- [附录 A：Web 前端 → Flutter 速查表](#附录-aweb-前端--flutter-速查表)
- [附录 B：Flutter Web 差异与陷阱](#附录-bflutter-web-差异与陷阱)
- [附录 C：常用 Pub 包推荐 + 学习资源](#附录-c常用-pub-包推荐--学习资源)
- [附录 D：需要你确认 / 决策的开放问题](#附录-d需要你确认--决策的开放问题)

---

# Part 0 · 心智模型

## 0. 写在前面：Web 前端 vs Flutter 的世界观差异

把 Flutter 想成"在画布上自己画 UI"，而不是"操作浏览器 DOM"。这是从 Web 切到 Flutter 时最大的认知颠覆。

### 0.1 关键差异速览

| 维度 | Web (React / Vue) | Flutter |
| --- | --- | --- |
| 渲染基底 | 浏览器 DOM + CSS | Skia / Impeller 直接绘制到 GPU |
| 视图构成 | HTML 标签 + 样式 | **Widget 树**，没有 HTML，没有 CSS |
| 样式 | CSS / Tailwind / styled-components | **Widget 属性**：`Container(padding: ..., decoration: ...)` |
| 布局 | flex / grid / position | **嵌套 Widget**：`Row` / `Column` / `Stack` / `Expanded` |
| 状态管理 | useState / Vuex / Pinia | setState / InheritedWidget / **Riverpod / Bloc** |
| 路由 | React Router / Vue Router | Navigator 1.0 / 2.0 / **go_router** |
| 异步 | Promise + async/await | Future + async/await（一致） |
| 流 | RxJS Observable | **Stream**（语言原生） |
| 包管理 | npm / pnpm + package.json | **pub** + pubspec.yaml |
| 类型系统 | TS（结构化） | Dart（名义化、强空安全） |
| 编译输出 | JS bundle | **AOT 原生码**（iOS Mach-O / Android ELF） |
| 热更新 | webpack HMR | **Hot Reload**（保留状态，更彻底） |

### 0.2 思维转换 7 条军规

1. **没有"全局 CSS"**：每个 Widget 自带样式，要复用样式靠 `Theme` / `TextStyle` 常量 / `ThemeExtension`，不靠选择器。
2. **没有"标签语义"**：Flutter 没有 `<header>` `<nav>` `<article>`，所有结构都是逻辑 Widget；语义靠 `Semantics` Widget 给屏幕阅读器。
3. **不要操作"DOM"**：Widget 是 **不可变描述**（immutable description），UI 变化是把整棵新 Widget 树扔给 framework，由 framework 算 diff、复用 Element / RenderObject。这点和 React 完全一致。
4. **没有"px 概念，只有 dp/lp"**：Flutter 的 1 逻辑像素跨设备一致，自动处理 DPI 缩放。`width: 100` 在所有设备上视觉大小近似。
5. **滚动是 Widget**：网页里 `<body>` 默认能滚，Flutter 默认 **不能滚**，要套 `SingleChildScrollView` / `ListView` / `CustomScrollView`。
6. **Build 方法被频繁调用，必须低成本**：`build()` 像 React 的 render，每次状态变都会跑。**禁止在 build 里做网络请求 / IO / 创建 Stream**。
7. **构造函数是核心 API**：`Container(child: Text(...))` 这种风格的本质是构造函数嵌套，而不是 JSX。理解这一点，自然就懂为什么参数都是命名参数。

### 0.3 第一性原理：Flutter 是什么

```
应用代码（Dart） → Widget 树 → Element 树（实例） → RenderObject 树（布局/绘制）
                                                                ↓
                                    Skia / Impeller GPU 绘制层
                                                                ↓
                                                         iOS / Android / Web Canvas
```

Flutter 不依赖系统的 UI 控件（不像 React Native 那样桥到 UIKit / View），而是**自己画**。
- 优点：跨平台像素级一致、性能可控、动画流畅。
- 代价：需要"自己重新发明" UI 体系（按钮、文本框、列表都是 Flutter 自己实现），所以 Material / Cupertino 两个组件库是必学。

---

# Part 1 · 环境与第一个项目

## 1. 环境搭建

### 1.1 安装 Flutter SDK

**macOS（推荐用 fvm 管理多版本）：**

```bash
# 一次性安装（用官方）
brew install --cask flutter

# 或用 fvm（多版本切换，推荐企业开发）
brew tap leoafarias/fvm
brew install fvm
fvm install 3.27.0
fvm global 3.27.0
```

**Windows / Linux**：参考 [docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)。

### 1.2 校验环境

```bash
flutter doctor -v
```

输出里要看到这几项 ✅：
- Flutter (Channel stable, 3.27.x)
- Android toolchain（要装 Android Studio + Android SDK + 命令行工具）
- Xcode（macOS 才有，开发 iOS 必装）
- Chrome（开发 Flutter Web）
- VS Code / Android Studio

> 💡 公司网络环境记得配 `PUB_HOSTED_URL` 和 `FLUTTER_STORAGE_BASE_URL` 镜像。

### 1.3 IDE 选择

| IDE | 适合 |
| --- | --- |
| **VS Code + Flutter 插件** | 轻量、启动快、和前端工作流接近，**推荐 Web 转 Flutter 的人** |
| **Android Studio + Flutter 插件** | 重度用户、调试 Android 原生层、Profiler 更强 |
| Cursor / Windsurf | 都基于 VS Code 内核，插件兼容 |

VS Code 必装插件：`Flutter`、`Dart`、`Error Lens`、`Pubspec Assist`。

### 1.4 创建第一个项目

```bash
flutter create my_app --org com.example --platforms=ios,android
cd my_app
flutter run
```

参数解释：
- `--org`：包名前缀（iOS Bundle ID / Android applicationId）。**一旦上架不可改**，慎选。
- `--platforms`：默认会创建 iOS / Android / Web / macOS / Linux / Windows 全套，按需缩。
- `--template=app|module|package|plugin`：日常用 `app`，做组件库用 `package`，做原生插件用 `plugin`。

---

## 2. 项目结构与运行调试

### 2.1 目录结构

```
my_app/
├── lib/                  # ★ 业务代码全在这
│   └── main.dart         # 入口文件
├── test/                 # 测试代码
├── ios/                  # iOS 原生工程（Xcode 项目）
├── android/              # Android 原生工程（Gradle 项目）
├── web/                  # Web 入口 index.html
├── assets/               # 自己创建：图片、字体、JSON 资源
├── pubspec.yaml          # ★ 依赖 + 资源声明（≈ package.json）
├── pubspec.lock          # 锁定版本（≈ package-lock.json）
├── analysis_options.yaml # 静态分析规则（≈ eslint config）
└── .metadata             # Flutter 内部元数据，别动
```

### 2.2 pubspec.yaml 核心字段

```yaml
name: my_app
description: A new Flutter project.
publish_to: 'none'   # 不发布到 pub.dev
version: 1.0.0+1     # 1.0.0 是 versionName，+1 是 versionCode

environment:
  sdk: ^3.6.0
  flutter: ">=3.27.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  # 后面会加：dio / go_router / flutter_riverpod / hive ...

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
    - assets/i18n/
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
```

依赖管理命令：

```bash
flutter pub add dio go_router flutter_riverpod
flutter pub add --dev mocktail
flutter pub get        # ≈ npm install
flutter pub upgrade    # ≈ npm update
flutter pub outdated   # 看哪些有新版本
```

### 2.3 第一段代码：Hello Flutter

替换 `lib/main.dart`：

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp：根容器，提供主题、路由、本地化
    return MaterialApp(
      title: 'Hello Flutter',
      theme: ThemeData(
        // Material 3 种子色（M3 推荐做法）
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold：页面骨架（顶栏、内容区、底栏、抽屉）
    return Scaffold(
      appBar: AppBar(title: const Text('首页')),
      body: const Center(
        child: Text(
          '你好，Flutter！',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
```

### 2.4 运行 / 热重载 / 热重启

```bash
# 列出可用设备
flutter devices

# 选择设备运行（不指定会让你选）
flutter run -d "iPhone 15"
flutter run -d chrome
flutter run -d macos

# 编译产物
flutter build apk --release
flutter build ios --release
flutter build web
flutter build appbundle      # Google Play 上架要 .aab
```

**热重载（Hot Reload, `r`）**：把改过的 Dart 代码注入正在运行的 VM，**保留 State**。
- 适合：改 UI 文案、样式、布局。
- 不适合：改了 `main()`、初始化逻辑、`StatefulWidget` 的 `initState` 字段类型——这种要 **Hot Restart（`R`）**，会重置整个 App。
- VS Code 保存即热重载（默认开启）。

### 2.5 静态分析与 lint

`analysis_options.yaml` 是 Flutter 的 ESLint：

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  language:
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
  errors:
    invalid_annotation_target: ignore

linter:
  rules:
    - prefer_const_constructors
    - prefer_const_literals_to_create_immutables
    - avoid_print
    - require_trailing_commas
```

> 💡 企业项目推荐换更严的：`very_good_analysis: ^6.0.0`。

---

# Part 2 · Widget 基础（一切皆 Widget）

## 3. 第一性原理：Widget 是描述

记住三句话：

1. **Widget 是不可变的（immutable）**：和 React 元素一样，是 UI 的"配置说明书"，不是真正在屏幕上画东西的东西。
2. **状态变化 = 重新生成 Widget 树**：framework 拿新旧 Widget 树 diff，决定哪些 Element 要更新。
3. **真正画东西的是 RenderObject**：你写的 99% 都是 Widget，底层 framework 维护一个 RenderObject 树做布局和绘制。

```dart
// 一个 Widget 的形态：纯描述，无副作用
class Hello extends StatelessWidget {
  final String name;
  const Hello({super.key, required this.name}); // 强烈建议加 const

  @override
  Widget build(BuildContext context) {
    return Text('你好，$name');
  }
}
```

> 🌟 **`const` 构造的重要性**：const Widget 实例会被复用，**永远不会触发重建**。能加就加（lint 也会提醒）。

---

## 4. StatelessWidget vs StatefulWidget

### 4.1 StatelessWidget：无内部状态

```dart
class Greeting extends StatelessWidget {
  final String name;
  const Greeting({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    // 只能读父 widget 传进来的参数（name），自己不持有可变状态
    return Text('Hello, $name');
  }
}
```

### 4.2 StatefulWidget：有可变状态

```dart
class Counter extends StatefulWidget {
  final int initial;
  const Counter({super.key, this.initial = 0});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  // 状态字段写在 State 里，Widget 类自己保持不可变
  late int _count = widget.initial;

  void _increment() {
    // ★ 必须用 setState，告诉 framework 要重建
    setState(() {
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('count = $_count'),
        ElevatedButton(onPressed: _increment, child: const Text('+1')),
      ],
    );
  }
}
```

### 4.3 关键概念：Widget 不可变，State 可变

```
StatefulWidget                  State<T>
   ↓ 创建一次                       ↓ 长期存在
不可变描述（每次 build 重新创建）   持有真正的可变状态
```

类比 React：`StatefulWidget` ≈ class component 的 props，`State` ≈ instance fields + `this.state`。但 Flutter 把这两件事 **强制分离** 到两个类。

### 4.4 何时选哪个

- **首选 Stateless**：能不依赖内部状态就不用，性能好、易测试。
- **必须 Stateful**：需要 `initState` / `dispose`、`AnimationController`、`TextEditingController`、监听焦点等带生命周期的资源。
- **复杂全局状态**：不要堆在 StatefulWidget 里！用 Riverpod（Part 4）。

### 4.5 完整场景：可受控展开的卡片

```dart
class ExpandableCard extends StatefulWidget {
  final String title;
  final String detail;
  const ExpandableCard({super.key, required this.title, required this.detail});

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () => setState(() => _expanded = !_expanded),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.title, style: Theme.of(context).textTheme.titleMedium),
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                ],
              ),
              // 用 AnimatedSize 让展开/收起带动画
              AnimatedSize(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.topLeft,
                child: _expanded
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(widget.detail),
                      )
                    : const SizedBox.shrink(),
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

## 5. 基础显示类 Widget

### 5.1 Text

```dart
Text(
  '你好，世界',
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.indigo,
    height: 1.4,        // 行高倍数
    letterSpacing: 0.5,
  ),
  maxLines: 2,
  overflow: TextOverflow.ellipsis,  // 超出显示 ...
  textAlign: TextAlign.center,
)
```

复杂格式用 `Text.rich`（≈ HTML 的 `<span>`）：

```dart
Text.rich(
  TextSpan(
    children: [
      const TextSpan(text: '已阅读 '),
      TextSpan(
        text: '《Flutter 实战》',
        style: const TextStyle(color: Colors.blue),
        // 可点击：附加手势识别器
        recognizer: TapGestureRecognizer()..onTap = () => print('点了书名'),
      ),
      const TextSpan(text: ' 共 3 小时'),
    ],
  ),
)
```

### 5.2 Image

```dart
// 资源图（要在 pubspec.yaml 注册 assets）
Image.asset('assets/images/logo.png', width: 100)

// 网络图（生产请用 cached_network_image）
Image.network(
  'https://example.com/avatar.jpg',
  width: 80,
  height: 80,
  fit: BoxFit.cover,        // 等价 CSS object-fit: cover
  loadingBuilder: (ctx, child, progress) {
    if (progress == null) return child;
    return const CircularProgressIndicator();
  },
  errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image),
)

// 内存中的字节
Image.memory(uint8ListBytes)

// 文件
Image.file(File('/path/to/file.png'))
```

> 🌟 生产推荐：`cached_network_image` 包，自动磁盘缓存 + 占位 + 错误图。

### 5.3 Icon

```dart
const Icon(Icons.favorite, size: 24, color: Colors.red)

// 自定义图标字体（Material Icons 之外）
const Icon(IconData(0xe900, fontFamily: 'MyIcons'))
```

### 5.4 按钮家族（Material 3）

```dart
ElevatedButton(
  onPressed: () {},
  child: const Text('提交'),
)

FilledButton(onPressed: () {}, child: const Text('强调'))

OutlinedButton(onPressed: () {}, child: const Text('次要'))

TextButton(onPressed: () {}, child: const Text('文字'))

IconButton(icon: const Icon(Icons.menu), onPressed: () {})

// 浮动按钮
FloatingActionButton(
  onPressed: () {},
  child: const Icon(Icons.add),
)

// 禁用：onPressed 传 null
ElevatedButton(onPressed: null, child: const Text('禁用'))

// 自定义样式
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.indigo,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  child: const Text('自定义'),
)
```

### 5.5 进度 / 加载 / 提示

```dart
const CircularProgressIndicator()
const LinearProgressIndicator(value: 0.6)

// SnackBar（瞬时提示）
ScaffoldMessenger.of(context).showSnackBar(
  const SnackBar(content: Text('保存成功')),
);

// Dialog
showDialog<bool>(
  context: context,
  builder: (ctx) => AlertDialog(
    title: const Text('确认'),
    content: const Text('确定删除？'),
    actions: [
      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),
      FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('删除')),
    ],
  ),
);

// 底部弹窗
showModalBottomSheet(
  context: context,
  builder: (ctx) => SizedBox(height: 200, child: Center(child: Text('内容'))),
);
```

---

## 6. 容器与装饰

### 6.1 Container：万能容器

```dart
Container(
  width: 200,
  height: 100,
  margin: const EdgeInsets.all(16),
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.grey.shade300),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.08),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ],
    gradient: const LinearGradient(
      colors: [Colors.blue, Colors.purple],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  ),
  alignment: Alignment.center,
  child: const Text('卡片'),
)
```

### 6.2 性能更好的细分 Widget

`Container` 是个"万能瑞士军刀"，但代价是有不必要的开销。**生产建议拆分**：

```dart
// 只要 padding：用 Padding
Padding(padding: const EdgeInsets.all(16), child: ...)

// 只要尺寸：用 SizedBox
const SizedBox(height: 8)             // 垂直间距
const SizedBox(width: 8)              // 水平间距
const SizedBox(width: 100, height: 50, child: ...)
const SizedBox.shrink()               // 占位，零尺寸

// 只要背景色：ColoredBox
const ColoredBox(color: Colors.amber, child: ...)

// 只要装饰：DecoratedBox
DecoratedBox(decoration: BoxDecoration(...), child: ...)

// 只要居中：Center
Center(child: ...)

// 圆角裁剪：ClipRRect
ClipRRect(borderRadius: BorderRadius.circular(12), child: image)
```

### 6.3 EdgeInsets 用法

```dart
EdgeInsets.all(16)                                 // 四向 16
EdgeInsets.symmetric(horizontal: 12, vertical: 8)  // 水平/垂直
EdgeInsets.only(left: 8, top: 16)                  // 单边
EdgeInsets.fromLTRB(8, 16, 8, 16)                  // 顺时针
```

---

## 7. 布局：Row / Column / Stack / Flex

### 7.1 Column / Row：一维布局

```dart
Column(
  // 主轴对齐（垂直方向）
  mainAxisAlignment: MainAxisAlignment.center,
  // 交叉轴对齐（水平方向）
  crossAxisAlignment: CrossAxisAlignment.stretch,
  // 主轴尺寸：max 占满父高，min 包裹内容
  mainAxisSize: MainAxisSize.min,
  children: const [
    Text('上'),
    SizedBox(height: 8),
    Text('中'),
    SizedBox(height: 8),
    Text('下'),
  ],
)
```

mainAxisAlignment 7 个值（≈ CSS justify-content）：
- `start` / `center` / `end`
- `spaceBetween`：两端贴边，中间均匀
- `spaceAround`：每个 child 两边等距
- `spaceEvenly`：所有间隔等大

### 7.2 Expanded / Flexible：弹性布局

```dart
// Expanded ≈ flex: 1 强制占满剩余
Row(
  children: [
    const Icon(Icons.menu),
    const SizedBox(width: 8),
    Expanded(child: TextField(decoration: InputDecoration(hintText: '搜索'))),
    const SizedBox(width: 8),
    const Icon(Icons.search),
  ],
)

// flex 比例
Row(
  children: [
    Expanded(flex: 2, child: Container(color: Colors.red)),
    Expanded(flex: 3, child: Container(color: Colors.blue)),
  ],
)

// Flexible：可以不占满
Flexible(fit: FlexFit.loose, child: Text('文本不超过自身宽度'))
```

> ⚠️ Row / Column 的 child 不能"无限大"。如果里面塞了 Text 太长，会爆 "RenderFlex overflowed by 30 px"。
> 解决：要么 `Expanded`，要么换成 `Wrap`（自动换行）。

### 7.3 Stack：层叠（≈ position: absolute）

```dart
Stack(
  alignment: Alignment.center,    // 默认 child 怎么对齐
  children: [
    Image.network(banner),
    // Positioned 控制具体位置
    const Positioned(
      bottom: 16,
      right: 16,
      child: Chip(label: Text('VIP')),
    ),
    Positioned.fill(child: Container(color: Colors.black26)),
  ],
)
```

### 7.4 Wrap：自动换行

```dart
Wrap(
  spacing: 8,           // 主轴间距
  runSpacing: 8,        // 换行间距
  children: tags.map((t) => Chip(label: Text(t))).toList(),
)
```

### 7.5 完整场景：评论卡片

```dart
class CommentCard extends StatelessWidget {
  final String avatar;
  final String name;
  final String time;
  final String content;
  final int likes;

  const CommentCard({
    super.key,
    required this.avatar,
    required this.name,
    required this.time,
    required this.content,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头像
          ClipOval(
            child: Image.network(
              avatar,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          // 右侧主体（用 Expanded 占满剩余宽度）
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 第一行：昵称 + 时间
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(time, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                // 内容
                Text(content, maxLines: 3, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                // 操作栏
                Row(
                  children: [
                    const Icon(Icons.favorite_border, size: 16),
                    const SizedBox(width: 4),
                    Text('$likes'),
                    const SizedBox(width: 16),
                    const Icon(Icons.reply, size: 16),
                    const SizedBox(width: 4),
                    const Text('回复'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
```

---

## 8. 滚动与列表（含 Slivers）

### 8.1 SingleChildScrollView：少量内容滚动

```dart
SingleChildScrollView(
  padding: const EdgeInsets.all(16),
  child: Column(
    children: [
      // 一堆少量 widget
    ],
  ),
)
```

> ⚠️ 内容多时**禁用** `SingleChildScrollView + Column`，会一次性 build 所有 child，内存炸裂。请用 `ListView`。

### 8.2 ListView：列表

```dart
// 静态列表（少量）
ListView(
  children: const [
    ListTile(leading: Icon(Icons.person), title: Text('个人资料')),
    ListTile(leading: Icon(Icons.settings), title: Text('设置')),
  ],
)

// 动态列表（推荐）：itemBuilder 懒加载
ListView.builder(
  itemCount: posts.length,
  itemBuilder: (ctx, i) => PostTile(post: posts[i]),
)

// 带分割线
ListView.separated(
  itemCount: posts.length,
  itemBuilder: (ctx, i) => PostTile(post: posts[i]),
  separatorBuilder: (ctx, i) => const Divider(height: 1),
)
```

### 8.3 GridView：网格

```dart
GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,        // 列数
    childAspectRatio: 0.75,   // 宽高比
    crossAxisSpacing: 8,
    mainAxisSpacing: 8,
  ),
  itemCount: products.length,
  itemBuilder: (ctx, i) => ProductCard(product: products[i]),
)

// 自动按宽度排：每个 item 最大 200 宽
GridView.builder(
  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 1,
  ),
  itemCount: 30,
  itemBuilder: (ctx, i) => Card(child: Center(child: Text('$i'))),
)
```

### 8.4 CustomScrollView + Slivers：复杂滚动

需求："顶部图片下拉收缩 + 中间网格 + 下面列表 + 一起滚动"——这是 Slivers 的舞台。

```dart
CustomScrollView(
  slivers: [
    // 1. 顶部可折叠 AppBar
    SliverAppBar(
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text('个人主页'),
        background: Image.network(coverUrl, fit: BoxFit.cover),
      ),
    ),
    // 2. 网格区
    SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        delegate: SliverChildBuilderDelegate(
          (ctx, i) => Card(child: Center(child: Text('G$i'))),
          childCount: 9,
        ),
      ),
    ),
    // 3. 列表区
    SliverList(
      delegate: SliverChildBuilderDelegate(
        (ctx, i) => ListTile(title: Text('Item $i')),
        childCount: 50,
      ),
    ),
  ],
)
```

### 8.5 下拉刷新 / 上拉加载

```dart
RefreshIndicator(
  onRefresh: () async {
    await ref.read(postsProvider.notifier).refresh();
  },
  child: ListView.builder(
    itemCount: posts.length + 1,
    itemBuilder: (ctx, i) {
      if (i == posts.length) {
        // 滚到底就触发加载更多（实战用 NotificationListener 更精细）
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(postsProvider.notifier).loadMore();
        });
        return const Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
      }
      return PostTile(post: posts[i]);
    },
  ),
)
```

> 生产推荐：`infinite_scroll_pagination` 或 `easy_refresh` 包，避免手撸。

---

## 9. 输入与表单

### 9.1 TextField：基础输入

```dart
class _LoginState extends State<Login> {
  // ★ 必须用 controller 才能拿值；State.dispose 时要 dispose
  final _emailCtl = TextEditingController();
  final _pwdCtl = TextEditingController();
  final _emailFocus = FocusNode();

  @override
  void dispose() {
    _emailCtl.dispose();
    _pwdCtl.dispose();
    _emailFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailCtl,
          focusNode: _emailFocus,
          keyboardType: TextInputType.emailAddress,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: '邮箱',
            hintText: 'you@example.com',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email),
          ),
          onChanged: (v) => print('实时: $v'),
          onSubmitted: (v) => FocusScope.of(context).nextFocus(),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _pwdCtl,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: '密码',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
```

### 9.2 Form + TextFormField：声明式校验

```dart
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // 用 GlobalKey 持有 Form 状态，便于触发校验、保存
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() {
    final form = _formKey.currentState!;
    if (!form.validate()) return;
    form.save();
    print('提交: $_email / $_password');
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: '邮箱'),
            validator: (v) {
              if (v == null || v.isEmpty) return '邮箱不能为空';
              if (!v.contains('@')) return '邮箱格式不对';
              return null;
            },
            onSaved: (v) => _email = v ?? '',
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: '密码'),
            obscureText: true,
            validator: (v) => (v?.length ?? 0) < 6 ? '至少 6 位' : null,
            onSaved: (v) => _password = v ?? '',
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _submit, child: const Text('注册')),
        ],
      ),
    );
  }
}
```

### 9.3 其他常见输入控件

```dart
// 复选框
Checkbox(value: agreed, onChanged: (v) => setState(() => agreed = v ?? false))

// 单选按钮
Radio<int>(value: 1, groupValue: selected, onChanged: (v) => setState(() => selected = v))

// 开关
Switch(value: dark, onChanged: (v) => setState(() => dark = v))

// 滑块
Slider(value: volume, min: 0, max: 100, onChanged: (v) => setState(() => volume = v))

// 下拉
DropdownButton<String>(
  value: lang,
  items: const [
    DropdownMenuItem(value: 'zh', child: Text('中文')),
    DropdownMenuItem(value: 'en', child: Text('English')),
  ],
  onChanged: (v) => setState(() => lang = v ?? 'zh'),
)

// 日期选择
final picked = await showDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2000),
  lastDate: DateTime(2099),
);
```

---

## 10. 基础导航：Navigator 1.0

> 🌟 现代项目应直接用 `go_router`（Part 5），但理解 Navigator 1.0 是基础。

### 10.1 push / pop

```dart
// 进入新页面
final result = await Navigator.push<bool>(
  context,
  MaterialPageRoute(builder: (_) => const DetailPage()),
);
if (result == true) {
  print('从详情页返回时带回了 true');
}

// 返回（带值）
Navigator.pop(context, true);

// 替换（不能返回上一页）
Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));

// 清空栈到某条件
Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(builder: (_) => const HomePage()),
  (route) => false,
);
```

### 10.2 命名路由

```dart
MaterialApp(
  routes: {
    '/': (ctx) => const HomePage(),
    '/login': (ctx) => const LoginPage(),
    '/profile': (ctx) => const ProfilePage(),
  },
  initialRoute: '/',
)

// 跳转
Navigator.pushNamed(context, '/login');

// 传参
Navigator.pushNamed(context, '/profile', arguments: userId);
final userId = ModalRoute.of(context)!.settings.arguments as String;
```

### 10.3 痛点（why we need go_router）

- 命名路由不带类型；参数传错只能运行时崩。
- Web 上深链接、浏览器后退按钮支持差。
- 嵌套路由（Tab 内独立栈）几乎不能用。

→ Part 5 解决。

---

# Part 3 · Widget 进阶

## 11. 生命周期

### 11.1 StatelessWidget 生命周期

只有 `build()`。每次父级重建可能就重新构造一次。

### 11.2 StatefulWidget / State 完整生命周期

```
createState()           ★ 仅一次：创建 State 实例
   ↓
initState()             ★ 仅一次：State 加入树。订阅、初始化
   ↓
didChangeDependencies() 多次：依赖（InheritedWidget / Theme）变更
   ↓
build()                 多次：重建 UI
   ↓
didUpdateWidget(old)    多次：父级 Widget 配置变（同 key 同 type 才会进这里，否则销毁重建）
   ↓
deactivate() → activate() 罕见：从树里移除又插回去（如 GlobalKey 跨树搬运）
   ↓
dispose()               ★ 仅一次：State 永久销毁。释放资源
```

### 11.3 各阶段做什么

```dart
class _MyState extends State<MyWidget> {
  late StreamSubscription _sub;
  late TextEditingController _ctl;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // ✅ 创建 controller / 订阅事件 / 启动定时器
    _ctl = TextEditingController();
    _sub = someStream.listen(_onData);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => print('tick'));

    // ❌ 这里不能用 context 访问 Theme / MediaQuery / InheritedWidget
    // 真要用：放到 didChangeDependencies
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // ✅ 依赖变化时（首次进入 + 依赖更新）执行
    final lang = Localizations.localeOf(context);
    print('当前语言: $lang');
  }

  @override
  void didUpdateWidget(covariant MyWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // ✅ 父传入参数变了，这里同步内部状态
    if (oldWidget.userId != widget.userId) {
      _reloadData();
    }
  }

  @override
  void dispose() {
    // ✅ 必须释放资源；忘记会内存泄漏
    _sub.cancel();
    _timer?.cancel();
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ✅ 纯描述，不要做副作用
    return TextField(controller: _ctl);
  }
}
```

### 11.4 App 级别生命周期：WidgetsBindingObserver

```dart
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:    // App 回到前台
      case AppLifecycleState.inactive:   // 即将进入后台（iOS）
      case AppLifecycleState.paused:     // 在后台
      case AppLifecycleState.detached:   // 引擎被销毁
      case AppLifecycleState.hidden:     // 隐藏（桌面）
    }
  }
}
```

---

## 12. BuildContext 详解

### 12.1 BuildContext 是什么

每个 Widget 在树里都对应一个 Element，**BuildContext 就是 Element 的接口**。它知道自己在树里的位置，可以向上查找祖先。

### 12.2 常用查找

```dart
// 拿到当前主题
final theme = Theme.of(context);
final colors = Theme.of(context).colorScheme;

// 拿到屏幕尺寸 / 状态栏高度
final size = MediaQuery.sizeOf(context);
final padding = MediaQuery.paddingOf(context);

// 拿到 Scaffold（用 of 调用方法）
ScaffoldMessenger.of(context).showSnackBar(...);

// 拿到 Navigator
Navigator.of(context).push(...);

// 拿到自定义 InheritedWidget
final user = UserScope.of(context);
```

### 12.3 ★ 经典坑：跨页面 / Builder 用错 context

```dart
// ❌ 错误：在 onPressed 里用了外层 build 的 context，可能是 MaterialApp 上层
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: ElevatedButton(
      onPressed: () {
        // 这个 context 是 Scaffold 之上的，找不到 ScaffoldMessenger
        ScaffoldMessenger.of(context).showSnackBar(...);
      },
      child: const Text('提示'),
    ),
  );
}

// ✅ 正确：用 Builder 包一层，拿到 Scaffold 之下的 context
Builder(
  builder: (context) => ElevatedButton(
    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(...),
    child: const Text('提示'),
  ),
)
```

### 12.4 mounted 检查（异步必须）

```dart
Future<void> _save() async {
  await api.save();
  // 异步完成时 widget 可能已经被销毁，访问 setState / context 会抛异常
  if (!mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已保存')));
}
```

> Dart 3.2+ 起，`if (!mounted) return;` 之后，Dart 编译器会理解后续代码 `mounted` 仍为 true（context safety promotion），可放心访问 context。

---

## 13. 三棵树：Widget / Element / RenderObject

### 13.1 三棵树职责

| 树 | 角色 | 何时创建 | 类比 |
| --- | --- | --- | --- |
| **Widget** | 描述（不可变） | 每次 build 都新建 | React 的 Virtual DOM 节点 |
| **Element** | 实例（带状态） | 首次插入时创建，后续 mount/update | React Fiber |
| **RenderObject** | 真正布局/绘制 | 由 Element 在合适时机创建 | 浏览器 layout/paint 节点 |

```
你的代码           Framework 内部
=====              ============
Container(...)  →  ContainerElement → RenderConstrainedBox / RenderPadding / ...
Text(...)       →  StatelessElement → RenderParagraph
Column(...)     →  StatelessElement → RenderFlex
```

### 13.2 复用机制（性能关键）

framework 复用 Element 的规则：

> **新旧 Widget 的 `runtimeType` 和 `key` 都相同时，Element 会被复用，state 保持。**

理解了这条，就懂 95% 的 Flutter 性能问题。

### 13.3 实例：状态错位

```dart
class Demo extends StatefulWidget {
  const Demo({super.key});
  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  bool flipped = false;

  @override
  Widget build(BuildContext context) {
    final tiles = [
      const ColorTile(color: Colors.red),
      const ColorTile(color: Colors.blue),
    ];
    return Column(
      children: [
        Row(children: flipped ? tiles.reversed.toList() : tiles),
        TextButton(onPressed: () => setState(() => flipped = !flipped), child: const Text('交换')),
      ],
    );
  }
}

class ColorTile extends StatefulWidget {
  final Color color;
  const ColorTile({super.key, required this.color});
  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  int taps = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => taps++),
      child: Container(
        width: 100,
        height: 100,
        color: widget.color,
        child: Center(child: Text('$taps', style: const TextStyle(color: Colors.white))),
      ),
    );
  }
}
```

**问题**：你给红色块点了 5 下，然后点"交换"。期待"5 跟着红色走"，实际"5 留在原位置（变蓝）"——因为 framework 按位置复用 Element，左边永远是同一个 ColorTile Element，state 不变。

**修复**：给每个 ColorTile 加 `key: ValueKey(widget.color)`。这样 framework 就按 key 匹配，state 跟着 key 走。下一节细讲。

---

## 14. Keys 详解

### 14.1 什么时候需要 Key

99% 的 widget 不需要 key。**需要 key 的两种场景**：

1. **同一层有多个同类型 widget，它们的顺序会变**（重排、增删、过滤）。
2. **跨树搬运 state**（用 `GlobalKey`）。

### 14.2 Key 类型

```dart
// 1. ValueKey：用值匹配
ValueKey(item.id)
ValueKey('header')

// 2. ObjectKey：用对象 identity 匹配
ObjectKey(myObject)

// 3. UniqueKey：每次都不同（用于强制 element 重建）
UniqueKey()

// 4. GlobalKey：全局唯一，跨树搬 state
final formKey = GlobalKey<FormState>();
formKey.currentState?.validate();
```

### 14.3 GlobalKey 应用：拿到 State

```dart
// 用 GlobalKey 拿到 child 的 State
final scaffoldKey = GlobalKey<ScaffoldState>();

Scaffold(
  key: scaffoldKey,
  body: ...,
);

// 在别处：
scaffoldKey.currentState?.openDrawer();
```

### 14.4 ⚠️ GlobalKey 滥用警告

- GlobalKey **昂贵**（创建 / 维护成本）。
- 同时只能挂一个位置；重复挂会运行时报错。
- 跨页面状态共享 → 用 Riverpod，不要用 GlobalKey。

---

## 15. InheritedWidget：状态管理的根基

理解 InheritedWidget = 理解所有 Flutter 状态管理库（Provider / Riverpod / Bloc）的内核。

### 15.1 工作原理

InheritedWidget 把数据"放到 Element 树上"，子树通过 `context` 一行向上找最近的祖先并**注册依赖**。当 InheritedWidget 重建并 `updateShouldNotify` 返回 true 时，所有依赖它的 Element 自动 rebuild。

### 15.2 手撸一个

```dart
class CounterScope extends InheritedWidget {
  final int count;
  final VoidCallback increment;

  const CounterScope({
    super.key,
    required this.count,
    required this.increment,
    required super.child,
  });

  /// 提供给 children 的 of 方法
  static CounterScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<CounterScope>();
    assert(scope != null, '没有找到 CounterScope，请把它放在更上层');
    return scope!;
  }

  @override
  bool updateShouldNotify(CounterScope old) => count != old.count;
}

// 顶层用一个 StatefulWidget 持有真正的可变状态
class CounterRoot extends StatefulWidget {
  final Widget child;
  const CounterRoot({super.key, required this.child});
  @override
  State<CounterRoot> createState() => _CounterRootState();
}

class _CounterRootState extends State<CounterRoot> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return CounterScope(
      count: _count,
      increment: () => setState(() => _count++),
      child: widget.child,
    );
  }
}

// 子 widget 任意位置消费
class _Display extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scope = CounterScope.of(context);
    return Text('当前: ${scope.count}');
  }
}
```

> 实战中**几乎不用手写 InheritedWidget**——直接上 Riverpod。但内部原理就是这个。

---

## 16. 主题与 Material 3

### 16.1 ThemeData 全貌

```dart
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6750A4),
      brightness: Brightness.light,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 14, height: 1.5),
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ),
)
```

### 16.2 Material 3 种子色 → 完整调色板

```dart
final cs = ColorScheme.fromSeed(seedColor: Colors.indigo);
print(cs.primary);              // 品牌主色
print(cs.onPrimary);            // 主色上的文字
print(cs.surface);              // 卡片/面板底色
print(cs.surfaceContainerHigh); // M3 新增层级背景
print(cs.error);
```

### 16.3 在 Widget 中使用主题

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);
  final cs = theme.colorScheme;
  final tt = theme.textTheme;
  return Container(
    color: cs.surfaceContainerHigh,
    child: Text('标题', style: tt.titleLarge?.copyWith(color: cs.primary)),
  );
}
```

第 43–46 节会展开主题体系、暗黑模式与 ThemeExtension。

---

## 17. 动画：隐式 / 显式 / Hero

### 17.1 隐式动画（最简单）

属性变化自动过渡：

```dart
class ColorBox extends StatefulWidget {
  const ColorBox({super.key});
  @override
  State<ColorBox> createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> {
  bool big = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => big = !big),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: big ? 200 : 100,
        height: big ? 200 : 100,
        color: big ? Colors.indigo : Colors.amber,
      ),
    );
  }
}
```

常用隐式 widget：`AnimatedContainer` / `AnimatedOpacity` / `AnimatedAlign` / `AnimatedDefaultTextStyle` / `AnimatedSwitcher` / `AnimatedSize` / `AnimatedPositioned`。

### 17.2 显式动画（控制力强）

```dart
class PulseDot extends StatefulWidget {
  const PulseDot({super.key});
  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _scale = Tween(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
    );
  }
}
```

### 17.3 Hero：跨页面共享元素动画

```dart
// A 页：
Hero(tag: 'avatar-${user.id}', child: CircleAvatar(...))

// B 页同样的 tag：
Hero(tag: 'avatar-${user.id}', child: CircleAvatar(radius: 80, ...))
```

push 进入 B 页时，Flutter 自动用动画把头像从 A 的位置飞到 B 的位置。

### 17.4 推荐第三方包

- `flutter_animate` —— 一行链式动画
- `lottie` —— 渲染 Lottie 动画
- `rive` —— Rive 矢量动画

---

## 18. 手势与触摸

### 18.1 GestureDetector：万能手势

```dart
GestureDetector(
  onTap: () => print('单击'),
  onDoubleTap: () => print('双击'),
  onLongPress: () => print('长按'),
  onPanStart: (d) => print('拖拽开始 ${d.localPosition}'),
  onPanUpdate: (d) => print('拖拽中 ${d.delta}'),
  onPanEnd: (d) => print('拖拽结束 ${d.velocity}'),
  child: Container(width: 200, height: 200, color: Colors.amber),
)
```

### 18.2 InkWell：带 Material 水波纹

```dart
Material(
  color: Colors.transparent,
  child: InkWell(
    onTap: () {},
    borderRadius: BorderRadius.circular(8),
    splashColor: Colors.indigo.withOpacity(0.2),
    child: const Padding(padding: EdgeInsets.all(16), child: Text('点我')),
  ),
)
```

> ⚠️ InkWell 的水波纹必须挂在 `Material` 子树里，否则不显示。

### 18.3 拖拽 Draggable

```dart
Draggable<String>(
  data: 'apple',
  feedback: const Material(child: Text('🍎', style: TextStyle(fontSize: 40))),
  childWhenDragging: const Opacity(opacity: 0.3, child: Text('🍎')),
  child: const Text('🍎'),
)

DragTarget<String>(
  onAcceptWithDetails: (d) => print('收到 ${d.data}'),
  builder: (ctx, candidate, rejected) => Container(
    width: 100, height: 100,
    color: candidate.isEmpty ? Colors.grey : Colors.green,
  ),
)
```

---

# Part 4 · 状态管理（Riverpod）

## 19. 为什么需要 Riverpod

### 19.1 setState 的天花板

`setState` 适合：**单个 Widget 自己的临时状态**（输入框开关、展开收起）。

不适合：
- 跨页面共享（购物车、登录用户）
- 需要单元测试的业务逻辑
- 异步加载 + 缓存
- 复杂派生状态

### 19.2 InheritedWidget → Provider → Riverpod 演化

| 阶段 | 做法 | 痛点 |
| --- | --- | --- |
| InheritedWidget 裸写 | 手写 of(context) | 模板代码爆炸 |
| Provider 包 | ChangeNotifierProvider 等 | 依赖 BuildContext，测试难，运行时找不到会崩 |
| **Riverpod** | 全局 ref，编译期类型检查 | 学习曲线陡，但工程化收益大 |

### 19.3 Riverpod 核心三个改进

1. **不依赖 BuildContext**：在测试 / 后台任务里也能取到 provider。
2. **编译期类型安全**：`ref.watch(counterProvider)` 自动推断类型，错的代码编译不过。
3. **autoDispose / family**：自动清理、参数化。这两个特性 Provider 包没有。

---

## 20. Riverpod 入门：Provider 全家桶

### 20.1 安装

```bash
flutter pub add flutter_riverpod riverpod_annotation
flutter pub add --dev riverpod_generator build_runner custom_lint riverpod_lint
```

`pubspec.yaml` 末尾添加：

```yaml
dev_dependencies:
  build_runner: ^2.4.13
  riverpod_generator: ^2.6.0
```

`analysis_options.yaml`：

```yaml
analyzer:
  plugins:
    - custom_lint
```

### 20.2 全局包裹 ProviderScope

```dart
void main() {
  runApp(const ProviderScope(child: MyApp()));
}
```

> `ProviderScope` 是所有 provider 的容器，**只能有一个**（除非测试或局部 override）。

### 20.3 Provider：纯派生值

```dart
// 用代码生成（推荐）
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'config.g.dart';

@riverpod
String appName(Ref ref) => 'My Awesome App';

@riverpod
String greeting(Ref ref) {
  final name = ref.watch(appNameProvider);
  return '欢迎使用 $name';
}
```

```bash
dart run build_runner watch -d
```

UI 里消费：

```dart
class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final greeting = ref.watch(greetingProvider);
    return Text(greeting);
  }
}
```

### 20.4 NotifierProvider：可变状态（最常用）

```dart
@riverpod
class CounterController extends _$CounterController {
  @override
  int build() => 0;   // 初始值

  void increment() => state++;
  void decrement() => state--;
  void reset() => state = 0;
}
```

UI：

```dart
class CounterPage extends ConsumerWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterControllerProvider);
    return Scaffold(
      body: Center(child: Text('$count', style: const TextStyle(fontSize: 48))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterControllerProvider.notifier).increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 20.5 AsyncNotifierProvider：异步状态

```dart
@riverpod
class TodoList extends _$TodoList {
  @override
  Future<List<Todo>> build() async {
    final api = ref.watch(apiClientProvider);
    return api.fetchTodos();
  }

  Future<void> add(String title) async {
    final api = ref.read(apiClientProvider);
    final newTodo = await api.create(title);
    state = AsyncData([...?state.value, newTodo]);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(apiClientProvider).fetchTodos());
  }
}
```

UI 用 `AsyncValue` 模式匹配：

```dart
final asyncTodos = ref.watch(todoListProvider);

return asyncTodos.when(
  data: (todos) => ListView.builder(
    itemCount: todos.length,
    itemBuilder: (_, i) => ListTile(title: Text(todos[i].title)),
  ),
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (e, st) => Center(child: Text('出错了: $e')),
);
```

### 20.6 FutureProvider / StreamProvider（无副作用方法时简版）

```dart
@riverpod
Future<User> currentUser(Ref ref) async {
  return ref.watch(apiClientProvider).me();
}

@riverpod
Stream<int> tickStream(Ref ref) {
  return Stream.periodic(const Duration(seconds: 1), (i) => i);
}
```

---

## 21. ref.watch / read / listen 三剑客

### 21.1 watch：声明依赖（在 build 里用）

```dart
final user = ref.watch(currentUserProvider);  // user 变了，build 重跑
```

### 21.2 read：一次性读取（在事件回调里用）

```dart
ElevatedButton(
  onPressed: () {
    // ❌ 这里**禁止**用 watch；按钮回调里 watch 没意义
    ref.read(counterControllerProvider.notifier).increment();
  },
  child: const Text('+1'),
)
```

> 🌟 **铁律**：`build` 里用 `watch`，回调 / 异步里用 `read`。

### 21.3 listen：副作用监听（导航 / 弹窗 / SnackBar）

```dart
@override
Widget build(BuildContext context, WidgetRef ref) {
  // 不影响 UI rebuild，仅在变化时触发回调
  ref.listen<AsyncValue<User?>>(authProvider, (prev, next) {
    next.whenOrNull(
      error: (e, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('登录失败: $e')),
        );
      },
    );
    if (next.value != null && prev?.value == null) {
      // 登录成功 → 跳首页
      context.go('/home');
    }
  });

  return ...;
}
```

### 21.4 select：精确依赖（性能优化）

```dart
// 整个 user 对象任何字段变都会 rebuild → 浪费
final user = ref.watch(currentUserProvider);

// 只关心 nickname
final nickname = ref.watch(currentUserProvider.select((u) => u.value?.nickname));
```

---

## 22. AsyncValue 与异步状态

`AsyncValue<T>` 是 `sealed` 类型（loading / data / error）。

### 22.1 三种构造

```dart
const AsyncLoading<int>();
const AsyncData(42);
AsyncError<int>(Exception('网络错'), StackTrace.current);
```

### 22.2 模式匹配（Dart 3）

```dart
String render(AsyncValue<List<Todo>> v) => switch (v) {
  AsyncData(:final value) => '${value.length} 条',
  AsyncLoading() => '加载中...',
  AsyncError(:final error) => '出错: $error',
  _ => '',
};
```

### 22.3 .when 风格

```dart
v.when(
  data: (todos) => Text('${todos.length} 条'),
  loading: () => const CircularProgressIndicator(),
  error: (e, st) => Text('出错: $e'),
)
```

`.when` 的变体：
- `.maybeWhen({required orElse})` —— 默认分支
- `.whenOrNull` —— 没匹配返回 null
- `.whenData((data) => ...)` —— 只关心 data 时

### 22.4 AsyncValue.guard：把异常自动包成 AsyncError

```dart
state = await AsyncValue.guard(() async {
  final res = await api.fetchTodos();
  return res;
});
// 不需要 try / catch，异常自动进入 AsyncError
```

---

## 23. autoDispose / family / scope

### 23.1 autoDispose：无人监听时自动销毁

```dart
@riverpod
Future<Article> article(Ref ref, String id) async {
  // 函数式 provider 默认是 autoDispose（generator 风格）
  return ref.watch(apiClientProvider).fetchArticle(id);
}
```

页面退出后无人 watch，**provider 自动销毁，缓存释放**。再进入会重新 build。

想保留缓存？用 `keepAlive`：

```dart
@Riverpod(keepAlive: true)
Future<List<Category>> categories(Ref ref) async {
  return ref.watch(apiClientProvider).fetchCategories();
}
```

### 23.2 family：参数化 provider

代码生成模式下，函数加参数即可：

```dart
@riverpod
Future<Article> article(Ref ref, String id) async {
  return ref.watch(apiClientProvider).fetchArticle(id);
}

// 使用
final a = ref.watch(articleProvider('a-001'));
```

不同 id 是不同的 provider 实例，各自独立。

### 23.3 scope：局部覆盖

```dart
ProviderScope(
  overrides: [
    articleProvider('a-001').overrideWith((ref) => Future.value(mockArticle)),
  ],
  child: const MyApp(),
)
```

测试时用得最多（第 56 节展开）。

---

## 24. Riverpod 实战：Todo App

完整的 Todo 实战：模型 + Repository + Notifier + UI。

```dart
// 1. 模型
@immutable
class Todo {
  final String id;
  final String title;
  final bool done;
  const Todo({required this.id, required this.title, this.done = false});

  Todo copyWith({String? title, bool? done}) =>
      Todo(id: id, title: title ?? this.title, done: done ?? this.done);
}

// 2. Repository（这里用内存模拟，真实场景接 Hive / API）
class TodoRepo {
  final _store = <Todo>[];
  Future<List<Todo>> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_store);
  }

  Future<Todo> create(String title) async {
    final t = Todo(id: DateTime.now().microsecondsSinceEpoch.toString(), title: title);
    _store.add(t);
    return t;
  }

  Future<void> toggle(String id) async {
    final i = _store.indexWhere((e) => e.id == id);
    if (i != -1) _store[i] = _store[i].copyWith(done: !_store[i].done);
  }

  Future<void> remove(String id) async {
    _store.removeWhere((e) => e.id == id);
  }
}

@Riverpod(keepAlive: true)
TodoRepo todoRepo(Ref ref) => TodoRepo();

// 3. 状态层
@riverpod
class TodosController extends _$TodosController {
  @override
  Future<List<Todo>> build() async {
    return ref.watch(todoRepoProvider).fetchAll();
  }

  Future<void> add(String title) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(todoRepoProvider).create(title);
      return ref.read(todoRepoProvider).fetchAll();
    });
  }

  Future<void> toggle(String id) async {
    // 乐观更新：先改 state，失败回滚
    final prev = state.value ?? [];
    state = AsyncData([
      for (final t in prev)
        if (t.id == id) t.copyWith(done: !t.done) else t,
    ]);
    try {
      await ref.read(todoRepoProvider).toggle(id);
    } catch (e, st) {
      state = AsyncData(prev);  // 回滚
      state = AsyncError(e, st);
    }
  }

  Future<void> remove(String id) async {
    final prev = state.value ?? [];
    state = AsyncData(prev.where((t) => t.id != id).toList());
    await ref.read(todoRepoProvider).remove(id);
  }
}

// 4. 派生状态
@riverpod
int undoneCount(Ref ref) {
  return ref.watch(todosControllerProvider).maybeWhen(
        data: (list) => list.where((t) => !t.done).length,
        orElse: () => 0,
      );
}

// 5. UI
class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(todosControllerProvider);
    final undone = ref.watch(undoneCountProvider);

    return Scaffold(
      appBar: AppBar(title: Text('待办（剩 $undone）')),
      body: asyncTodos.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('错误: $e')),
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (_, i) {
            final t = todos[i];
            return Dismissible(
              key: ValueKey(t.id),
              onDismissed: (_) => ref.read(todosControllerProvider.notifier).remove(t.id),
              child: CheckboxListTile(
                value: t.done,
                title: Text(t.title, style: t.done ? const TextStyle(decoration: TextDecoration.lineThrough) : null),
                onChanged: (_) => ref.read(todosControllerProvider.notifier).toggle(t.id),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await showDialog<String>(context: context, builder: (_) => const _AddTodoDialog());
          if (title != null && title.trim().isNotEmpty) {
            await ref.read(todosControllerProvider.notifier).add(title.trim());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AddTodoDialog extends StatefulWidget {
  const _AddTodoDialog();
  @override
  State<_AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<_AddTodoDialog> {
  final _ctl = TextEditingController();
  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新建待办'),
      content: TextField(controller: _ctl, autofocus: true),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
        FilledButton(onPressed: () => Navigator.pop(context, _ctl.text), child: const Text('添加')),
      ],
    );
  }
}
```

---

## 25. Riverpod 最佳实践与陷阱

### 25.1 ★ 铁律

1. `build` 里只用 `watch`，回调里只用 `read`，副作用用 `listen`。
2. 业务方法写在 `Notifier` 里，不要散在 widget 里。
3. UI 永远先看 `AsyncValue.when`，不要 `state.value!` 强解。
4. 不要把 `BuildContext` 传到 Notifier 里——用 `ref.listen` 在 widget 层处理 UI 副作用。

### 25.2 常见陷阱

**陷阱 1：在 build 之外 watch**

```dart
// ❌
class Bad extends ConsumerStatefulWidget {...}
class _BadState extends ConsumerState<Bad> {
  @override
  void initState() {
    super.initState();
    final user = ref.watch(userProvider);  // ❌ 报错
  }
}

// ✅
@override
void initState() {
  super.initState();
  ref.listenManual(userProvider, (p, n) { ... });  // 用 listenManual
}
```

**陷阱 2：在 Notifier 里直接 ref.watch 触发循环**

```dart
@riverpod
class Bad extends _$Bad {
  @override
  int build() {
    ref.watch(otherProvider);  // ✅ 没问题，依赖发生变化时 build 会重跑
    return 0;
  }

  void doSomething() {
    final v = ref.watch(otherProvider);  // ❌ 在方法里用 watch，没意义
  }
}
```

**陷阱 3：autoDispose 误销毁缓存**

页面 push 进入二级页又返回时，一级页的 provider 可能因 autoDispose 销毁。需要保留时：
- 加 `keepAlive: true`
- 或在祖先用 `ref.keepAlive()` 保留

---

# Part 5 · 路由（go_router）

## 26. 为什么 Navigator 不够用

| 痛点 | Navigator 1.0 | go_router |
| --- | --- | --- |
| 深链接 | 几乎不支持 | 一行搞定 |
| Web URL 同步 | 不支持 | 自动 |
| 路由守卫 | 自己写一堆 | 内建 redirect |
| 类型安全参数 | 强转 dynamic | go_router_builder 编译期检查 |
| 嵌套 Tab + 各自栈 | 几乎不能 | StatefulShellRoute 原生支持 |

## 27. go_router 入门

```bash
flutter pub add go_router
```

### 27.1 最小例子

```dart
final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: '/article/:id',     // 路径参数
      builder: (ctx, state) {
        final id = state.pathParameters['id']!;
        return ArticlePage(id: id);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'demo',
    );
  }
}
```

### 27.2 跳转 API

```dart
context.go('/login');                          // 替换栈
context.push('/article/123');                  // 入栈
context.pushReplacement('/home');              // 替换当前
context.pop();                                 // 返回
context.pop(true);                             // 返回带值
context.go('/article/123?from=home');          // 查询参数
state.uri.queryParameters['from'];             // 读取
```

### 27.3 命名路由（推荐）

```dart
GoRoute(
  name: 'article',
  path: '/article/:id',
  builder: (ctx, state) => ArticlePage(id: state.pathParameters['id']!),
),

context.goNamed('article', pathParameters: {'id': '123'});
```

---

## 28. 嵌套路由 / Shell / Tab

底部 Tab + 每个 Tab 各自的导航栈，是 App 最常见的形态。go_router 用 `StatefulShellRoute.indexedStack` 一招制胜。

```dart
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorMineKey = GlobalKey<NavigatorState>(debugLabel: 'mine');

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (ctx, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (_, __) => const HomePage(),
              routes: [
                GoRoute(
                  path: 'detail/:id',
                  builder: (ctx, st) => DetailPage(id: st.pathParameters['id']!),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorMineKey,
          routes: [
            GoRoute(path: '/mine', builder: (_, __) => const MinePage()),
          ],
        ),
      ],
    ),
  ],
);

class MainScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const MainScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (i) => navigationShell.goBranch(
          i,
          // 同 tab 再次点击时回到根
          initialLocation: i == navigationShell.currentIndex,
        ),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: '首页'),
          NavigationDestination(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
```

---

## 29. 路由守卫与重定向

### 29.1 全局守卫

```dart
final _router = GoRouter(
  routes: [...],
  redirect: (ctx, state) {
    final container = ProviderScope.containerOf(ctx);
    final loggedIn = container.read(authProvider).valueOrNull != null;
    final goingToLogin = state.matchedLocation == '/login';

    if (!loggedIn && !goingToLogin) return '/login';
    if (loggedIn && goingToLogin) return '/home';
    return null; // 不重定向
  },
);
```

### 29.2 单条路由守卫

```dart
GoRoute(
  path: '/admin',
  redirect: (ctx, st) {
    final container = ProviderScope.containerOf(ctx);
    final isAdmin = container.read(currentUserProvider).valueOrNull?.isAdmin ?? false;
    return isAdmin ? null : '/forbidden';
  },
  builder: (_, __) => const AdminPage(),
),
```

### 29.3 与 Riverpod 联动：refreshListenable

登录态变化时让 router 重新 evaluate redirect：

```dart
final routerProvider = Provider<GoRouter>((ref) {
  final notifier = GoRouterRefreshStream(ref.watch(authStreamProvider.stream));
  ref.onDispose(notifier.dispose);

  return GoRouter(
    refreshListenable: notifier,
    routes: [...],
    redirect: (ctx, state) {...},
  );
});

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _sub;
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _sub = stream.listen((_) => notifyListeners());
  }
  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
```

---

## 30. 深链接（Deep Link）

go_router 自动把 URL 映射到路由。让外部 App / 浏览器能打开你的页面：

### 30.1 Android

`android/app/src/main/AndroidManifest.xml` 在 MainActivity 内：

```xml
<intent-filter android:autoVerify="true">
  <action android:name="android.intent.action.VIEW" />
  <category android:name="android.intent.category.DEFAULT" />
  <category android:name="android.intent.category.BROWSABLE" />
  <data android:scheme="https" android:host="myapp.com" />
</intent-filter>
```

### 30.2 iOS

`ios/Runner/Info.plist`：

```xml
<key>FlutterDeepLinkingEnabled</key>
<true/>
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array><string>myapp</string></array>
  </dict>
</array>
```

测试：
```bash
adb shell am start -W -a android.intent.action.VIEW -d "https://myapp.com/article/123"
xcrun simctl openurl booted "myapp://article/123"
```

---

## 31. 类型安全路由：go_router_builder

```bash
flutter pub add go_router_builder
flutter pub add --dev build_runner
```

```dart
import 'package:go_router/go_router.dart';
import 'package:go_router_builder/go_router_builder.dart';

part 'routes.g.dart';

@TypedGoRoute<ArticleRoute>(path: '/article/:id')
class ArticleRoute extends GoRouteData {
  final String id;
  final String? from;
  const ArticleRoute({required this.id, this.from});

  @override
  Widget build(BuildContext ctx, GoRouterState state) =>
      ArticlePage(id: id, from: from);
}

// 用法（编译期检查）
const ArticleRoute(id: '123', from: 'home').go(context);
const ArticleRoute(id: 'abc').push(context);
```

不再有 `state.pathParameters['id']!` 的强转，参数错了编译报错。

---

# Part 6 · 网络层（Dio）

## 32. Dio 入门

```bash
flutter pub add dio
```

```dart
final dio = Dio(BaseOptions(
  baseUrl: 'https://api.example.com',
  connectTimeout: const Duration(seconds: 10),
  receiveTimeout: const Duration(seconds: 15),
  headers: {'Accept': 'application/json'},
));

// GET
final res = await dio.get('/posts', queryParameters: {'page': 1});
final list = (res.data as List).cast<Map<String, dynamic>>();

// POST
final res2 = await dio.post('/posts', data: {'title': 'hello', 'body': '...'});

// 上传文件
final form = FormData.fromMap({
  'file': await MultipartFile.fromFile('/path/to/img.jpg', filename: 'img.jpg'),
  'name': '头像',
});
await dio.post('/upload', data: form);

// 下载文件 + 进度
await dio.download(
  'https://example.com/big.zip',
  '/path/to/save.zip',
  onReceiveProgress: (rec, total) {
    if (total != -1) print('${(rec / total * 100).toStringAsFixed(0)}%');
  },
);

// 取消
final token = CancelToken();
dio.get('/slow', cancelToken: token);
token.cancel('用户取消');
```

---

## 33. 拦截器：日志 / Token / 错误

### 33.1 日志拦截器（开发期）

```dart
dio.interceptors.add(LogInterceptor(
  requestBody: true,
  responseBody: true,
));

// 更花哨的：
// flutter pub add pretty_dio_logger
// dio.interceptors.add(PrettyDioLogger(...));
```

### 33.2 Token 注入

```dart
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) async {
    final token = await secureStorage.read(key: 'token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  },
));
```

### 33.3 统一错误转换

```dart
sealed class AppError implements Exception {
  final String message;
  const AppError(this.message);
}

class NetworkError extends AppError {
  const NetworkError(super.message);
}

class UnauthorizedError extends AppError {
  const UnauthorizedError() : super('未登录或登录已过期');
}

class ServerError extends AppError {
  final int statusCode;
  const ServerError(this.statusCode, String msg) : super(msg);
}

dio.interceptors.add(InterceptorsWrapper(
  onError: (err, handler) {
    final mapped = _mapDioError(err);
    handler.reject(DioException(
      requestOptions: err.requestOptions,
      error: mapped,            // ★ 把统一的 AppError 塞回去
      message: mapped.message,
    ));
  },
));

AppError _mapDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkError('网络超时');
    case DioExceptionType.connectionError:
      return const NetworkError('网络不可用');
    case DioExceptionType.badResponse:
      final code = e.response?.statusCode ?? 0;
      if (code == 401) return const UnauthorizedError();
      return ServerError(code, e.response?.data?['message']?.toString() ?? '服务异常');
    case DioExceptionType.cancel:
      return const NetworkError('请求被取消');
    default:
      return NetworkError(e.message ?? '未知错误');
  }
}
```

---

## 34. Token 自动刷新（队列 + 锁）

实战级：401 时用 refreshToken 刷新，期间所有并发请求排队等待。

```dart
class AuthInterceptor extends Interceptor {
  final Dio _dio;
  final Future<String?> Function() _refresh;
  bool _isRefreshing = false;
  final List<_Pending> _queue = [];

  AuthInterceptor(this._dio, this._refresh);

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) return handler.next(err);

    // 已经在刷新，把当前请求挂起
    if (_isRefreshing) {
      _queue.add(_Pending(err.requestOptions, handler));
      return;
    }

    _isRefreshing = true;
    try {
      final newToken = await _refresh();
      if (newToken == null) {
        // 刷新失败：抛 401 出去，让上层去登录页
        return handler.next(err);
      }
      // 重发原请求
      final retried = await _retry(err.requestOptions, newToken);
      handler.resolve(retried);
      // 重发队列里的请求
      for (final p in _queue) {
        try {
          final r = await _retry(p.options, newToken);
          p.handler.resolve(r);
        } catch (e) {
          p.handler.reject(e is DioException ? e : DioException(requestOptions: p.options));
        }
      }
    } catch (e) {
      handler.next(err);
    } finally {
      _queue.clear();
      _isRefreshing = false;
    }
  }

  Future<Response> _retry(RequestOptions opt, String newToken) {
    final clone = opt.copyWith(
      headers: {...opt.headers, 'Authorization': 'Bearer $newToken'},
    );
    return _dio.fetch(clone);
  }
}

class _Pending {
  final RequestOptions options;
  final ErrorInterceptorHandler handler;
  _Pending(this.options, this.handler);
}
```

---

## 35. RestClient 封装与 Repository 集成

```dart
// 1. RestClient：薄封装，统一返回类型
class RestClient {
  final Dio _dio;
  RestClient(this._dio);

  Future<T> get<T>(String path, {Map<String, dynamic>? query, T Function(Object?)? decoder}) async {
    final res = await _dio.get(path, queryParameters: query);
    return decoder != null ? decoder(res.data) : res.data as T;
  }

  Future<T> post<T>(String path, {Object? body, T Function(Object?)? decoder}) async {
    final res = await _dio.post(path, data: body);
    return decoder != null ? decoder(res.data) : res.data as T;
  }
}

// 2. 实体
class Article {
  final String id;
  final String title;
  final String content;
  Article({required this.id, required this.title, required this.content});

  factory Article.fromJson(Map<String, dynamic> j) =>
      Article(id: j['id'] as String, title: j['title'] as String, content: j['content'] as String);
}

// 3. Repository（数据层抽象）
abstract interface class ArticleRepository {
  Future<List<Article>> list({int page = 1});
  Future<Article> detail(String id);
}

class ArticleRepositoryImpl implements ArticleRepository {
  final RestClient _client;
  ArticleRepositoryImpl(this._client);

  @override
  Future<List<Article>> list({int page = 1}) async {
    return _client.get<List<Article>>(
      '/articles',
      query: {'page': page},
      decoder: (raw) =>
          (raw as List).map((e) => Article.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }

  @override
  Future<Article> detail(String id) {
    return _client.get<Article>(
      '/articles/$id',
      decoder: (raw) => Article.fromJson(raw as Map<String, dynamic>),
    );
  }
}

// 4. Riverpod 装配
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
  dio.interceptors.addAll([
    AuthInterceptor(dio, () => ref.read(authControllerProvider.notifier).refresh()),
    LogInterceptor(),
  ]);
  return dio;
}

@Riverpod(keepAlive: true)
RestClient restClient(Ref ref) => RestClient(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
ArticleRepository articleRepo(Ref ref) => ArticleRepositoryImpl(ref.watch(restClientProvider));
```

---

## 36. Mock 与离线开发

### 36.1 拦截器层 Mock

```dart
class MockInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == '/articles') {
      return handler.resolve(Response(
        requestOptions: options,
        statusCode: 200,
        data: List.generate(20, (i) => {'id': '$i', 'title': '文章$i', 'content': '...'}),
      ));
    }
    handler.next(options);
  }
}

// 仅在 dev 环境注入
if (kDebugMode) dio.interceptors.add(MockInterceptor());
```

### 36.2 用 Mockito / Mocktail 替换 Repository

测试时直接 override Riverpod provider，详见第 56 节。

### 36.3 推荐工具

- `mockito` —— 大而全，需要 build_runner
- `mocktail` —— 类型安全、零代码生成（**推荐**）
- `dio_smart_retry` —— 自动重试

---

# Part 7 · 本地存储

## 37. 存储方案选型决策树

```
要存什么？
│
├─ 几个 KV（设置、token、上次登录用户名）
│   → shared_preferences
│
├─ 敏感信息（token、refreshToken、密钥）
│   → flutter_secure_storage（iOS Keychain / Android Keystore）
│
├─ 大量结构化对象，无需复杂查询
│   → Hive（成熟） 或 ObjectBox（高性能）
│
├─ 高并发、复杂查询、跨表关联
│   ├─ NoSQL 风格：Isar
│   └─ SQL 风格、迁移成熟：Drift（基于 SQLite）
│
└─ 二进制大文件（图片缓存、下载文件）
    → path_provider 拿目录 + dart:io File
```

---

## 38. shared_preferences（KV）

```bash
flutter pub add shared_preferences
```

```dart
final sp = await SharedPreferences.getInstance();
await sp.setString('name', '小新');
await sp.setInt('age', 5);
await sp.setBool('dark', true);

final name = sp.getString('name');
await sp.remove('name');
```

封装：

```dart
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPrefs(Ref ref) => SharedPreferences.getInstance();

@riverpod
class ThemeMode_ extends _$ThemeMode_ {
  @override
  Future<ThemeMode> build() async {
    final sp = await ref.watch(sharedPrefsProvider.future);
    return _parse(sp.getString('theme'));
  }

  Future<void> set(ThemeMode m) async {
    final sp = await ref.read(sharedPrefsProvider.future);
    await sp.setString('theme', m.name);
    state = AsyncData(m);
  }

  ThemeMode _parse(String? s) => switch (s) {
    'dark' => ThemeMode.dark,
    'light' => ThemeMode.light,
    _ => ThemeMode.system,
  };
}
```

---

## 39. Hive（NoSQL）

```bash
flutter pub add hive hive_flutter
flutter pub add --dev hive_generator build_runner
```

```dart
@HiveType(typeId: 0)
class Article {
  @HiveField(0) final String id;
  @HiveField(1) final String title;
  @HiveField(2) final DateTime savedAt;
  Article({required this.id, required this.title, required this.savedAt});
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArticleAdapter());
  await Hive.openBox<Article>('articles');
  runApp(const MyApp());
}

// 使用
final box = Hive.box<Article>('articles');
await box.put('a-001', Article(id: 'a-001', title: '...', savedAt: DateTime.now()));
final a = box.get('a-001');
final all = box.values.toList();
await box.delete('a-001');

// 监听变化（自动 UI 刷新）
ValueListenableBuilder(
  valueListenable: box.listenable(),
  builder: (ctx, Box<Article> b, _) => ListView(
    children: b.values.map((e) => Text(e.title)).toList(),
  ),
)
```

---

## 40. Isar（高性能）

> Isar 是当前 Flutter 最快的本地 NoSQL，支持索引、全文搜索、跨平台二进制。

```bash
flutter pub add isar isar_flutter_libs
flutter pub add --dev isar_generator build_runner
```

```dart
@collection
class Note {
  Id id = Isar.autoIncrement;

  @Index(type: IndexType.value, caseSensitive: false)
  late String title;

  late String content;

  @Index()
  late DateTime updatedAt;
}

// 初始化
final dir = await getApplicationDocumentsDirectory();
final isar = await Isar.open([NoteSchema], directory: dir.path);

// 写
await isar.writeTxn(() async {
  await isar.notes.put(Note()..title = '标题'..content = '内容'..updatedAt = DateTime.now());
});

// 查
final results = await isar.notes
    .filter()
    .titleContains('Flutter', caseSensitive: false)
    .sortByUpdatedAtDesc()
    .limit(20)
    .findAll();
```

---

## 41. Drift（SQL）

> Drift 基于 SQLite，提供完整 SQL 表达能力 + 类型安全的 Dart API + 编译期校验。

```bash
flutter pub add drift drift_flutter sqlite3_flutter_libs
flutter pub add --dev drift_dev build_runner
```

```dart
class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 200)();
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get favorited => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Articles])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  @override
  int get schemaVersion => 1;

  Future<List<Article>> allArticles() => select(articles).get();
  Stream<List<Article>> watchFavorites() =>
      (select(articles)..where((t) => t.favorited)).watch();
  Future<int> addArticle(ArticlesCompanion entry) => into(articles).insert(entry);
}
```

---

## 42. flutter_secure_storage（安全存储）

```bash
flutter pub add flutter_secure_storage
```

```dart
final storage = const FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),
);

await storage.write(key: 'token', value: 'eyJ...');
final token = await storage.read(key: 'token');
await storage.delete(key: 'token');
```

> ⚠️ 不要在 secure_storage 里存大量数据，性能差。它是给"敏感小数据"准备的。

---

# Part 8 · 主题与暗黑模式

## 43. ThemeData / ColorScheme / Material 3

### 43.1 一份完整的主题定义

```dart
ThemeData buildLightTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface,

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,
      foregroundColor: colorScheme.onSurface,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 1,
    ),

    // 文字
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, height: 1.5),
      labelMedium: TextStyle(fontSize: 12),
    ),

    // 按钮
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),

    // 输入框
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
    ),

    // 卡片
    cardTheme: CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: colorScheme.surfaceContainer,
    ),
  );
}
```

---

## 44. 暗黑模式：跟随系统 + 手动切换

```dart
class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;
    return MaterialApp.router(
      themeMode: mode,
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      routerConfig: ref.watch(routerProvider),
    );
  }
}

ThemeData buildDarkTheme() {
  final cs = ColorScheme.fromSeed(
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.dark,
  );
  return ThemeData(useMaterial3: true, colorScheme: cs, brightness: Brightness.dark);
}
```

切换 UI：

```dart
SegmentedButton<ThemeMode>(
  segments: const [
    ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.brightness_auto)),
    ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode)),
    ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode)),
  ],
  selected: {mode},
  onSelectionChanged: (s) => ref.read(themeModeProvider.notifier).set(s.first),
)
```

---

## 45. ThemeExtension：自定义主题字段

ThemeData 没有的字段（业务自定义颜色、间距），用 ThemeExtension：

```dart
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  final Color success;
  final Color warning;
  final Color price;

  const AppPalette({required this.success, required this.warning, required this.price});

  @override
  AppPalette copyWith({Color? success, Color? warning, Color? price}) =>
      AppPalette(success: success ?? this.success, warning: warning ?? this.warning, price: price ?? this.price);

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      price: Color.lerp(price, other.price, t)!,
    );
  }

  static const light = AppPalette(success: Color(0xFF2E7D32), warning: Color(0xFFEF6C00), price: Color(0xFFD32F2F));
  static const dark = AppPalette(success: Color(0xFF66BB6A), warning: Color(0xFFFFA726), price: Color(0xFFEF5350));
}

// 注册
ThemeData buildLightTheme() => ThemeData(
  // ...
  extensions: const [AppPalette.light],
);

// 用
extension AppPaletteX on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
}

// 业务里
Text('¥99', style: TextStyle(color: context.palette.price))
```

---

## 46. 字体与图标资源

### 46.1 自定义字体

`pubspec.yaml`：

```yaml
flutter:
  fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-Regular.ttf
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
```

主题里：

```dart
ThemeData(fontFamily: 'Inter', ...)
```

### 46.2 自定义图标字体

用 [fluttericon.com](https://fluttericon.com) 或 IconFont 生成 ttf + json，然后：

```dart
class MyIcons {
  static const home = IconData(0xe900, fontFamily: 'MyIcons');
  static const cart = IconData(0xe901, fontFamily: 'MyIcons');
}

Icon(MyIcons.home)
```

### 46.3 SVG

```bash
flutter pub add flutter_svg
```

```dart
SvgPicture.asset('assets/icons/logo.svg', width: 40)
SvgPicture.network('https://...')
```

---

# Part 9 · 国际化

## 47. flutter_localizations + intl 标准方案

```bash
flutter pub add flutter_localizations --sdk=flutter
flutter pub add intl
```

`pubspec.yaml`：

```yaml
flutter:
  generate: true
```

新建 `l10n.yaml`：

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

---

## 48. ARB 文件与 gen-l10n

`lib/l10n/app_en.arb`：

```json
{
  "@@locale": "en",
  "appTitle": "Flutter Demo",
  "hello": "Hello, {name}!",
  "@hello": {
    "placeholders": {
      "name": {"type": "String"}
    }
  },
  "items": "{count, plural, =0{No items} =1{1 item} other{{count} items}}"
}
```

`lib/l10n/app_zh.arb`：

```json
{
  "@@locale": "zh",
  "appTitle": "Flutter 示例",
  "hello": "你好，{name}！",
  "items": "{count, plural, =0{无} =1{1 条} other{{count} 条}}"
}
```

```bash
flutter gen-l10n
```

接入：

```dart
MaterialApp(
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  locale: ref.watch(localeProvider),
  ...
)

// 用
final t = AppLocalizations.of(context)!;
Text(t.hello('小新'))
```

---

## 49. 动态切换语言

```dart
@riverpod
class Locale_ extends _$Locale_ {
  @override
  Future<Locale?> build() async {
    final sp = await ref.watch(sharedPrefsProvider.future);
    final code = sp.getString('locale');
    return code == null ? null : Locale(code);
  }

  Future<void> set(Locale? l) async {
    final sp = await ref.read(sharedPrefsProvider.future);
    if (l == null) {
      await sp.remove('locale');
    } else {
      await sp.setString('locale', l.languageCode);
    }
    state = AsyncData(l);
  }
}
```

---

## 50. 复数 / 占位符 / 日期格式

```dart
import 'package:intl/intl.dart';

DateFormat.yMMMd('zh').format(DateTime.now());     // 2026年4月27日
NumberFormat.currency(locale: 'zh', symbol: '¥').format(1234.5);  // ¥1,234.50
NumberFormat.compact(locale: 'zh').format(12345);  // 1.2万
```

---

# Part 10 · 测试金字塔

## 51. 测试分层与策略

```
       /\
      /UI\               少：integration_test（端到端）
     /----\
    /Widget\             中：widget test（页面/组件）
   /--------\
  /   Unit   \           多：单元测试（业务逻辑、工具）
 /____________\
```

经验比例：单元 70% / Widget 25% / 集成 5%。

---

## 52. 单元测试与 mocktail

```bash
flutter pub add --dev mocktail
```

```dart
// test/article_repo_test.dart
class _MockClient extends Mock implements RestClient {}

void main() {
  late _MockClient client;
  late ArticleRepository repo;

  setUp(() {
    client = _MockClient();
    repo = ArticleRepositoryImpl(client);
  });

  test('list returns parsed articles', () async {
    when(() => client.get<List<Article>>(any(), query: any(named: 'query'), decoder: any(named: 'decoder')))
        .thenAnswer((_) async => [Article(id: '1', title: 'A', content: '')]);

    final r = await repo.list(page: 1);
    expect(r, hasLength(1));
    expect(r.first.id, '1');
  });

  test('throws when client throws', () async {
    when(() => client.get(any())).thenThrow(const NetworkError('timeout'));
    expect(() => repo.list(), throwsA(isA<NetworkError>()));
  });
}
```

跑测试：

```bash
flutter test
flutter test --coverage      # 生成 coverage/lcov.info
```

---

## 53. Widget 测试

```dart
testWidgets('counter increments', (tester) async {
  await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: CounterPage())));

  expect(find.text('0'), findsOneWidget);

  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();

  expect(find.text('1'), findsOneWidget);
});

testWidgets('shows error snackbar on save failure', (tester) async {
  await tester.pumpWidget(...);
  await tester.tap(find.text('保存'));
  await tester.pump(const Duration(seconds: 1));   // 等异步完成
  expect(find.text('保存失败'), findsOneWidget);
});
```

常用 Finder：
- `find.text('xxx')` / `find.byIcon(Icons.x)` / `find.byKey(ValueKey('id'))`
- `find.byType(MyWidget)` / `find.byTooltip('提示')`
- `find.descendant(of: ..., matching: ...)`

常用 Action：
- `await tester.tap(...)` / `await tester.enterText(finder, '内容')`
- `await tester.drag(finder, const Offset(0, -300))`
- `await tester.pump()`：触发一帧
- `await tester.pumpAndSettle()`：等所有动画完成

---

## 54. 集成测试 integration_test

```bash
flutter pub add --dev integration_test --sdk=flutter
```

`integration_test/app_test.dart`：

```dart
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login → home → logout', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // 登录
    await tester.enterText(find.byKey(const Key('email')), 'a@b.com');
    await tester.enterText(find.byKey(const Key('pwd')), '123456');
    await tester.tap(find.text('登录'));
    await tester.pumpAndSettle();

    expect(find.text('首页'), findsOneWidget);
    // ...
  });
}
```

跑：

```bash
flutter test integration_test/app_test.dart
```

---

## 55. Golden Test（视觉回归）

```dart
testWidgets('Card matches golden', (tester) async {
  await tester.pumpWidget(MaterialApp(home: Center(child: MyCard(title: 'A'))));
  await expectLater(find.byType(MyCard), matchesGoldenFile('goldens/my_card.png'));
});
```

第一次：

```bash
flutter test --update-goldens
```

之后改动若像素级不同会失败，CI 上锁住 UI。

> ⚠️ Golden Test **跨平台像素差异**敏感，CI 与本地建议都跑 Linux Docker 镜像。

---

## 56. 测试 Riverpod

核心：用 `ProviderContainer` 直接测，或 `ProviderScope.overrides` 替换依赖。

```dart
test('counter notifier increments', () {
  final container = ProviderContainer();
  addTearDown(container.dispose);

  expect(container.read(counterControllerProvider), 0);
  container.read(counterControllerProvider.notifier).increment();
  expect(container.read(counterControllerProvider), 1);
});

testWidgets('home shows mocked todos', (tester) async {
  final fakeRepo = _FakeRepo();
  await tester.pumpWidget(ProviderScope(
    overrides: [
      todoRepoProvider.overrideWithValue(fakeRepo),
    ],
    child: const MaterialApp(home: TodosPage()),
  ));
  await tester.pumpAndSettle();
  expect(find.text('mock todo 1'), findsOneWidget);
});
```

---

## 57. 覆盖率与 CI 集成

```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

CI 推荐：上传到 Codecov / Coveralls。GitHub Actions 见 Part 13。

---

# Part 11 · DevTools 与性能优化

## 58. DevTools 总览

启动方式：
```bash
flutter run                      # 控制台会输出 DevTools URL
# 或在 VS Code: 命令面板 → "Open DevTools"
```

主要 Tab：
- **Inspector**：Widget 树 / Layout 调试
- **Performance**：帧率 / GPU / CPU
- **CPU Profiler**：函数采样
- **Memory**：堆 / GC / 泄漏
- **Network**：HTTP 请求
- **Logging**：print / debugPrint / log
- **App Size**：发布包体积分析

---

## 59. 重建定位（Rebuild Indicator）

DevTools → Performance → 启用 "Track Widget Builds"，每次 build 会高亮闪烁。
找到不该重建的组件，常见原因：

1. 父级用了 `setState`，连带整个子树。 → 用 `const`、抽子 widget。
2. 在 `build` 里用 `MediaQuery.of(context)`，整个屏幕尺寸变化都会触发。 → 改 `MediaQuery.sizeOf(context)`（Flutter 3.10+），只关心尺寸。
3. Riverpod 没用 `select`：`ref.watch(userProvider)` → `ref.watch(userProvider.select((u) => u.name))`。

---

## 60. 内存与对象泄漏

DevTools → Memory → "Check for Leaks"。

常见泄漏：
- 忘记 dispose `AnimationController` / `TextEditingController` / `StreamSubscription` / `Timer`。
- `GlobalKey` 跨树引用。
- 闭包持有 BuildContext 长期不释放。

排查：
```dart
import 'package:leak_tracker_flutter_testing/leak_tracker_flutter_testing.dart';
// flutter test 时打开
```

---

## 61. Frame / 60fps / Jank 分析

目标：每帧 16.6ms 内（60fps）或 8.3ms（120fps）。
DevTools → Performance → Timeline。

红色帧 = 超过预算。点开看是 UI thread（你的 Dart 代码）还是 Raster thread（GPU 绘制）。

常见 Jank：
- 大列表无 `itemExtent` → 加上能避免布局测量。
- 一帧内做大量计算 → 拆 isolate（第 63 节）。
- 大图未压缩 → `cacheWidth` / `cacheHeight`。
- 重叠 widget 过多 → `RepaintBoundary` 隔离重绘。

---

## 62. Skia / Impeller 渲染管线简介

历史：
- Flutter 1.x ~ 3.7：默认 Skia（基于 OpenGL / Metal）。
- Flutter 3.10+ iOS：默认 Impeller（自研，预编译 shader，避免首次渲染卡顿）。
- Flutter 3.27+ Android：Impeller 也成默认（Vulkan）。

实务影响：
- 不需要你做什么，但要知道**首屏 shader 编译卡顿在新版 Impeller 已解决**。
- 老项目可在 `info.plist` / `AndroidManifest.xml` 强制切回 Skia 排查问题。

---

## 63. Isolate 处理 CPU 密集任务

Dart 是单线程事件循环。**网络 / IO 都不是问题**（异步），但 **CPU 密集**（解析大 JSON、加密、图像处理）会卡 UI 线程。

```dart
import 'dart:isolate';

// Flutter 3.7+ 推荐：compute / Isolate.run
final result = await Isolate.run(() {
  // 这里在另一个 isolate 执行，不阻塞 UI
  return _heavyParse(rawJsonString);
});

// 简化版（旧 API，兼容）
final r = await compute(_heavyParse, rawJsonString);
```

> ⚠️ Isolate 之间不共享内存，只能传 message。复杂对象会被序列化（必须可 SendPort 序列化）。

---

## 64. 图片优化与缓存

```dart
Image.network(
  url,
  cacheWidth: 200,           // 解码到 200 宽，省内存
  cacheHeight: 200,
)

// 生产用 cached_network_image
CachedNetworkImage(
  imageUrl: url,
  memCacheWidth: 200,
  fadeInDuration: const Duration(milliseconds: 200),
  placeholder: (_, __) => const SkeletonBox(),
  errorWidget: (_, __, ___) => const Icon(Icons.broken_image),
)
```

---

## 65. 列表性能：RepaintBoundary / itemExtent

```dart
ListView.builder(
  itemExtent: 80,           // 每项固定高 → 跳过测量，性能大幅提升
  itemCount: 1000,
  itemBuilder: (_, i) => RepaintBoundary(
    child: HeavyTile(item: items[i]),  // 把每行包成独立的 raster 层
  ),
)
```

---

# Part 12 · 原生集成

## 66. Method Channel 基础

Flutter 通过 channel 与原生通信。Method Channel 是请求-响应模式。

### 66.1 Flutter 端

```dart
class BatteryChannel {
  static const _ch = MethodChannel('com.example/battery');

  static Future<int> getLevel() async {
    final v = await _ch.invokeMethod<int>('getBatteryLevel');
    return v ?? -1;
  }
}
```

### 66.2 Android 端（Kotlin）

`MainActivity.kt`：

```kotlin
class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(engine: FlutterEngine) {
        super.configureFlutterEngine(engine)
        MethodChannel(engine.dartExecutor.binaryMessenger, "com.example/battery").setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryLevel" -> {
                    val bm = getSystemService(BATTERY_SERVICE) as BatteryManager
                    result.success(bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY))
                }
                else -> result.notImplemented()
            }
        }
    }
}
```

### 66.3 iOS 端（Swift）

`AppDelegate.swift`：

```swift
@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.example/battery", binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler { call, result in
      if call.method == "getBatteryLevel" {
        UIDevice.current.isBatteryMonitoringEnabled = true
        result(Int(UIDevice.current.batteryLevel * 100))
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

---

## 67. Pigeon：类型安全的桥

手写 Method Channel 错一个字符串就崩。Pigeon 用 IDL 自动生成两端代码。

```bash
flutter pub add --dev pigeon
```

`pigeons/messages.dart`：

```dart
import 'package:pigeon/pigeon.dart';

class BatteryInfo {
  int? level;
  bool? charging;
}

@HostApi()
abstract class BatteryApi {
  BatteryInfo getInfo();
}
```

```bash
flutter pub run pigeon \
  --input pigeons/messages.dart \
  --dart_out lib/src/messages.g.dart \
  --kotlin_out android/app/src/main/kotlin/com/example/.../Messages.g.kt \
  --kotlin_package com.example \
  --swift_out ios/Runner/Messages.g.swift
```

生成的 Dart 代码可直接调用：

```dart
final api = BatteryApi();
final info = await api.getInfo();
```

---

## 68. EventChannel：流式数据

适合传感器、推送、定位等持续事件。

```dart
const _ch = EventChannel('com.example/sensor');

Stream<double> orientationStream() =>
    _ch.receiveBroadcastStream().map((e) => (e as num).toDouble());
```

---

## 69. FFI：调用 C/C++ 库

```bash
flutter pub add ffi
```

```dart
import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef _NativeAdd = Int32 Function(Int32, Int32);
typedef _DartAdd = int Function(int, int);

class NativeMath {
  static final _lib = DynamicLibrary.open('libnative.so');
  static final add = _lib.lookupFunction<_NativeAdd, _DartAdd>('add');
}

void main() {
  print(NativeMath.add(3, 4));
}
```

> 适用：复用现有 C/C++ 库（音视频、加密、图像处理）。

---

## 70. 制作平台插件

```bash
flutter create --template=plugin --platforms=android,ios my_plugin
```

结构：
- `lib/my_plugin.dart` —— Dart API
- `android/` —— Kotlin/Java 实现
- `ios/` —— Swift/ObjC 实现
- `example/` —— 示例 App

发布到 pub.dev：

```bash
flutter pub publish --dry-run
flutter pub publish
```

---

# Part 13 · CI/CD 与发布

## 71. 多环境 Flavor 配置

需求：dev / staging / prod 三套环境，包名和 API 地址都不同。

### 71.1 用 --dart-define 注入

```bash
flutter run --dart-define=ENV=dev --dart-define=API_BASE=https://dev.api.com
flutter build apk --dart-define-from-file=env.prod.json
```

代码读取：

```dart
class AppEnv {
  static const env = String.fromEnvironment('ENV', defaultValue: 'dev');
  static const apiBase = String.fromEnvironment('API_BASE');
  static bool get isProd => env == 'prod';
}
```

### 71.2 Android Flavor

`android/app/build.gradle`：

```groovy
android {
    flavorDimensions "env"
    productFlavors {
        dev   { dimension "env"; applicationIdSuffix ".dev"; resValue "string", "app_name", "MyApp Dev" }
        prod  { dimension "env"; resValue "string", "app_name", "MyApp" }
    }
}
```

```bash
flutter build apk --flavor prod
```

### 71.3 iOS Scheme

Xcode → Product → Scheme → New Scheme，配 dev / prod，构建配置区分。

---

## 72. 自动签名（Android / iOS）

### 72.1 Android：keystore

`android/key.properties`（**不要进 git**）：

```
storePassword=...
keyPassword=...
keyAlias=upload
storeFile=../upload-keystore.jks
```

`android/app/build.gradle`：

```groovy
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release { signingConfig signingConfigs.release }
    }
}
```

### 72.2 iOS：fastlane match

```bash
gem install fastlane
cd ios && fastlane match init
fastlane match appstore
```

证书统一存到私有 git 仓库，团队共享。

---

## 73. GitHub Actions 流水线

`.github/workflows/ci.yml`：

```yaml
name: CI
on:
  push: { branches: [main] }
  pull_request:

jobs:
  analyze-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.27.0'
          channel: stable
      - run: flutter pub get
      - run: dart format --set-exit-if-changed .
      - run: flutter analyze
      - run: flutter test --coverage
      - uses: codecov/codecov-action@v4

  build-android:
    needs: analyze-and-test
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { flutter-version: '3.27.0' }
      - run: flutter build appbundle --release
      - uses: actions/upload-artifact@v4
        with:
          name: app-release
          path: build/app/outputs/bundle/release/app-release.aab

  build-ios:
    needs: analyze-and-test
    runs-on: macos-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
        with: { flutter-version: '3.27.0' }
      - run: flutter build ios --release --no-codesign
```

---

## 74. fastlane / Codemagic 对比

| 维度 | fastlane | Codemagic |
| --- | --- | --- |
| 上手 | 中（学 Ruby DSL） | 低（YAML 配置） |
| 灵活度 | 高 | 中 |
| 价格 | 免费（自带 CI 资源） | SaaS，免费额度 + 付费 |
| 适合 | 自建 CI 服务器、要深度定制 | 中小团队、不想自建 |

`fastlane` 上传 Play / TestFlight：

```ruby
lane :beta do
  build_android_app(task: 'bundleRelease')
  upload_to_play_store(track: 'internal', aab: '../build/app/outputs/bundle/release/app-release.aab')
end
```

---

## 75. 灰度发布与热更新策略

**官方观点：iOS 不允许动态下载并执行可执行代码**，所以传统"热更新"在 iOS 上是黑色地带。

可行做法：
- **Remote Config**（Firebase Remote Config / 自建）：远程开关功能。
- **A/B 实验**：分流不同功能版本。
- **JS / Lua 子模块**：业务由 JS / Lua 描述，Flutter 解释执行。比如某些公司用 `flutter_js`。
- **完全更新**：通过 Play Store / App Store 的 **分阶段发布**（10% → 50% → 100%）。

---

# Part 14 · 架构思维

## 76. 项目结构：Feature-First vs Layer-First

### 76.1 Layer-First（按技术分层）

```
lib/
├── models/
├── repositories/
├── services/
├── widgets/
├── pages/
└── main.dart
```

适合：**小项目**、教学示例。
缺点：随着 feature 增加，每层都鼓胀，跨 feature 修改要跳多个目录。

### 76.2 Feature-First（按功能模块）

```
lib/
├── core/                  # 跨 feature 公共：DI、网络、主题、错误
│   ├── network/
│   ├── theme/
│   └── error/
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── article/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── settings/
├── routing/
└── main.dart
```

**强烈推荐 Feature-First**。新增功能时，所有相关代码都在一个目录下；移除时整目录删。

---

## 77. 分层架构：Presentation / Domain / Data

```
┌────────────────────┐
│ Presentation       │  Widgets, Notifiers, ViewModels
└─────────┬──────────┘
          ↓
┌────────────────────┐
│ Domain             │  Entities, UseCases, Repository 接口
└─────────┬──────────┘
          ↓
┌────────────────────┐
│ Data               │  Repository 实现, DataSource (API / DB)
└────────────────────┘
```

依赖方向：**外层依赖内层**。Domain 是核心，不依赖任何外层。

### 77.1 实例

```
features/article/
├── data/
│   ├── article_dto.dart           # 接口数据形状
│   ├── article_remote_ds.dart     # API 数据源
│   ├── article_local_ds.dart      # 本地缓存数据源
│   └── article_repository_impl.dart
├── domain/
│   ├── article.dart               # 实体（业务关心的）
│   ├── article_repository.dart    # 接口（在这里定义）
│   └── usecases/
│       └── load_articles.dart
└── presentation/
    ├── articles_page.dart
    ├── article_detail_page.dart
    └── article_notifier.dart
```

---

## 78. Repository 与 Use Case 模式

### 78.1 Repository：屏蔽数据源

```dart
abstract interface class ArticleRepository {
  Future<List<Article>> list({int page = 1});
}

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource _remote;
  final ArticleLocalDataSource _local;

  ArticleRepositoryImpl(this._remote, this._local);

  @override
  Future<List<Article>> list({int page = 1}) async {
    try {
      final fresh = await _remote.list(page: page);
      await _local.cache(fresh);
      return fresh;
    } on NetworkError {
      return _local.cached(page: page);   // 离线降级
    }
  }
}
```

### 78.2 Use Case：单一职责的业务动作

```dart
class LoadArticlesUseCase {
  final ArticleRepository _repo;
  LoadArticlesUseCase(this._repo);

  Future<List<Article>> call({int page = 1}) async {
    if (page < 1) throw ArgumentError('page must >= 1');
    return _repo.list(page: page);
  }
}
```

> 💡 小项目可以省略 UseCase，让 Notifier 直接调 Repository。中大型项目用 UseCase 隔离测试单元。

---

## 79. 结果建模：sealed Result / Either

业务方法可能成功或失败。两种建模：

### 79.1 Dart 异常（默认）

```dart
Future<Article> load() async {
  try {
    return await _repo.detail(id);
  } on NetworkError catch (e) {
    // 调用方处理
    rethrow;
  }
}
```

### 79.2 sealed Result（推荐用于 Notifier 暴露给 UI）

```dart
sealed class Result<T> {
  const Result();
}

class Ok<T> extends Result<T> {
  final T value;
  const Ok(this.value);
}

class Err<T> extends Result<T> {
  final AppError error;
  const Err(this.error);
}

// 业务
Future<Result<List<Article>>> safeList() async {
  try {
    return Ok(await _repo.list());
  } on AppError catch (e) {
    return Err(e);
  }
}

// UI
final r = await ref.read(articlesProvider.notifier).safeList();
switch (r) {
  case Ok(:final value): showList(value);
  case Err(:final error): showError(error);
}
```

> 第三方库 `dartz` / `fpdart` 提供 Either，更函数式。Riverpod 项目里直接用 `AsyncValue` 也很好。

---

## 80. 错误处理与日志规范

### 80.1 全局未捕获异常

```dart
void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    Sentry.captureException(details.exception, stackTrace: details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    Sentry.captureException(error, stackTrace: stack);
    return true;
  };
  runZonedGuarded(
    () => runApp(const ProviderScope(child: MyApp())),
    (error, stack) => Sentry.captureException(error, stackTrace: stack),
  );
}
```

### 80.2 日志

```bash
flutter pub add logger
```

```dart
final logger = Logger(printer: PrettyPrinter(methodCount: 0));

logger.d('debug');
logger.i('info');
logger.w('warning');
logger.e('error', error: e, stackTrace: st);
```

发布版本里把 `logger` 等级调高，避免泄漏调试信息。

---

## 81. 模块化与 melos 多包工程

当项目大到三个团队并行开发，单包变成瓶颈。melos 让 monorepo 多 package 协同变可行。

```bash
dart pub global activate melos
```

`melos.yaml`：

```yaml
name: my_workspace
packages:
  - apps/*
  - packages/*

scripts:
  bootstrap:
    run: melos exec -- "flutter pub get"
  analyze:
    run: melos exec -c 6 -- "flutter analyze"
  test:
    run: melos exec --concurrency=1 -- "flutter test"
```

目录：

```
my_workspace/
├── apps/
│   └── my_app/                    # 主 App
├── packages/
│   ├── core_network/              # 网络层
│   ├── core_storage/              # 存储
│   ├── core_ui/                   # 设计系统
│   └── feature_auth/              # 登录模块
└── melos.yaml
```

包之间用本地路径依赖：

```yaml
# apps/my_app/pubspec.yaml
dependencies:
  feature_auth:
    path: ../../packages/feature_auth
```

---

# Part 15 · 企业级实战项目

## 82. 项目目标：极简新闻阅读 App

需求：
1. **首页**：分类 Tab（推荐/科技/娱乐）+ 列表 + 下拉刷新 + 上拉加载。
2. **详情**：渲染富文本 + 评论。
3. **收藏**：本地存储，支持搜索。
4. **我的**：个人信息 + 主题切换 + 语言切换。
5. **登录**：邮箱密码 + Token 持久化。

涉及：路由 / 网络 / 存储 / 状态 / 主题 / i18n / 测试。

---

## 83. 模块拆分与目录骨架

```
news_app/
├── lib/
│   ├── app.dart                       # MaterialApp.router
│   ├── main.dart
│   ├── core/
│   │   ├── env.dart
│   │   ├── error/app_error.dart
│   │   ├── network/dio_provider.dart
│   │   ├── network/auth_interceptor.dart
│   │   ├── storage/secure_storage.dart
│   │   ├── storage/sp_provider.dart
│   │   ├── theme/theme.dart
│   │   ├── theme/theme_mode_provider.dart
│   │   ├── i18n/locale_provider.dart
│   │   └── routing/router.dart
│   ├── features/
│   │   ├── auth/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   ├── feed/
│   │   ├── article/
│   │   ├── favorites/
│   │   └── profile/
│   └── l10n/
└── test/
```

---

## 84. 数据层：API + Repository + 缓存

```dart
// features/feed/domain/article.dart
class Article {
  final String id;
  final String title;
  final String summary;
  final String cover;
  final String author;
  final DateTime publishedAt;
  final String category;
  const Article({
    required this.id,
    required this.title,
    required this.summary,
    required this.cover,
    required this.author,
    required this.publishedAt,
    required this.category,
  });
}

// features/feed/data/article_dto.dart
extension ArticleDTO on Article {
  static Article fromJson(Map<String, dynamic> j) => Article(
    id: j['id'] as String,
    title: j['title'] as String,
    summary: j['summary'] as String? ?? '',
    cover: j['cover'] as String? ?? '',
    author: j['author'] as String? ?? '',
    publishedAt: DateTime.parse(j['publishedAt'] as String),
    category: j['category'] as String? ?? 'general',
  );
}

// features/feed/data/feed_remote_ds.dart
class FeedRemoteDataSource {
  final Dio _dio;
  FeedRemoteDataSource(this._dio);

  Future<List<Article>> list({required String category, required int page}) async {
    final r = await _dio.get('/articles', queryParameters: {'category': category, 'page': page, 'size': 20});
    return (r.data as List).map((e) => ArticleDTO.fromJson(e as Map<String, dynamic>)).toList();
  }
}

// features/feed/domain/feed_repository.dart
abstract interface class FeedRepository {
  Future<List<Article>> list({required String category, required int page});
}

// features/feed/data/feed_repository_impl.dart
class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource _remote;
  FeedRepositoryImpl(this._remote);

  @override
  Future<List<Article>> list({required String category, required int page}) =>
      _remote.list(category: category, page: page);
}

// providers
@Riverpod(keepAlive: true)
FeedRemoteDataSource feedRemoteDS(Ref ref) => FeedRemoteDataSource(ref.watch(dioProvider));

@Riverpod(keepAlive: true)
FeedRepository feedRepo(Ref ref) => FeedRepositoryImpl(ref.watch(feedRemoteDSProvider));
```

---

## 85. 状态层：Riverpod Notifier

```dart
// features/feed/presentation/feed_notifier.dart
@riverpod
class FeedController extends _$FeedController {
  static const _pageSize = 20;
  int _page = 1;
  bool _hasMore = true;

  @override
  Future<List<Article>> build(String category) async {
    _page = 1;
    _hasMore = true;
    final list = await ref.watch(feedRepoProvider).list(category: category, page: _page);
    _hasMore = list.length >= _pageSize;
    return list;
  }

  Future<void> refresh() async {
    _page = 1;
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final list = await ref.read(feedRepoProvider).list(category: category, page: _page);
      _hasMore = list.length >= _pageSize;
      return list;
    });
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;
    final cur = state.valueOrNull ?? [];
    _page++;
    try {
      final more = await ref.read(feedRepoProvider).list(category: category, page: _page);
      _hasMore = more.length >= _pageSize;
      state = AsyncData([...cur, ...more]);
    } catch (e, st) {
      _page--;     // 回滚
      state = AsyncError(e, st);
    }
  }
}
```

---

## 86. UI 层：列表 / 详情 / 收藏

```dart
// features/feed/presentation/feed_page.dart
class FeedPage extends ConsumerWidget {
  final String category;
  const FeedPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(feedControllerProvider(category));

    return RefreshIndicator(
      onRefresh: () => ref.read(feedControllerProvider(category).notifier).refresh(),
      child: asyncList.when(
        loading: () => const _SkeletonList(),
        error: (e, _) => _ErrorView(error: e, onRetry: () => ref.read(feedControllerProvider(category).notifier).refresh()),
        data: (list) {
          if (list.isEmpty) return const _EmptyView();
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: list.length + 1,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (ctx, i) {
              if (i == list.length) {
                // 触发加载更多
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  ref.read(feedControllerProvider(category).notifier).loadMore();
                });
                return const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()));
              }
              return ArticleTile(article: list[i]);
            },
          );
        },
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  final Article article;
  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => ArticleRoute(id: article.id).push(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: article.cover,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(article.summary, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),
                    const Spacer(),
                    Row(
                      children: [
                        Text(article.author, style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(width: 8),
                        Text(_format(article.publishedAt), style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _format(DateTime dt) {
    final d = DateTime.now().difference(dt);
    if (d.inMinutes < 60) return '${d.inMinutes} 分钟前';
    if (d.inHours < 24) return '${d.inHours} 小时前';
    return '${d.inDays} 天前';
  }
}
```

收藏（Hive 持久化）省略，结构与 Todo 相似。

---

## 87. 路由 + 主题 + i18n 装配

```dart
// app.dart
class App extends ConsumerWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'News',
      theme: buildLightTheme(),
      darkTheme: buildDarkTheme(),
      themeMode: ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system,
      locale: ref.watch(localeProvider).valueOrNull,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
    );
  }
}
```

---

## 88. 测试 + DevTools 调优

针对实战项目应做的测试：

1. **单元**：DTO 解析、UseCase 业务规则、AppError 映射。
2. **Widget**：每个页面在 loading/data/error 三状态下的渲染。
3. **集成**：登录 → 浏览 → 收藏 → 注销 完整闭环。
4. **Golden**：核心组件（ArticleTile / EmptyView）。

DevTools 调优 checklist：
- [ ] 列表 itemExtent / RepaintBoundary
- [ ] 图片 cacheWidth
- [ ] Riverpod 用 select 精确依赖
- [ ] 大解析放 isolate
- [ ] 启动时 splash 不卡 → 用 flutter_native_splash

---

# 附录

## 附录 A：Web 前端 → Flutter 速查表

| 任务 | Web | Flutter |
| --- | --- | --- |
| 创建组件 | `function MyBtn() { return <button/> }` | `class MyBtn extends StatelessWidget { build... }` |
| 状态 | `useState(0)` | `setState` / `Riverpod NotifierProvider` |
| Effect | `useEffect(() => {...}, [dep])` | `didChangeDependencies` / `ref.listen` |
| 事件 | `onClick={fn}` | `onPressed: fn` / `onTap: fn` |
| 列表 | `arr.map(x => <Item key=...)` | `ListView.builder(itemBuilder: ...)` |
| 条件渲染 | `cond && <X/>` | `if (cond) X()` 或 `cond ? X() : SizedBox()` |
| 路由 | `<Route path="/x" />` | `GoRoute(path: '/x')` |
| 跳转 | `nav('/x')` | `context.go('/x')` |
| HTTP | `fetch(url)` | `dio.get(url)` |
| LocalStorage | `localStorage.setItem` | `SharedPreferences` |
| CSS 全局 | 全局样式表 | `ThemeData` / `ThemeExtension` |
| flex | `display: flex` | `Row` / `Column` + `Expanded` |
| grid | `display: grid` | `GridView` |
| 绝对定位 | `position: absolute` | `Stack` + `Positioned` |
| 媒体查询 | `@media` | `MediaQuery.sizeOf(context)` / `LayoutBuilder` |
| 表单校验 | yup / zod | `Form` + `validator` |
| 国际化 | i18next | `flutter_localizations` + `intl` |
| 调试器 | Chrome DevTools | Flutter DevTools |
| 测试 | jest / vitest | `flutter_test` + `mocktail` |
| E2E | Playwright / Cypress | `integration_test` |
| 包管理 | npm / pnpm | `pub` |
| HMR | webpack HMR | Hot Reload (`r` / `R`) |

---

## 附录 B：Flutter Web 差异与陷阱

Flutter Web 的渲染目标是 Canvas / WebGL（CanvasKit）或 HTML（已废弃），不是真正的 DOM。

### B.1 渲染器选择（Flutter 3.10+）

- **CanvasKit**（默认）：Skia 编译成 WASM，像素一致、性能好；首次加载多下 ~2MB。
- **HTML 渲染器**：3.27 起默认废弃。新项目无需选择。
- **Wasm 模式**：Flutter 3.22+ 支持 `flutter build web --wasm`，性能更接近原生。

### B.2 SEO

Flutter Web **几乎无 SEO**：内容在 Canvas 上画，爬虫看不到文本。
方案：
- 简单：服务端渲染一份 HTML 给爬虫，App 用 Flutter 接管。
- 内容站：**直接别用 Flutter**，用 Next.js / Nuxt 更合适。

### B.3 常见踩坑

| 问题 | 现象 | 解决 |
| --- | --- | --- |
| 字体加载闪烁 | 首屏短暂英文回退字体 | 配 `<link rel="preload" as="font">` |
| iOS Safari 滚动卡 | iPhone 浏览器列表滚动顿挫 | 减少 RepaintBoundary，避开 BackdropFilter |
| 手势冲突 | 浏览器自身手势（双指缩放）拦了 Flutter 手势 | meta viewport 加 `user-scalable=no` |
| URL 不同步 | 浏览器后退按钮失效 | 用 go_router；urlPathStrategy = path |
| 构建包大 | 几十 MB | `--release` + tree-shake-icons |
| 调用 dart:io | 编译失败 | 用 `kIsWeb` 分支或者 `universal_io` 包 |

### B.4 平台判断

```dart
import 'package:flutter/foundation.dart';

if (kIsWeb) { ... }
if (defaultTargetPlatform == TargetPlatform.iOS) { ... }
```

### B.5 Flutter Web 何时合适？

- ✅ 已有移动 App，提供"网页查看"形态。
- ✅ 内部后台、ToB 应用。
- ✅ Desktop App 共享一套代码。
- ❌ 需要 SEO 的内容站。
- ❌ 主流量来自移动浏览器、需要小包体积。

---

## 附录 C：常用 Pub 包推荐 + 学习资源

### C.1 必装清单

| 类别 | 包 |
| --- | --- |
| 状态管理 | flutter_riverpod / riverpod_annotation / riverpod_generator |
| 路由 | go_router / go_router_builder |
| 网络 | dio / pretty_dio_logger / dio_smart_retry |
| 序列化 | freezed / json_serializable |
| 存储 | shared_preferences / hive / isar / drift / flutter_secure_storage |
| 国际化 | intl |
| 图片 | cached_network_image / flutter_svg |
| 工具 | logger / equatable / collection / uuid |
| 测试 | mocktail / patrol |
| 错误监控 | sentry_flutter |

### C.2 学习资源

- **官方文档**：[docs.flutter.dev](https://docs.flutter.dev) —— 最权威
- **Riverpod 官方**：[riverpod.dev](https://riverpod.dev)
- **DartPad**：[dartpad.dev](https://dartpad.dev) —— 在线练
- **Flutter Engage / Flutter Forward 视频**：YouTube Flutter 频道
- **awesome-flutter**：GitHub `Solido/awesome-flutter`
- **Reso Coder / Code With Andrea**：YouTube 进阶教程
- **公司内部**：建议建一份 ADR（Architecture Decision Records）记录团队的架构决策

---

## 附录 D：需要你确认 / 决策的开放问题

下列问题与你的具体业务相关，没有放进正文，请把答案告诉我，我可以为它们写专题深入篇：

### D.1 业务场景类
1. **目标 App 形态**：内容资讯类、工具类、电商类、IM 类、ToB 后台？决定后续实战章节侧重点。
2. **后端是否已有**：有现成 REST / GraphQL，还是要 mock？接口风格（RESTful / Tencent 风格 `{code, msg, data}`）？
3. **是否需要直播 / 音视频**：用到 `agora_rtc_engine` / `flutter_webrtc` / `video_player` 等，是大坑要专题。
4. **支付 / 推送**：要不要集成微信支付、支付宝、Firebase Cloud Messaging、苹果推送？

### D.2 工程化类
5. **代码生成**：是否启用 freezed + json_serializable 全套？这套能消除 70% 模板代码，但要 build_runner。
6. **设计系统**：是否要建一个独立 `core_ui` package？组件库怎么做版本管理？
7. **多端共享代码**：移动 / Web / Desktop 用一套？还是分仓库？
8. **错误监控 + APM**：选 Sentry / Bugly / 自建？
9. **私有 pub 仓库**：内部 package 怎么发布、依赖？是否要用 melos 全家桶？

### D.3 团队类
10. **团队规模**：1 人独狼？5 人小团队？20+ 人多模块？决定 Riverpod / Bloc 选择和模块化粒度。
11. **既有技术栈**：纯新人，还是有 React Native / 原生 Android/iOS 经验需要迁移？
12. **CI/CD 现状**：已有 Jenkins？GitLab CI？要从零搭？

把任意一项答上来，我就能为它写一份专题扩展（比如"Flutter 接入腾讯 IM 全流程"、"用 melos + freezed 搭建大型工程"）。

---

> 📚 **教程到此结束**。这是一份持续演进的文档，欢迎在阅读过程中标注问题、提出改进点。下一步建议：先把 `news_app` 实战项目（Part 15）按目录搭起来跑通，再回头精读 Riverpod / DevTools / 测试三章，企业级开发的 80% 战斗力就有了。
