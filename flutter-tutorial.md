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
import 'package:flutter/material.dart';        // 引入 Material Design 组件库（包含 MaterialApp / Scaffold / Text 等）

void main() {                                  // App 入口；Dart 程序的起点（与 C/Java/JS 类似）
  runApp(const MyApp());                       // 把根 Widget 挂到 Flutter 渲染管线；const 让实例可被框架复用、不重建
}

class MyApp extends StatelessWidget {          // 根 Widget；Stateless 表示自己不持有可变状态
  const MyApp({super.key});                    // const 构造函数；key 用于跨重建时复用 Element（这里不需要传，留给框架）

  @override                                    // 覆写父类 build 方法
  Widget build(BuildContext context) {         // build 是描述 UI 的核心；每次 rebuild 都会被调用，要保持纯函数式（无副作用）
    // MaterialApp：根容器，提供主题、路由、本地化
    return MaterialApp(                        // Material 风格的根 App 容器
      title: 'Hello Flutter',                  // 任务管理器 / 最近应用里显示的标题（Android），iOS 通常不显示
      theme: ThemeData(                        // 全局主题数据；下方所有 widget 的默认样式来源
        // Material 3 种子色（M3 推荐做法）
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),  // 用一个种子色派生一整套调色板（M3 算法）
        useMaterial3: true,                    // 启用 Material 3（Flutter 3.16+ 默认开启，写明更清晰）
      ),
      home: const HomePage(),                  // 首屏页面；home 等价于初始路由 '/'
    );
  }
}

class HomePage extends StatelessWidget {       // 首页页面 Widget
  const HomePage({super.key});                 // const 构造，便于框架复用 + 避免重建

  @override
  Widget build(BuildContext context) {
    // Scaffold：页面骨架（顶栏、内容区、底栏、抽屉）
    return Scaffold(                           // Material 标准页面框架；提供 AppBar / body / FAB / Drawer 槽位
      appBar: AppBar(title: const Text('首页')),  // 顶部栏；自带阴影、回退按钮、与主题联动
      body: const Center(                      // body 是页面主内容区；Center 让 child 在父空间内居中
        child: Text(
          '你好，Flutter！',                    // 显示的文本
          style: TextStyle(fontSize: 24),      // 字号 24 逻辑像素（lp/dp），Flutter 自动按 DPI 适配各设备
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
class Hello extends StatelessWidget {           // 继承 StatelessWidget：不带状态的 Widget
  final String name;                            // final 字段意味着 Widget 一旦创建就不可变（核心约束）
  const Hello({super.key, required this.name}); // 强烈建议加 const；required 表示必传，编译期校验

  @override
  Widget build(BuildContext context) {          // 描述 UI 的方法；context 保存了当前节点在树里的位置
    return Text('你好，$name');                  // 字符串插值；Text 是叶子 widget，最终对应 RenderParagraph
  }
}
```

> 🌟 **`const` 构造的重要性**：const Widget 实例会被复用，**永远不会触发重建**。能加就加（lint 也会提醒）。

---

## 4. StatelessWidget vs StatefulWidget

### 4.1 StatelessWidget：无内部状态

```dart
class Greeting extends StatelessWidget {        // 无状态 Widget：UI 完全由构造参数决定
  final String name;                            // 配置项：父 widget 创建时传入
  const Greeting({super.key, required this.name});  // const + required，符合 Flutter 推荐风格

  @override
  Widget build(BuildContext context) {
    // 只能读父 widget 传进来的参数（name），自己不持有可变状态
    return Text('Hello, $name');                 // 直接基于参数渲染；如果 name 变 → 父级会重建本 Widget
  }
}
```

### 4.2 StatefulWidget：有可变状态

```dart
class Counter extends StatefulWidget {           // 有状态 Widget：本身仍不可变，但配套一个 State 持有可变数据
  final int initial;                             // 初值；外部传入的"配置"
  const Counter({super.key, this.initial = 0});  // 命名参数 + 默认值（this.initial = 0）

  @override
  State<Counter> createState() => _CounterState();  // 创建对应的 State 实例；只在 Widget 首次插入树时调用一次
}

class _CounterState extends State<Counter> {     // 下划线开头：私有类（只在本文件可见）
  // 状态字段写在 State 里，Widget 类自己保持不可变
  late int _count = widget.initial;              // late 延迟初始化；可访问 widget.xxx 拿到外部传入的配置

  void _increment() {                            // 业务方法：自增
    // ★ 必须用 setState，告诉 framework 要重建
    setState(() {                                // setState 把回调里的修改标脏，下一帧 build 会被调用
      _count++;
    });
  }

  @override
  Widget build(BuildContext context) {           // _count 变 → setState → build 重跑 → UI 更新
    return Column(                               // 纵向布局
      children: [
        Text('count = $_count'),                 // 显示当前计数；字符串插值
        ElevatedButton(onPressed: _increment, child: const Text('+1')),  // 主按钮；点击触发 _increment
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
class ExpandableCard extends StatefulWidget {     // 可展开卡片：需要 Stateful 因为 _expanded 状态属于"自身"
  final String title;                             // 卡片标题（外部传入）
  final String detail;                            // 详情内容（展开后显示）
  const ExpandableCard({super.key, required this.title, required this.detail});  // const + 必传，类型安全

  @override
  State<ExpandableCard> createState() => _ExpandableCardState();  // 工厂方法，绑定 State 类
}

class _ExpandableCardState extends State<ExpandableCard> {
  bool _expanded = false;                         // 展开状态；初值 false（折叠态）

  @override
  Widget build(BuildContext context) {
    return Card(                                  // Material 卡片，自带阴影和圆角
      margin: const EdgeInsets.all(8),            // 卡片外边距 8
      child: InkWell(                             // InkWell 让点击有水波纹（必须挂在 Material 子树里，Card 已是 Material）
        onTap: () => setState(() => _expanded = !_expanded),  // 点击切换展开状态；箭头函数 + setState
        child: Padding(
          padding: const EdgeInsets.all(16),      // 卡片内边距 16
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // 交叉轴左对齐（横向起点）
            children: [
              Row(                                // 第一行：标题 + 折叠箭头
                mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 两端贴边
                children: [
                  Text(widget.title, style: Theme.of(context).textTheme.titleMedium),  // 取主题里的中等标题字号
                  Icon(_expanded ? Icons.expand_less : Icons.expand_more),  // 三元：展开 ↑ / 折叠 ↓
                ],
              ),
              // 用 AnimatedSize 让展开/收起带动画
              AnimatedSize(                       // 子节点尺寸变化时自动以动画过渡（隐式动画）
                duration: const Duration(milliseconds: 200),  // 动画时长 200ms
                curve: Curves.easeInOut,          // 缓动曲线：先加速后减速
                alignment: Alignment.topLeft,     // 尺寸不足时如何对齐（这里向左上锚定）
                child: _expanded
                    ? Padding(                    // 展开：显示详情
                        padding: const EdgeInsets.only(top: 8),  // 与标题留 8 间距
                        child: Text(widget.detail),
                      )
                    : const SizedBox.shrink(),    // 折叠：零尺寸占位（const 复用，零开销）
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
Text(                                       // 文本叶子 widget；最终对应一个 RenderParagraph
  '你好，世界',                              // 第一个位置参数：要显示的字符串
  style: const TextStyle(                   // 文本样式；const 让样式对象在多次 build 间复用
    fontSize: 18,                           // 字号 18 lp
    fontWeight: FontWeight.bold,            // 字重；bold 是 FontWeight.w700 的别名
    color: Colors.indigo,                   // 文字颜色（来自 Material 调色板）
    height: 1.4,        // 行高倍数             // 行高 = fontSize × height = 18 × 1.4 = 25.2 lp
    letterSpacing: 0.5,                     // 字间距 0.5 lp（对中文影响有限，对英文较明显）
  ),
  maxLines: 2,                              // 最多两行；超过会按 overflow 策略处理
  overflow: TextOverflow.ellipsis,  // 超出显示 ...   // 其他可选：clip / fade / visible
  textAlign: TextAlign.center,              // 文本对齐：居中（仅在 Text 占据多余宽度时可见效果）
)
```

复杂格式用 `Text.rich`（≈ HTML 的 `<span>`）：

```dart
Text.rich(                                       // 富文本：单行内可混合多种样式（≈ HTML span）
  TextSpan(                                      // 根 TextSpan 容器；可不带 text，只放 children
    children: [
      const TextSpan(text: '已阅读 '),             // 普通段：仅文本
      TextSpan(
        text: '《Flutter 实战》',                  // 高亮段
        style: const TextStyle(color: Colors.blue),  // 蓝色，模拟链接
        // 可点击：附加手势识别器
        recognizer: TapGestureRecognizer()..onTap = () => print('点了书名'),  // ..级联调用绑定 onTap
      ),
      const TextSpan(text: ' 共 3 小时'),          // 后置段
    ],
  ),
)
```

### 5.2 Image

```dart
// 资源图（要在 pubspec.yaml 注册 assets）
Image.asset('assets/images/logo.png', width: 100)  // 从打包资源加载；width 限制宽度（高度按比例）

// 网络图（生产请用 cached_network_image）
Image.network(                                  // 从 URL 加载；首帧前会显示空白
  'https://example.com/avatar.jpg',
  width: 80,                                    // 显示宽度
  height: 80,                                   // 显示高度
  fit: BoxFit.cover,        // 等价 CSS object-fit: cover  // cover 裁切填满；fill 拉伸；contain 留白
  loadingBuilder: (ctx, child, progress) {      // 加载过程回调：自定义占位
    if (progress == null) return child;         // progress=null 表示加载完成，直接展示 child
    return const CircularProgressIndicator();   // 加载中显示菊花
  },
  errorBuilder: (ctx, err, stack) => const Icon(Icons.broken_image),  // 加载失败时显示破图标
)

// 内存中的字节
Image.memory(uint8ListBytes)                    // 直接拿一段 Uint8List（如下载得到的字节）渲染

// 文件
Image.file(File('/path/to/file.png'))           // 本地文件路径；移动端要用 path_provider 拿合法目录
```

> 🌟 生产推荐：`cached_network_image` 包，自动磁盘缓存 + 占位 + 错误图。

### 5.3 Icon

```dart
const Icon(Icons.favorite, size: 24, color: Colors.red)  // Material 图标；size 单位 lp，color 覆盖默认色

// 自定义图标字体（Material Icons 之外）
const Icon(IconData(0xe900, fontFamily: 'MyIcons'))  // 用 IconFont 自定义；codePoint 对应字体里的字形位
```

### 5.4 按钮家族（Material 3）

```dart
ElevatedButton(                                  // 凸起按钮：M3 中表示次强调（M2 中是主按钮）
  onPressed: () {},                              // 点击回调；传空闭包代表"启用但什么都不做"
  child: const Text('提交'),                      // 按钮内容；通常是 Text/Icon 或 Row 组合
)

FilledButton(onPressed: () {}, child: const Text('强调'))  // M3 主按钮（最强视觉强调）

OutlinedButton(onPressed: () {}, child: const Text('次要'))  // 描边按钮：次要操作

TextButton(onPressed: () {}, child: const Text('文字'))  // 纯文字按钮：最弱视觉强调（如对话框取消）

IconButton(icon: const Icon(Icons.menu), onPressed: () {})  // 图标按钮；常放 AppBar / actions

// 浮动按钮
FloatingActionButton(                            // 悬浮主操作按钮（FAB）；通常右下角
  onPressed: () {},
  child: const Icon(Icons.add),
)

// 禁用：onPressed 传 null
ElevatedButton(onPressed: null, child: const Text('禁用'))  // null = 禁用状态（颜色变灰，不响应点击）

// 自定义样式
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(               // styleFrom 工厂帮你少写 MaterialStateProperty 模板代码
    backgroundColor: Colors.indigo,              // 背景色
    foregroundColor: Colors.white,               // 前景色（文字 + 图标 + 涟漪）
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),  // 内边距
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),  // 8 圆角矩形
  ),
  child: const Text('自定义'),
)
```

### 5.5 进度 / 加载 / 提示

```dart
const CircularProgressIndicator()                // 圆形菊花；不传 value 默认是不确定进度（一直转）
const LinearProgressIndicator(value: 0.6)        // 水平进度条；value 0~1，传 null 也表示不确定进度

// SnackBar（瞬时提示）
ScaffoldMessenger.of(context).showSnackBar(      // 通过 ScaffoldMessenger 显示，跨页面也能存活
  const SnackBar(content: Text('保存成功')),       // SnackBar 默认底部弹出 4s 后自动消失
);

// Dialog
showDialog<bool>(                                // 类型参数 bool = Navigator.pop 时返回值类型
  context: context,                              // 必须传当前 context，用于找 Navigator
  builder: (ctx) => AlertDialog(                 // builder 在 Navigator 上层创建对话框；ctx 是对话框的 context
    title: const Text('确认'),                    // 对话框标题
    content: const Text('确定删除？'),             // 对话框正文
    actions: [                                   // 底部按钮组
      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('取消')),  // pop 返回 false
      FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('删除')),  // pop 返回 true
    ],
  ),
);

// 底部弹窗
showModalBottomSheet(                            // 模态底部弹窗；点击外部自动关闭
  context: context,
  builder: (ctx) => SizedBox(height: 200, child: Center(child: Text('内容'))),  // 高度 200，内容居中
);
```

---

## 6. 容器与装饰

### 6.1 Container：万能容器

```dart
Container(                                       // 万能容器：内部由多个细分 widget 组合而成
  width: 200,                                    // 宽度
  height: 100,                                   // 高度
  margin: const EdgeInsets.all(16),              // 外边距：在容器外部留白
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),  // 内边距：包住 child
  decoration: BoxDecoration(                     // 装饰：背景、边框、阴影、渐变都在这里
    color: Colors.white,                         // 背景色（注意：不能与 gradient 同时设置）
    borderRadius: BorderRadius.circular(12),     // 圆角 12
    border: Border.all(color: Colors.grey.shade300),  // 边框：灰色细线
    boxShadow: [                                 // 阴影列表（可叠加多个）
      BoxShadow(
        color: Colors.black.withOpacity(0.08),   // 半透明黑（8% 不透明度）
        blurRadius: 12,                          // 模糊半径
        offset: const Offset(0, 4),              // 偏移：向下 4 lp，制造投影感
      ),
    ],
    gradient: const LinearGradient(              // 线性渐变；和 color 互斥
      colors: [Colors.blue, Colors.purple],      // 渐变色站点
      begin: Alignment.topLeft,                  // 渐变起点
      end: Alignment.bottomRight,                // 渐变终点（左上→右下）
    ),
  ),
  alignment: Alignment.center,                   // child 在容器内居中
  child: const Text('卡片'),                      // 内容
)
```

### 6.2 性能更好的细分 Widget

`Container` 是个"万能瑞士军刀"，但代价是有不必要的开销。**生产建议拆分**：

```dart
// 只要 padding：用 Padding
Padding(padding: const EdgeInsets.all(16), child: ...)  // 单职责：只负责留内边距，开销最小

// 只要尺寸：用 SizedBox
const SizedBox(height: 8)             // 垂直间距     // 只指定一边时，常作为 Column / Row 之间的间距槽
const SizedBox(width: 8)              // 水平间距
const SizedBox(width: 100, height: 50, child: ...)     // 强制 child 在指定尺寸下渲染
const SizedBox.shrink()               // 占位，零尺寸  // 等价 SizedBox(width:0, height:0)，常用作三元中"什么都不显示"

// 只要背景色：ColoredBox
const ColoredBox(color: Colors.amber, child: ...)  // 比 Container(color:) 轻量；child 必须有自己尺寸

// 只要装饰：DecoratedBox
DecoratedBox(decoration: BoxDecoration(...), child: ...)  // 仅装饰，不处理 padding/margin

// 只要居中：Center
Center(child: ...)                                  // 让 child 在父空间内水平 + 垂直居中

// 圆角裁剪：ClipRRect
ClipRRect(borderRadius: BorderRadius.circular(12), child: image)  // 把 child 按圆角矩形裁切
```

### 6.3 EdgeInsets 用法

```dart
EdgeInsets.all(16)                                 // 四向 16        // 上右下左都是 16
EdgeInsets.symmetric(horizontal: 12, vertical: 8)  // 水平/垂直       // 左右 12，上下 8
EdgeInsets.only(left: 8, top: 16)                  // 单边           // 未指定的边为 0
EdgeInsets.fromLTRB(8, 16, 8, 16)                  // 顺时针          // 注意是 Left/Top/Right/Bottom 顺序
```

---

## 7. 布局：Row / Column / Stack / Flex

### 7.1 Column / Row：一维布局

```dart
Column(                                          // 纵向一维布局；内部 Flex 实现
  // 主轴对齐（垂直方向）
  mainAxisAlignment: MainAxisAlignment.center,   // children 在主轴（垂直）方向居中
  // 交叉轴对齐（水平方向）
  crossAxisAlignment: CrossAxisAlignment.stretch,  // 交叉轴拉伸：每个 child 横向占满父宽
  // 主轴尺寸：max 占满父高，min 包裹内容
  mainAxisSize: MainAxisSize.min,                // 主轴只占 child 总高（默认 max 占满父高）
  children: const [
    Text('上'),                                   // 第一个 child（顶部）
    SizedBox(height: 8),                         // 间距 8
    Text('中'),
    SizedBox(height: 8),
    Text('下'),                                   // 最后一个 child（底部）
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
Row(                                             // 横向一维布局
  children: [
    const Icon(Icons.menu),                      // 固定宽度图标
    const SizedBox(width: 8),                    // 间距
    Expanded(child: TextField(decoration: InputDecoration(hintText: '搜索'))),  // 中间输入框占满剩余空间
    const SizedBox(width: 8),
    const Icon(Icons.search),                    // 右端固定图标
  ],
)

// flex 比例
Row(
  children: [
    Expanded(flex: 2, child: Container(color: Colors.red)),   // 占 2/(2+3)
    Expanded(flex: 3, child: Container(color: Colors.blue)),  // 占 3/(2+3)
  ],
)

// Flexible：可以不占满
Flexible(fit: FlexFit.loose, child: Text('文本不超过自身宽度'))  // loose：能小则小（与 Expanded 区别：Expanded == fit:tight）
```

> ⚠️ Row / Column 的 child 不能"无限大"。如果里面塞了 Text 太长，会爆 "RenderFlex overflowed by 30 px"。
> 解决：要么 `Expanded`，要么换成 `Wrap`（自动换行）。

### 7.3 Stack：层叠（≈ position: absolute）

```dart
Stack(                                           // 层叠布局：children 沿 Z 轴叠放，下面的在底层
  alignment: Alignment.center,    // 默认 child 怎么对齐  // 没有 Positioned 包裹的 child 按此对齐
  children: [
    Image.network(banner),                       // 第一层：背景图（最大尺寸决定 Stack 大小）
    // Positioned 控制具体位置
    const Positioned(                            // 绝对定位（≈ CSS position: absolute）
      bottom: 16,                                // 距底部 16
      right: 16,                                 // 距右边 16
      child: Chip(label: Text('VIP')),           // 角标小标签
    ),
    Positioned.fill(child: Container(color: Colors.black26)),  // fill 等价四向都为 0；铺一层半透明遮罩
  ],
)
```

### 7.4 Wrap：自动换行

```dart
Wrap(                                            // 自动换行布局；类似 CSS flex-wrap: wrap
  spacing: 8,           // 主轴间距             // 同行 child 之间的水平距离
  runSpacing: 8,        // 换行间距             // 行与行之间的垂直距离
  children: tags.map((t) => Chip(label: Text(t))).toList(),  // 把 tags 列表映射成 Chip 列表
)
```

### 7.5 完整场景：评论卡片

```dart
class CommentCard extends StatelessWidget {       // 评论卡片：典型横向 = 头像 + 主体（Row + Expanded 模式）
  final String avatar;                            // 头像 URL
  final String name;                              // 昵称
  final String time;                              // 发布时间（已格式化的字符串）
  final String content;                           // 评论正文
  final int likes;                                // 点赞数

  const CommentCard({                             // const 构造便于复用
    super.key,
    required this.avatar,
    required this.name,
    required this.time,
    required this.content,
    required this.likes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(                               // 整张卡片的外边距
      padding: const EdgeInsets.all(16),
      child: Row(                                 // 横向：左头像 + 右内容
        crossAxisAlignment: CrossAxisAlignment.start,  // 顶部对齐（避免长内容把头像往下推）
        children: [
          // 头像
          ClipOval(                               // 圆形裁剪；ClipRRect 也能做圆，但 Oval 语义更直接
            child: Image.network(
              avatar,
              width: 40,
              height: 40,
              fit: BoxFit.cover,                  // 裁剪填满 40×40 方框
            ),
          ),
          const SizedBox(width: 12),              // 头像与内容之间的间距
          // 右侧主体（用 Expanded 占满剩余宽度）
          Expanded(                               // 防止 Row 内部溢出 + 让内容尽量宽
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,  // 文本左对齐
              children: [
                // 第一行：昵称 + 时间
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,  // 昵称左、时间右
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),  // 加粗昵称
                    Text(time, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),  // 灰色小字
                  ],
                ),
                const SizedBox(height: 4),
                // 内容
                Text(content, maxLines: 3, overflow: TextOverflow.ellipsis),  // 最多 3 行 + 省略号
                const SizedBox(height: 8),
                // 操作栏
                Row(
                  children: [
                    const Icon(Icons.favorite_border, size: 16),  // 心形图标，未点赞态
                    const SizedBox(width: 4),
                    Text('$likes'),                  // 点赞数（整数转字符串）
                    const SizedBox(width: 16),       // 两组操作之间的间隔
                    const Icon(Icons.reply, size: 16),  // 回复图标
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
SingleChildScrollView(                           // 一次性渲染全部 child；只有内容超出可视区时才滚
  padding: const EdgeInsets.all(16),             // 滚动内容的内边距
  child: Column(                                 // 通常配 Column 做长表单；Row 配它则横向滚
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
ListView(                                        // 默认构造：一次性创建所有 child（只适合少量）
  children: const [
    ListTile(leading: Icon(Icons.person), title: Text('个人资料')),  // ListTile：标准列表项
    ListTile(leading: Icon(Icons.settings), title: Text('设置')),
  ],
)

// 动态列表（推荐）：itemBuilder 懒加载
ListView.builder(                                // 按需构建，仅可见区域 + 缓冲构建（性能好）
  itemCount: posts.length,                       // 总条数
  itemBuilder: (ctx, i) => PostTile(post: posts[i]),  // 每项的构建函数
)

// 带分割线
ListView.separated(                              // 在每两个 item 间插入分割
  itemCount: posts.length,
  itemBuilder: (ctx, i) => PostTile(post: posts[i]),
  separatorBuilder: (ctx, i) => const Divider(height: 1),  // 分割线 widget；height 是占据的总高
)
```

### 8.3 GridView：网格

```dart
GridView.builder(                                // 网格视图：按需构建
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(  // delegate 决定布局规则；这里固定列数
    crossAxisCount: 2,        // 列数               // 一行 2 个
    childAspectRatio: 0.75,   // 宽高比             // child 宽 / 高 = 0.75（高比宽多）
    crossAxisSpacing: 8,                          // 列间距
    mainAxisSpacing: 8,                           // 行间距
  ),
  itemCount: products.length,
  itemBuilder: (ctx, i) => ProductCard(product: products[i]),
)

// 自动按宽度排：每个 item 最大 200 宽
GridView.builder(
  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(  // 另一种 delegate：固定每个 item 的最大宽
    maxCrossAxisExtent: 200,                     // 每个 item 不超过 200 lp 宽（窄屏 2 列、宽屏更多列）
    childAspectRatio: 1,                         // 正方形
  ),
  itemCount: 30,
  itemBuilder: (ctx, i) => Card(child: Center(child: Text('$i'))),
)
```

### 8.4 CustomScrollView + Slivers：复杂滚动

需求："顶部图片下拉收缩 + 中间网格 + 下面列表 + 一起滚动"——这是 Slivers 的舞台。

```dart
CustomScrollView(                                // 多 sliver 共享一个 ScrollView；统一滚动手势与位置
  slivers: [                                     // 注意：children 必须是 Sliver*，不是普通 widget
    // 1. 顶部可折叠 AppBar
    SliverAppBar(                                // 滚动时可折叠的 AppBar
      pinned: true,                              // 折叠到最小后保持吸顶（不滚出屏幕）
      expandedHeight: 200,                       // 展开态高度
      flexibleSpace: FlexibleSpaceBar(           // 折叠区里的内容（标题 + 背景）
        title: const Text('个人主页'),
        background: Image.network(coverUrl, fit: BoxFit.cover),  // 折叠区背景图
      ),
    ),
    // 2. 网格区
    SliverPadding(                               // 给 sliver 加内边距（不能直接套 Padding）
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid(                        // sliver 版本的 GridView
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),  // 3 列
        delegate: SliverChildBuilderDelegate(    // 每项的构建器
          (ctx, i) => Card(child: Center(child: Text('G$i'))),
          childCount: 9,                         // 9 个 child
        ),
      ),
    ),
    // 3. 列表区
    SliverList(                                  // sliver 版本的 ListView
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
RefreshIndicator(                                // 下拉刷新的 Material 控件；自带加载圈动画
  onRefresh: () async {                          // 下拉到位时回调；返回 Future，完成时自动收起加载圈
    await ref.read(postsProvider.notifier).refresh();  // 触发刷新业务（这里调 Riverpod Notifier）
  },
  child: ListView.builder(                       // child 必须是可滚的 widget（ListView/CustomScrollView 等）
    itemCount: posts.length + 1,                 // +1 给"加载更多"占位
    itemBuilder: (ctx, i) {
      if (i == posts.length) {                   // 走到最后一项 = 加载更多 sentinel
        // 滚到底就触发加载更多（实战用 NotificationListener 更精细）
        WidgetsBinding.instance.addPostFrameCallback((_) {  // 当前帧绘制完成后再触发，避免在 build 中改 state
          ref.read(postsProvider.notifier).loadMore();
        });
        return const Padding(                    // 占位 + 菊花
          padding: EdgeInsets.all(16),
          child: Center(child: CircularProgressIndicator()),
        );
      }
      return PostTile(post: posts[i]);           // 普通条目
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
  final _emailCtl = TextEditingController();      // 邮箱输入框控制器：可读写文本、监听变化
  final _pwdCtl = TextEditingController();        // 密码输入框控制器
  final _emailFocus = FocusNode();                // 焦点节点：可控制聚焦/失焦、监听焦点变化

  @override
  void dispose() {                                // State 永久销毁时调用；必须释放资源避免泄漏
    _emailCtl.dispose();                          // 释放控制器（内部有 Listener、防内存泄漏）
    _pwdCtl.dispose();
    _emailFocus.dispose();                        // FocusNode 也是可释放资源
    super.dispose();                              // 末尾调父类（Flutter 习惯：先自己再 super）
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(                                // 普通文本输入框
          controller: _emailCtl,                  // 关联控制器
          focusNode: _emailFocus,                 // 关联焦点节点
          keyboardType: TextInputType.emailAddress,  // 弹出邮箱键盘（带 @ 的快捷键）
          autofocus: true,                        // 进入页面立刻聚焦
          decoration: const InputDecoration(      // 装饰：标签、提示、边框、前缀图标
            labelText: '邮箱',                     // 浮动标签
            hintText: 'you@example.com',          // 占位提示
            border: OutlineInputBorder(),         // 边框样式：四方框
            prefixIcon: Icon(Icons.email),        // 前缀图标
          ),
          onChanged: (v) => print('实时: $v'),     // 每次输入触发；性能敏感的话别在这里大计算
          onSubmitted: (v) => FocusScope.of(context).nextFocus(),  // 软键盘"完成"键 → 聚焦下一个输入框
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _pwdCtl,
          obscureText: true,                      // 密码框：把字符渲染成圆点
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
class RegisterForm extends StatefulWidget {       // 注册表单：声明式校验
  const RegisterForm({super.key});
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // 用 GlobalKey 持有 Form 状态，便于触发校验、保存
  final _formKey = GlobalKey<FormState>();        // GlobalKey 让外部可以访问 FormState（validate/save/reset）
  String _email = '';                             // 校验通过后由 onSaved 写入
  String _password = '';

  void _submit() {                                // 提交按钮回调
    final form = _formKey.currentState!;          // 拿到 FormState；这里断言非空（已挂载就一定有）
    if (!form.validate()) return;                 // 触发所有 validator；任一返回非 null 字符串则失败
    form.save();                                  // 触发所有 onSaved，把值写入字段
    print('提交: $_email / $_password');
  }

  @override
  Widget build(BuildContext context) {
    return Form(                                  // Form 是协调器，本身不产生 UI
      key: _formKey,                              // 关联 GlobalKey
      autovalidateMode: AutovalidateMode.onUserInteraction,  // 用户交互后自动校验（不会一上来就红字）
      child: Column(
        children: [
          TextFormField(                          // 带校验能力的输入框
            decoration: const InputDecoration(labelText: '邮箱'),
            validator: (v) {                      // 校验函数；返回 null = 通过；非 null 字符串 = 错误信息
              if (v == null || v.isEmpty) return '邮箱不能为空';
              if (!v.contains('@')) return '邮箱格式不对';
              return null;
            },
            onSaved: (v) => _email = v ?? '',     // form.save() 时调用；把值持久化到外部变量
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: '密码'),
            obscureText: true,
            validator: (v) => (v?.length ?? 0) < 6 ? '至少 6 位' : null,  // 三元 + null 安全
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
Checkbox(value: agreed, onChanged: (v) => setState(() => agreed = v ?? false))  // value 受控；v 可能为 null（三态时）

// 单选按钮
Radio<int>(value: 1, groupValue: selected, onChanged: (v) => setState(() => selected = v))  // 同 group 中只能选一项

// 开关
Switch(value: dark, onChanged: (v) => setState(() => dark = v))  // iOS 风格 Switch；onChanged: null 表示禁用

// 滑块
Slider(value: volume, min: 0, max: 100, onChanged: (v) => setState(() => volume = v))  // 连续滑动；可加 divisions 离散化

// 下拉
DropdownButton<String>(                          // 泛型 String：value 类型必须与 items 一致
  value: lang,                                   // 当前选中值
  items: const [                                 // 可选项列表
    DropdownMenuItem(value: 'zh', child: Text('中文')),
    DropdownMenuItem(value: 'en', child: Text('English')),
  ],
  onChanged: (v) => setState(() => lang = v ?? 'zh'),  // 选中项变化回调（v 可能为 null）
)

// 日期选择
final picked = await showDatePicker(             // 异步弹出日期选择器；返回选中的 DateTime?
  context: context,
  initialDate: DateTime.now(),                   // 默认聚焦的日期
  firstDate: DateTime(2000),                     // 可选范围下限
  lastDate: DateTime(2099),                      // 可选范围上限
);
```

---

## 10. 基础导航：Navigator 1.0

> 🌟 现代项目应直接用 `go_router`（Part 5），但理解 Navigator 1.0 是基础。

### 10.1 push / pop

```dart
// 进入新页面
final result = await Navigator.push<bool>(       // 入栈；泛型 bool 表示 pop 时返回值类型
  context,
  MaterialPageRoute(builder: (_) => const DetailPage()),  // MaterialPageRoute 自带平移 + 返回手势
);
if (result == true) {                            // null / false 都算"没确认"
  print('从详情页返回时带回了 true');
}

// 返回（带值）
Navigator.pop(context, true);                    // 出栈；第二个参数是给上层 push 的返回值

// 替换（不能返回上一页）
Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));  // 把当前栈顶替换掉

// 清空栈到某条件
Navigator.pushAndRemoveUntil(                    // push 新页面 + 不断 pop 到 predicate 返回 true 为止
  context,
  MaterialPageRoute(builder: (_) => const HomePage()),
  (route) => false,                              // false 永远不停 → 清空整个栈，只剩新页面
);
```

### 10.2 命名路由

```dart
MaterialApp(                                     // 在 MaterialApp 上声明命名路由表
  routes: {                                      // 路由名 → 页面构造器
    '/': (ctx) => const HomePage(),
    '/login': (ctx) => const LoginPage(),
    '/profile': (ctx) => const ProfilePage(),
  },
  initialRoute: '/',                             // 启动时的初始路由
)

// 跳转
Navigator.pushNamed(context, '/login');          // 按名字 push；不带返回值类型

// 传参
Navigator.pushNamed(context, '/profile', arguments: userId);  // arguments 是 Object?；任意类型
final userId = ModalRoute.of(context)!.settings.arguments as String;  // 在目标页通过 ModalRoute 拿；强转 → 错了运行时崩
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
  late StreamSubscription _sub;                   // late 表示稍后初始化（initState 里赋值）
  late TextEditingController _ctl;
  Timer? _timer;                                  // 可空：未初始化时为 null（与 late 区别）

  @override
  void initState() {                              // 仅一次：State 加入树时调用
    super.initState();                            // 必须先调父类
    // ✅ 创建 controller / 订阅事件 / 启动定时器
    _ctl = TextEditingController();               // 初始化控制器
    _sub = someStream.listen(_onData);            // 订阅 Stream，保存订阅对象以便后续取消
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => print('tick'));  // 启动定时器

    // ❌ 这里不能用 context 访问 Theme / MediaQuery / InheritedWidget
    // 真要用：放到 didChangeDependencies
  }

  @override
  void didChangeDependencies() {                  // 多次：依赖（InheritedWidget / Theme）变更时调用
    super.didChangeDependencies();
    // ✅ 依赖变化时（首次进入 + 依赖更新）执行
    final lang = Localizations.localeOf(context); // 这里可以安全地访问 InheritedWidget
    print('当前语言: $lang');
  }

  @override
  void didUpdateWidget(covariant MyWidget oldWidget) {  // 多次：父级 Widget 配置变化时调用
    super.didUpdateWidget(oldWidget);
    // ✅ 父传入参数变了，这里同步内部状态
    if (oldWidget.userId != widget.userId) {      // 比较新旧 props
      _reloadData();                              // 关键 prop 变 → 重新加载
    }
  }

  @override
  void dispose() {                                // 仅一次：State 永久销毁前调用
    // ✅ 必须释放资源；忘记会内存泄漏
    _sub.cancel();                                // 取消 Stream 订阅
    _timer?.cancel();                             // ?. null 安全调用
    _ctl.dispose();                               // 释放控制器
    super.dispose();                              // 末尾调父类
  }

  @override
  Widget build(BuildContext context) {            // 多次：每次需要重建时调用
    // ✅ 纯描述，不要做副作用
    return TextField(controller: _ctl);           // 用 initState 中创建的控制器
  }
}
```

### 11.4 App 级别生命周期：WidgetsBindingObserver

```dart
class _MyAppState extends State<MyApp> with WidgetsBindingObserver {  // mixin 引入 App 级生命周期回调
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);    // 注册到全局 Observer 列表，开始接收回调
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // 必须取消注册，避免泄漏 + 死引用回调
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {  // App 在前台/后台等状态切换时被调
    switch (state) {                              // sealed 枚举；推荐 switch 表达式覆盖全部分支
      case AppLifecycleState.resumed:    // App 回到前台      // 用户回到 App 时；常用于刷新数据
      case AppLifecycleState.inactive:   // 即将进入后台（iOS）  // 来电、控制中心、应用切换器等
      case AppLifecycleState.paused:     // 在后台          // 不可见状态；停止动画、释放摄像头等
      case AppLifecycleState.detached:   // 引擎被销毁        // 主 isolate 仍在运行，但已无可见视图
      case AppLifecycleState.hidden:     // 隐藏（桌面）      // 桌面端最小化等
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
final theme = Theme.of(context);                  // Theme.of 沿 Element 树向上查找最近 Theme
final colors = Theme.of(context).colorScheme;     // 取调色板

// 拿到屏幕尺寸 / 状态栏高度
final size = MediaQuery.sizeOf(context);          // sizeOf 是 Flutter 3.10+ 优化版（仅订阅 size 变化）
final padding = MediaQuery.paddingOf(context);    // 状态栏 + 导航条等系统占位

// 拿到 Scaffold（用 of 调用方法）
ScaffoldMessenger.of(context).showSnackBar(...);  // SnackBar 必须经 ScaffoldMessenger（不再用 Scaffold.of）

// 拿到 Navigator
Navigator.of(context).push(...);                  // 拿到最近 Navigator，用其方法做路由

// 拿到自定义 InheritedWidget
final user = UserScope.of(context);               // 自定义 of 静态方法的标准用法
```

### 12.3 ★ 经典坑：跨页面 / Builder 用错 context

```dart
// ❌ 错误：在 onPressed 里用了外层 build 的 context，可能是 MaterialApp 上层
@override
Widget build(BuildContext context) {              // 这里的 context 在 Scaffold 之上
  return Scaffold(
    body: ElevatedButton(
      onPressed: () {
        // 这个 context 是 Scaffold 之上的，找不到 ScaffoldMessenger
        ScaffoldMessenger.of(context).showSnackBar(...);  // 实际上能找到（在 MaterialApp 里），但理解 context 上下文很重要
      },
      child: const Text('提示'),
    ),
  );
}

// ✅ 正确：用 Builder 包一层，拿到 Scaffold 之下的 context
Builder(                                          // Builder 仅作用：给 child 提供它自己的 context（位置更深）
  builder: (context) => ElevatedButton(           // 这里的 context 在 Scaffold 之下，能找到 Scaffold/Messenger
    onPressed: () => ScaffoldMessenger.of(context).showSnackBar(...),
    child: const Text('提示'),
  ),
)
```

### 12.4 mounted 检查（异步必须）

```dart
Future<void> _save() async {
  await api.save();                               // await 期间 widget 可能被 dispose
  // 异步完成时 widget 可能已经被销毁，访问 setState / context 会抛异常
  if (!mounted) return;                           // mounted 是 State 的属性；false = 已 dispose
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('已保存')));  // 此时安全
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
class Demo extends StatefulWidget {               // 演示 Element 复用机制：状态错位
  const Demo({super.key});
  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  bool flipped = false;                           // 翻转标志

  @override
  Widget build(BuildContext context) {
    final tiles = [                               // 两个 ColorTile（注意：没有 key）
      const ColorTile(color: Colors.red),
      const ColorTile(color: Colors.blue),
    ];
    return Column(
      children: [
        Row(children: flipped ? tiles.reversed.toList() : tiles),  // 用 flipped 控制是否反转顺序
        TextButton(onPressed: () => setState(() => flipped = !flipped), child: const Text('交换')),
      ],
    );
  }
}

class ColorTile extends StatefulWidget {           // 一个有内部状态的方块
  final Color color;
  const ColorTile({super.key, required this.color});
  @override
  State<ColorTile> createState() => _ColorTileState();
}

class _ColorTileState extends State<ColorTile> {
  int taps = 0;                                   // 点击次数；本地状态
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => taps++),        // 点击 → 计数 +1
      child: Container(
        width: 100,
        height: 100,
        color: widget.color,                      // 颜色由父级传入
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
ValueKey(item.id)                                 // 用业务 id 做 key，最常见（列表、Dismissible 必备）
ValueKey('header')                                // 字符串字面量也能当 key

// 2. ObjectKey：用对象 identity 匹配
ObjectKey(myObject)                               // 适合 hashCode/== 不可控的对象，按引用匹配

// 3. UniqueKey：每次都不同（用于强制 element 重建）
UniqueKey()                                       // 每次 build 都新建 key → 一定触发重建（少用）

// 4. GlobalKey：全局唯一，跨树搬 state
final formKey = GlobalKey<FormState>();           // 泛型限定能拿到的 State 类型
formKey.currentState?.validate();                 // 可在外部访问对应 State 的方法
```

### 14.3 GlobalKey 应用：拿到 State

```dart
// 用 GlobalKey 拿到 child 的 State
final scaffoldKey = GlobalKey<ScaffoldState>();   // 泛型 ScaffoldState：能拿到 Scaffold 的内部状态

Scaffold(
  key: scaffoldKey,                               // 把 GlobalKey 挂在目标 widget 上
  body: ...,
);

// 在别处：
scaffoldKey.currentState?.openDrawer();           // currentState 可能为 null（尚未挂载）；用 ?. 安全调用
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
class CounterScope extends InheritedWidget {      // 自定义 InheritedWidget，沿树共享数据
  final int count;                                // 暴露给子树的数据
  final VoidCallback increment;                   // 暴露的方法（让子树触发状态变更）

  const CounterScope({
    super.key,
    required this.count,
    required this.increment,
    required super.child,                         // InheritedWidget 必须有 child
  });

  /// 提供给 children 的 of 方法
  static CounterScope of(BuildContext context) {  // 标准 of 方法封装查找逻辑
    final scope = context.dependOnInheritedWidgetOfExactType<CounterScope>();  // 关键：注册依赖 + 向上查找
    assert(scope != null, '没有找到 CounterScope，请把它放在更上层');
    return scope!;                                // 找不到就直接断言；线上要更友好可改为返回 null
  }

  @override
  bool updateShouldNotify(CounterScope old) => count != old.count;  // 决定子树是否需要 rebuild
}

// 顶层用一个 StatefulWidget 持有真正的可变状态
class CounterRoot extends StatefulWidget {        // InheritedWidget 自身不可变；用 Stateful 封装可变状态
  final Widget child;
  const CounterRoot({super.key, required this.child});
  @override
  State<CounterRoot> createState() => _CounterRootState();
}

class _CounterRootState extends State<CounterRoot> {
  int _count = 0;                                 // 真正的可变状态

  @override
  Widget build(BuildContext context) {
    return CounterScope(                          // 每次 build 都创建新的 InheritedWidget 实例
      count: _count,
      increment: () => setState(() => _count++),  // 暴露动作
      child: widget.child,                        // 子树
    );
  }
}

// 子 widget 任意位置消费
class _Display extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scope = CounterScope.of(context);       // 一行拿到数据 + 自动建立依赖
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
  theme: ThemeData(                               // 全局主题数据；下面 widget 默认继承
    useMaterial3: true,                           // 启用 M3
    colorScheme: ColorScheme.fromSeed(            // 由种子色派生整套颜色
      seedColor: const Color(0xFF6750A4),         // 0xFF + 6 位 ARGB；FF 是 alpha
      brightness: Brightness.light,               // 亮色主题
    ),
    textTheme: const TextTheme(                   // 字体阶梯（M3 13 个等级）
      displayLarge: TextStyle(fontSize: 56, fontWeight: FontWeight.bold),  // 大标题
      bodyMedium: TextStyle(fontSize: 14, height: 1.5),                    // 正文
    ),
    appBarTheme: const AppBarTheme(               // AppBar 默认样式
      centerTitle: true,                          // 标题居中
      elevation: 0,                               // 不要默认阴影
    ),
    elevatedButtonTheme: ElevatedButtonThemeData( // 按钮默认样式
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ),
)
```

### 16.2 Material 3 种子色 → 完整调色板

```dart
final cs = ColorScheme.fromSeed(seedColor: Colors.indigo);  // 用 indigo 派生整套调色板
print(cs.primary);              // 品牌主色          // 强调色，按钮 / FAB / Switch 等默认色
print(cs.onPrimary);            // 主色上的文字      // 与 primary 配对的前景色，自动确保可读对比度
print(cs.surface);              // 卡片/面板底色     // 默认背景
print(cs.surfaceContainerHigh); // M3 新增层级背景   // 不同层级的容器底色（M3 引入）
print(cs.error);                                 // 错误态颜色（红色系）
```

### 16.3 在 Widget 中使用主题

```dart
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context);                // 拿当前主题
  final cs = theme.colorScheme;                   // 调色板
  final tt = theme.textTheme;                     // 字体阶梯
  return Container(
    color: cs.surfaceContainerHigh,               // 用主题色，避免硬编码
    child: Text('标题', style: tt.titleLarge?.copyWith(color: cs.primary)),  // copyWith：在原样式上叠加颜色
  );
}
```

第 43–46 节会展开主题体系、暗黑模式与 ThemeExtension。

---

## 17. 动画：隐式 / 显式 / Hero

### 17.1 隐式动画（最简单）

属性变化自动过渡：

```dart
class ColorBox extends StatefulWidget {           // 演示隐式动画：点击切换尺寸 + 颜色
  const ColorBox({super.key});
  @override
  State<ColorBox> createState() => _ColorBoxState();
}

class _ColorBoxState extends State<ColorBox> {
  bool big = false;                               // 大小切换标志

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => big = !big),    // 点击切换 big
      child: AnimatedContainer(                   // 隐式动画：属性变化时自动过渡
        duration: const Duration(milliseconds: 300),  // 动画时长
        curve: Curves.easeInOut,                  // 缓动曲线
        width: big ? 200 : 100,                   // 属性变化时由 framework 插值过渡
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
class PulseDot extends StatefulWidget {           // 显式动画示例：脉冲红点
  const PulseDot({super.key});
  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot> with SingleTickerProviderStateMixin {  // mixin 提供 vsync
  late final AnimationController _controller;     // 动画控制器：管理动画时长、播放、暂停
  late final Animation<double> _scale;            // 派生的缩放动画值（1.0 → 1.5）

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(            // 创建控制器
      vsync: this,                                // 同步到屏幕刷新（Ticker），不可见时停止避免空跑
      duration: const Duration(seconds: 1),       // 单次动画 1s
    )..repeat(reverse: true);                     // 级联：start 后 reverse 来回循环
    _scale = Tween(begin: 1.0, end: 1.5).animate( // Tween 定义起止值
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),  // 应用缓动曲线
    );
  }

  @override
  void dispose() {
    _controller.dispose();                        // 必须释放，否则 Ticker 一直跑（DevTools 会报警）
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(                       // 用 *Transition 系列消费 Animation
      scale: _scale,                              // 把 _scale 应用到 child
      child: Container(width: 20, height: 20, decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle)),
    );
  }
}
```

### 17.3 Hero：跨页面共享元素动画

```dart
// A 页：
Hero(tag: 'avatar-${user.id}', child: CircleAvatar(...))  // tag 必须在两页都唯一且一致

// B 页同样的 tag：
Hero(tag: 'avatar-${user.id}', child: CircleAvatar(radius: 80, ...))  // 同 tag → 自动跨页面动画过渡
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
GestureDetector(                                  // 万能手势识别；不带视觉效果（涟漪、按压）
  onTap: () => print('单击'),                    // 按下并抬起
  onDoubleTap: () => print('双击'),
  onLongPress: () => print('长按'),
  onPanStart: (d) => print('拖拽开始 ${d.localPosition}'),  // 拖动开始；d 含坐标
  onPanUpdate: (d) => print('拖拽中 ${d.delta}'),  // 拖动持续；d.delta 是本次帧的位移
  onPanEnd: (d) => print('拖拽结束 ${d.velocity}'),  // 拖动结束；含速度（用于惯性滚动）
  child: Container(width: 200, height: 200, color: Colors.amber),  // 必须有可见区域才能命中
)
```

### 18.2 InkWell：带 Material 水波纹

```dart
Material(                                         // InkWell 的水波纹绘制在最近的 Material 上
  color: Colors.transparent,                      // 用透明色保证不影响视觉
  child: InkWell(                                 // 带涟漪的可点击区域
    onTap: () {},
    borderRadius: BorderRadius.circular(8),       // 涟漪与圆角配合，避免溢出边界
    splashColor: Colors.indigo.withOpacity(0.2),  // 涟漪颜色（默认是主题色的浅色）
    child: const Padding(padding: EdgeInsets.all(16), child: Text('点我')),
  ),
)
```

> ⚠️ InkWell 的水波纹必须挂在 `Material` 子树里，否则不显示。

### 18.3 拖拽 Draggable

```dart
Draggable<String>(                                // 泛型限定 data 类型
  data: 'apple',                                  // 拖拽时携带的数据
  feedback: const Material(child: Text('🍎', style: TextStyle(fontSize: 40))),  // 跟随手指的 widget
  childWhenDragging: const Opacity(opacity: 0.3, child: Text('🍎')),  // 拖拽期间原位置显示的占位
  child: const Text('🍎'),                         // 静止状态显示
)

DragTarget<String>(                               // 接收同类型 Draggable
  onAcceptWithDetails: (d) => print('收到 ${d.data}'),  // 拖到目标后回调；d.data 是 Draggable 携带的数据
  builder: (ctx, candidate, rejected) => Container(  // candidate：正悬停的；rejected：类型不符的
    width: 100, height: 100,
    color: candidate.isEmpty ? Colors.grey : Colors.green,  // 有候选时变绿，给视觉反馈
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
  runApp(const ProviderScope(child: MyApp()));    // ProviderScope 是所有 Provider 的容器（必须包在最外层）
}
```

> `ProviderScope` 是所有 provider 的容器，**只能有一个**（除非测试或局部 override）。

### 20.3 Provider：纯派生值

```dart
// 用代码生成（推荐）
import 'package:riverpod_annotation/riverpod_annotation.dart';  // 引入注解；提供 @riverpod
part 'config.g.dart';                             // part 让 build_runner 生成的代码合并到本文件

@riverpod                                         // 注解：标记下方函数为 Provider
String appName(Ref ref) => 'My Awesome App';      // 简单值 Provider；ref 用于读取其他 Provider

@riverpod
String greeting(Ref ref) {                        // 派生 Provider：基于其他 Provider 计算
  final name = ref.watch(appNameProvider);        // watch 建立依赖；appName 变 → 本 Provider 重建
  return '欢迎使用 $name';
}
```

```bash
dart run build_runner watch -d
```

UI 里消费：

```dart
class HomeView extends ConsumerWidget {           // ConsumerWidget：替代 StatelessWidget，能拿到 ref
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {  // build 多了 ref 参数（核心区别）
    final greeting = ref.watch(greetingProvider); // watch：建立依赖；Provider 变 → 当前 widget rebuild
    return Text(greeting);
  }
}
```

### 20.4 NotifierProvider：可变状态（最常用）

```dart
@riverpod
class CounterController extends _$CounterController {  // _$Foo 是生成的基类；不要手写
  @override
  int build() => 0;   // 初始值                    // build 返回初始 state；后续修改通过 state= 触发更新

  void increment() => state++;                    // state 是 Notifier 内部 setter；变化时自动通知监听者
  void decrement() => state--;
  void reset() => state = 0;
}
```

UI：

```dart
class CounterPage extends ConsumerWidget {        // 计数器页面
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(counterControllerProvider);  // 读 state；state 变 → rebuild
    return Scaffold(
      body: Center(child: Text('$count', style: const TextStyle(fontSize: 48))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.read(counterControllerProvider.notifier).increment(),  // .notifier 拿到 Notifier 实例；调方法
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 20.5 AsyncNotifierProvider：异步状态

```dart
@riverpod
class TodoList extends _$TodoList {               // 异步 Notifier：state 类型自动是 AsyncValue<List<Todo>>
  @override
  Future<List<Todo>> build() async {              // build 返回 Future → state 自动是 AsyncValue
    final api = ref.watch(apiClientProvider);     // 监听 apiClient；它变化时本 Provider 重建
    return api.fetchTodos();                      // 异步获取数据；Riverpod 自动包成 AsyncData/AsyncLoading/AsyncError
  }

  Future<void> add(String title) async {          // 业务方法
    final api = ref.read(apiClientProvider);      // 在方法里用 read（不建立依赖）
    final newTodo = await api.create(title);
    state = AsyncData([...?state.value, newTodo]);  // ...? 展开可能为 null 的旧值；新值 append
  }

  Future<void> refresh() async {
    state = const AsyncLoading();                 // 先切回 loading 态（UI 显示菊花）
    state = await AsyncValue.guard(() => ref.read(apiClientProvider).fetchTodos());  // guard 自动处理异常 → AsyncError
  }
}
```

UI 用 `AsyncValue` 模式匹配：

```dart
final asyncTodos = ref.watch(todoListProvider);   // 类型 AsyncValue<List<Todo>>

return asyncTodos.when(                           // 模式匹配三态：data / loading / error
  data: (todos) => ListView.builder(              // 成功态：拿到 List<Todo>
    itemCount: todos.length,
    itemBuilder: (_, i) => ListTile(title: Text(todos[i].title)),
  ),
  loading: () => const Center(child: CircularProgressIndicator()),  // 加载态
  error: (e, st) => Center(child: Text('出错了: $e')),  // 错误态；e=异常对象，st=堆栈
);
```

### 20.6 FutureProvider / StreamProvider（无副作用方法时简版）

```dart
@riverpod
Future<User> currentUser(Ref ref) async {         // 函数式 + Future = FutureProvider 简版
  return ref.watch(apiClientProvider).me();
}

@riverpod
Stream<int> tickStream(Ref ref) {                 // 函数式 + Stream = StreamProvider 简版
  return Stream.periodic(const Duration(seconds: 1), (i) => i);  // 每秒发一个递增数字
}
```

---

## 21. ref.watch / read / listen 三剑客

### 21.1 watch：声明依赖（在 build 里用）

```dart
final user = ref.watch(currentUserProvider);  // user 变了，build 重跑   // watch = 订阅依赖；只能在 build 内用
```

### 21.2 read：一次性读取（在事件回调里用）

```dart
ElevatedButton(
  onPressed: () {
    // ❌ 这里**禁止**用 watch；按钮回调里 watch 没意义
    ref.read(counterControllerProvider.notifier).increment();  // read = 一次性读取，不订阅
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
  ref.listen<AsyncValue<User?>>(authProvider, (prev, next) {  // listen 在 build 内调用；用于副作用
    next.whenOrNull(                              // whenOrNull：不要求覆盖所有分支
      error: (e, _) {                             // 只关心 error
        ScaffoldMessenger.of(context).showSnackBar(  // 副作用：弹 SnackBar（不能放 build 主体里）
          SnackBar(content: Text('登录失败: $e')),
        );
      },
    );
    if (next.value != null && prev?.value == null) {  // 由 null 变为有值 → 登录成功
      // 登录成功 → 跳首页
      context.go('/home');                        // 副作用：导航
    }
  });

  return ...;                                     // build 主体仍返回 widget 树
}
```

### 21.4 select：精确依赖（性能优化）

```dart
// 整个 user 对象任何字段变都会 rebuild → 浪费
final user = ref.watch(currentUserProvider);      // 即使只用了 user.name，age 变也会 rebuild

// 只关心 nickname
final nickname = ref.watch(currentUserProvider.select((u) => u.value?.nickname));  // select 后只在 nickname 变化时 rebuild
```

---

## 22. AsyncValue 与异步状态

`AsyncValue<T>` 是 `sealed` 类型（loading / data / error）。

### 22.1 三种构造

```dart
const AsyncLoading<int>();                        // 加载中：还没拿到值
const AsyncData(42);                              // 成功：携带具体值
AsyncError<int>(Exception('网络错'), StackTrace.current);  // 失败：携带异常 + 堆栈
```

### 22.2 模式匹配（Dart 3）

```dart
String render(AsyncValue<List<Todo>> v) => switch (v) {  // switch 表达式（Dart 3）+ sealed AsyncValue
  AsyncData(:final value) => '${value.length} 条',  // :final value 是字段解构语法
  AsyncLoading() => '加载中...',
  AsyncError(:final error) => '出错: $error',
  _ => '',                                        // 兜底分支（Riverpod 内部还有 AsyncRefreshing 等）
};
```

### 22.3 .when 风格

```dart
v.when(                                           // .when 必须覆盖三态；类型安全
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
state = await AsyncValue.guard(() async {         // guard 自动 try/catch；返回 AsyncValue
  final res = await api.fetchTodos();
  return res;                                     // 成功 → AsyncData(res)；抛异常 → AsyncError
});
// 不需要 try / catch，异常自动进入 AsyncError
```

---

## 23. autoDispose / family / scope

### 23.1 autoDispose：无人监听时自动销毁

```dart
@riverpod
Future<Article> article(Ref ref, String id) async {  // 第二个参数 id 自动变成 family 参数
  // 函数式 provider 默认是 autoDispose（generator 风格）
  return ref.watch(apiClientProvider).fetchArticle(id);  // 没人 watch 时 30s 后自动销毁缓存
}
```

页面退出后无人 watch，**provider 自动销毁，缓存释放**。再进入会重新 build。

想保留缓存？用 `keepAlive`：

```dart
@Riverpod(keepAlive: true)                        // 注解参数：keepAlive=true 表示永不销毁
Future<List<Category>> categories(Ref ref) async {  // 适合"全局缓存型"数据（分类列表、用户配置）
  return ref.watch(apiClientProvider).fetchCategories();
}
```

### 23.2 family：参数化 provider

代码生成模式下，函数加参数即可：

```dart
@riverpod
Future<Article> article(Ref ref, String id) async {  // 函数加额外参数 → 自动是 family
  return ref.watch(apiClientProvider).fetchArticle(id);
}

// 使用
final a = ref.watch(articleProvider('a-001'));    // 不同参数对应不同 Provider 实例（独立缓存）
```

不同 id 是不同的 provider 实例，各自独立。

### 23.3 scope：局部覆盖

```dart
ProviderScope(                                    // 测试 / 局部场景：用 override 替换 Provider 实现
  overrides: [
    articleProvider('a-001').overrideWith((ref) => Future.value(mockArticle)),  // 让 article(a-001) 返回固定 mock
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
@immutable                                        // 注解：声明为不可变（编辑器会提醒避免 setter）
class Todo {
  final String id;                                // 唯一 id；用于列表 Key、删除定位
  final String title;                             // 文案
  final bool done;                                // 完成态
  const Todo({required this.id, required this.title, this.done = false});

  Todo copyWith({String? title, bool? done}) =>   // 不可变对象的常见模式：复制并修改部分字段
      Todo(id: id, title: title ?? this.title, done: done ?? this.done);  // 未传保留原值
}

// 2. Repository（这里用内存模拟，真实场景接 Hive / API）
class TodoRepo {
  final _store = <Todo>[];                        // 内存存储；生产替换为持久化
  Future<List<Todo>> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 300));  // 模拟网络/IO 延迟
    return List.unmodifiable(_store);             // 返回不可变列表，防止外部修改内部
  }

  Future<Todo> create(String title) async {
    final t = Todo(id: DateTime.now().microsecondsSinceEpoch.toString(), title: title);  // 用时间戳作 id（demo 够用）
    _store.add(t);
    return t;
  }

  Future<void> toggle(String id) async {
    final i = _store.indexWhere((e) => e.id == id);  // 找到位置；未找到返回 -1
    if (i != -1) _store[i] = _store[i].copyWith(done: !_store[i].done);  // 用 copyWith 替换
  }

  Future<void> remove(String id) async {
    _store.removeWhere((e) => e.id == id);
  }
}

@Riverpod(keepAlive: true)                        // 单例 Repository（应用生命周期内共享）
TodoRepo todoRepo(Ref ref) => TodoRepo();

// 3. 状态层
@riverpod
class TodosController extends _$TodosController {  // 异步 Notifier：state 是 AsyncValue<List<Todo>>
  @override
  Future<List<Todo>> build() async {
    return ref.watch(todoRepoProvider).fetchAll();  // 初始加载；watch repo 让其变化时自动 rebuild
  }

  Future<void> add(String title) async {
    state = const AsyncLoading();                 // 切到 loading 态
    state = await AsyncValue.guard(() async {     // guard 自动 try/catch
      await ref.read(todoRepoProvider).create(title);
      return ref.read(todoRepoProvider).fetchAll();  // 拿最新列表覆盖 state
    });
  }

  Future<void> toggle(String id) async {
    // 乐观更新：先改 state，失败回滚
    final prev = state.value ?? [];               // 保存当前数据用于回滚
    state = AsyncData([                           // 立刻更新 UI（响应快）
      for (final t in prev)                       // 集合 for 表达式（Dart 3）
        if (t.id == id) t.copyWith(done: !t.done) else t,  // 命中则切换 done，否则原样保留
    ]);
    try {
      await ref.read(todoRepoProvider).toggle(id);  // 真正持久化
    } catch (e, st) {
      state = AsyncData(prev);  // 回滚
      state = AsyncError(e, st);                  // 紧接着切到 error，UI 可显示错误
    }
  }

  Future<void> remove(String id) async {
    final prev = state.value ?? [];
    state = AsyncData(prev.where((t) => t.id != id).toList());  // 立刻在 UI 上去掉
    await ref.read(todoRepoProvider).remove(id);  // 后续异步落库
  }
}

// 4. 派生状态
@riverpod
int undoneCount(Ref ref) {                        // 派生 Provider：基于 todos 计算未完成数
  return ref.watch(todosControllerProvider).maybeWhen(
        data: (list) => list.where((t) => !t.done).length,  // 只在 data 态计数
        orElse: () => 0,                          // loading/error 态显示 0
      );
}

// 5. UI
class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncTodos = ref.watch(todosControllerProvider);  // 监听异步 todos
    final undone = ref.watch(undoneCountProvider); // 监听派生计数

    return Scaffold(
      appBar: AppBar(title: Text('待办（剩 $undone）')),
      body: asyncTodos.when(                      // 三态分支
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('错误: $e')),
        data: (todos) => ListView.builder(
          itemCount: todos.length,
          itemBuilder: (_, i) {
            final t = todos[i];
            return Dismissible(                   // 滑动删除控件
              key: ValueKey(t.id),                // 必须有 key（Dismissible 强制要求）
              onDismissed: (_) => ref.read(todosControllerProvider.notifier).remove(t.id),  // 滑出后业务删除
              child: CheckboxListTile(            // 自带复选框 + 文本的列表项
                value: t.done,
                title: Text(t.title, style: t.done ? const TextStyle(decoration: TextDecoration.lineThrough) : null),  // 完成则中划线
                onChanged: (_) => ref.read(todosControllerProvider.notifier).toggle(t.id),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = await showDialog<String>(context: context, builder: (_) => const _AddTodoDialog());  // 弹对话框拿输入
          if (title != null && title.trim().isNotEmpty) {  // 校验非空
            await ref.read(todosControllerProvider.notifier).add(title.trim());
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _AddTodoDialog extends StatefulWidget {     // 输入框对话框
  const _AddTodoDialog();
  @override
  State<_AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<_AddTodoDialog> {
  final _ctl = TextEditingController();           // 输入控制器
  @override
  void dispose() {
    _ctl.dispose();                               // 释放控制器
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('新建待办'),
      content: TextField(controller: _ctl, autofocus: true),  // 自动聚焦，弹键盘
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),  // pop 不带值 → null
        FilledButton(onPressed: () => Navigator.pop(context, _ctl.text), child: const Text('添加')),  // pop 带文本
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
class Bad extends ConsumerStatefulWidget {...}    // ConsumerStatefulWidget：StatefulWidget + ref
class _BadState extends ConsumerState<Bad> {
  @override
  void initState() {
    super.initState();
    final user = ref.watch(userProvider);  // ❌ 报错  // initState 中不能 watch（依赖追踪未就绪）
  }
}

// ✅
@override
void initState() {
  super.initState();
  ref.listenManual(userProvider, (p, n) { ... });  // 用 listenManual   // 手动订阅；State 销毁时自动取消
}
```

**陷阱 2：在 Notifier 里直接 ref.watch 触发循环**

```dart
@riverpod
class Bad extends _$Bad {
  @override
  int build() {
    ref.watch(otherProvider);  // ✅ 没问题，依赖发生变化时 build 会重跑   // build 中 watch = 建立依赖
    return 0;
  }

  void doSomething() {
    final v = ref.watch(otherProvider);  // ❌ 在方法里用 watch，没意义   // 方法里要 read，不能订阅
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
final _router = GoRouter(                         // 顶级 router 实例；通常放在 Provider/全局
  initialLocation: '/',                           // 启动初始路径
  routes: [                                       // 路由表（树形）
    GoRoute(
      path: '/',                                  // 根路径
      builder: (_, __) => const HomePage(),       // builder 创建对应页面；两个参数：context, state
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginPage(),
    ),
    GoRoute(
      path: '/article/:id',     // 路径参数        // :id 是路径变量，可在 builder 取
      builder: (ctx, state) {
        final id = state.pathParameters['id']!;   // 从 state 拿路径参数；非空断言（路径已含 :id 必有值）
        return ArticlePage(id: id);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(                    // 路由模式 App；不是 home/routes 那套
      routerConfig: _router,                      // 关联 GoRouter
      title: 'demo',
    );
  }
}
```

### 27.2 跳转 API

```dart
context.go('/login');                          // 替换栈   // 用于"页面级"导航；URL 同步刷新
context.push('/article/123');                  // 入栈     // 保留上一页，可以 pop 回去
context.pushReplacement('/home');              // 替换当前  // 当前页被替换；不能 pop 回原来
context.pop();                                 // 返回     // 出栈到上一页
context.pop(true);                             // 返回带值  // 给上一页 push 的 await 返回值
context.go('/article/123?from=home');          // 查询参数  // ?from=home 通过 queryParameters 取
state.uri.queryParameters['from'];             // 读取     // builder 中拿当前 URL 的查询参数
```

### 27.3 命名路由（推荐）

```dart
GoRoute(
  name: 'article',                                // 给路由起名；调用方按名跳，不依赖路径字符串
  path: '/article/:id',
  builder: (ctx, state) => ArticlePage(id: state.pathParameters['id']!),
),

context.goNamed('article', pathParameters: {'id': '123'});  // 按名跳转 + 传参；路径变了不需改调用代码
```

---

## 28. 嵌套路由 / Shell / Tab

底部 Tab + 每个 Tab 各自的导航栈，是 App 最常见的形态。go_router 用 `StatefulShellRoute.indexedStack` 一招制胜。

```dart
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');  // 每个 Tab 一个 Navigator key（用于独立栈）
final _shellNavigatorMineKey = GlobalKey<NavigatorState>(debugLabel: 'mine');  // debugLabel 在调试树里显示

final _router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(              // 多 Tab 共存的"shell"路由；每 Tab 独立栈
      builder: (ctx, state, navigationShell) {    // 顶层 shell 的 builder；提供 navigationShell 给底栏
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [                                 // 每个 branch 对应一个 Tab
        StatefulShellBranch(
          navigatorKey: _shellNavigatorHomeKey,   // 此 Tab 的 Navigator key
          routes: [
            GoRoute(
              path: '/home',
              builder: (_, __) => const HomePage(),
              routes: [                           // 嵌套子路由：在该 Tab 内 push
                GoRoute(
                  path: 'detail/:id',             // 全路径会是 /home/detail/:id
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
  final StatefulNavigationShell navigationShell;  // 由 shell builder 注入；包含当前 Tab 索引和切换方法
  const MainScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,                      // body 直接用 shell（内部是 IndexedStack 保持每 Tab 状态）
      bottomNavigationBar: NavigationBar(         // M3 风格底部导航条
        selectedIndex: navigationShell.currentIndex,  // 受控：当前选中 Tab 索引
        onDestinationSelected: (i) => navigationShell.goBranch(  // 切换 Tab
          i,
          // 同 tab 再次点击时回到根
          initialLocation: i == navigationShell.currentIndex,  // true = 重新进入 Tab 根（清子页面）
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
  redirect: (ctx, state) {                        // 全局守卫：每次跳转前都会调用
    final container = ProviderScope.containerOf(ctx);  // 在 router 中拿 ProviderContainer 读 Provider
    final loggedIn = container.read(authProvider).valueOrNull != null;  // 是否已登录
    final goingToLogin = state.matchedLocation == '/login';  // 目的地是不是 /login

    if (!loggedIn && !goingToLogin) return '/login';  // 未登录 + 非登录页 → 强制去登录页
    if (loggedIn && goingToLogin) return '/home';     // 已登录 + 还想去登录页 → 跳首页
    return null; // 不重定向                          // null = 放行
  },
);
```

### 29.2 单条路由守卫

```dart
GoRoute(
  path: '/admin',
  redirect: (ctx, st) {                           // 单条路由的守卫；只在进入此路由时调用
    final container = ProviderScope.containerOf(ctx);
    final isAdmin = container.read(currentUserProvider).valueOrNull?.isAdmin ?? false;  // 链式 + null 安全
    return isAdmin ? null : '/forbidden';         // 非管理员跳禁止访问
  },
  builder: (_, __) => const AdminPage(),
),
```

### 29.3 与 Riverpod 联动：refreshListenable

登录态变化时让 router 重新 evaluate redirect：

```dart
final routerProvider = Provider<GoRouter>((ref) { // 把 router 暴露成 Provider，可在 Widget 里 watch
  final notifier = GoRouterRefreshStream(ref.watch(authStreamProvider.stream));  // 把 Riverpod Stream 包成 Listenable
  ref.onDispose(notifier.dispose);                // Provider 销毁时释放 notifier

  return GoRouter(
    refreshListenable: notifier,                  // 关键：notifier 变化 → router 重新跑 redirect
    routes: [...],
    redirect: (ctx, state) {...},
  );
});

class GoRouterRefreshStream extends ChangeNotifier {  // 把 Stream → ChangeNotifier 适配
  late final StreamSubscription<dynamic> _sub;
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _sub = stream.listen((_) => notifyListeners());  // Stream 任意事件都触发监听者刷新
  }
  @override
  void dispose() {
    _sub.cancel();                                // 取消订阅，避免泄漏
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

part 'routes.g.dart';                             // build_runner 把生成代码 part 进来

@TypedGoRoute<ArticleRoute>(path: '/article/:id') // 注解：声明这是一个类型安全路由，自动生成模板
class ArticleRoute extends GoRouteData {          // 继承 GoRouteData 把路由参数变成类字段
  final String id;                                // 路径参数；与 :id 同名自动绑定
  final String? from;                             // 查询参数；类型可空
  const ArticleRoute({required this.id, this.from});

  @override
  Widget build(BuildContext ctx, GoRouterState state) =>
      ArticlePage(id: id, from: from);            // 直接用类字段，不再 pathParameters['id']!
}

// 用法（编译期检查）
const ArticleRoute(id: '123', from: 'home').go(context);  // 类型安全；写错字段名编译失败
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
final dio = Dio(BaseOptions(                      // Dio 实例；BaseOptions 是默认配置
  baseUrl: 'https://api.example.com',             // 所有相对路径都会拼到这个前缀
  connectTimeout: const Duration(seconds: 10),    // 建立连接超时
  receiveTimeout: const Duration(seconds: 15),    // 接收响应超时
  headers: {'Accept': 'application/json'},        // 默认请求头
));

// GET
final res = await dio.get('/posts', queryParameters: {'page': 1});  // 自动拼成 ?page=1
final list = (res.data as List).cast<Map<String, dynamic>>();  // 把动态 List 强转为 Map 列表

// POST
final res2 = await dio.post('/posts', data: {'title': 'hello', 'body': '...'});  // data 默认按 JSON 序列化

// 上传文件
final form = FormData.fromMap({                   // multipart/form-data
  'file': await MultipartFile.fromFile('/path/to/img.jpg', filename: 'img.jpg'),  // 文件字段
  'name': '头像',                                  // 普通字段
});
await dio.post('/upload', data: form);            // Content-Type 自动改为 multipart

// 下载文件 + 进度
await dio.download(                               // 流式下载到本地
  'https://example.com/big.zip',
  '/path/to/save.zip',
  onReceiveProgress: (rec, total) {               // 进度回调；total=-1 表示服务器没给 content-length
    if (total != -1) print('${(rec / total * 100).toStringAsFixed(0)}%');
  },
);

// 取消
final token = CancelToken();                      // 取消令牌
dio.get('/slow', cancelToken: token);             // 把 token 传给请求
token.cancel('用户取消');                          // 触发取消，请求会抛 cancel 异常
```

---

## 33. 拦截器：日志 / Token / 错误

### 33.1 日志拦截器（开发期）

```dart
dio.interceptors.add(LogInterceptor(              // Dio 自带日志；调试用
  requestBody: true,                              // 是否打印请求体
  responseBody: true,                             // 是否打印响应体
));

// 更花哨的：
// flutter pub add pretty_dio_logger
// dio.interceptors.add(PrettyDioLogger(...));    // 第三方更易读，含 emoji 分组
```

### 33.2 Token 注入

```dart
dio.interceptors.add(InterceptorsWrapper(         // Wrapper 是闭包式的拦截器
  onRequest: (options, handler) async {           // 每次发请求前调用
    final token = await secureStorage.read(key: 'token');  // 读 token（异步）
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';  // 注入 Bearer Token
    }
    handler.next(options);                        // 继续处理；不调 next 会卡死
  },
));
```

### 33.3 统一错误转换

```dart
sealed class AppError implements Exception {     // sealed：限定子类只能在本文件，配合 switch 穷尽
  final String message;
  const AppError(this.message);
}

class NetworkError extends AppError {             // 网络层错误（超时 / 不通）
  const NetworkError(super.message);              // 转发构造参数给父类
}

class UnauthorizedError extends AppError {        // 401 未授权
  const UnauthorizedError() : super('未登录或登录已过期');  // 固定消息
}

class ServerError extends AppError {              // 业务/服务端错误
  final int statusCode;                           // 携带 HTTP 状态码
  const ServerError(this.statusCode, String msg) : super(msg);
}

dio.interceptors.add(InterceptorsWrapper(
  onError: (err, handler) {                       // 错误时调用；err 是 DioException
    final mapped = _mapDioError(err);             // 转成业务侧统一错误
    handler.reject(DioException(                  // reject = 把错误继续抛出给调用方
      requestOptions: err.requestOptions,
      error: mapped,            // ★ 把统一的 AppError 塞回去   // 调用方 catch 时 e.error 就是 AppError
      message: mapped.message,
    ));
  },
));

AppError _mapDioError(DioException e) {           // DioException → AppError 映射
  switch (e.type) {
    case DioExceptionType.connectionTimeout:      // 多个 case 共用一段处理
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return const NetworkError('网络超时');
    case DioExceptionType.connectionError:
      return const NetworkError('网络不可用');
    case DioExceptionType.badResponse:            // HTTP 4xx / 5xx
      final code = e.response?.statusCode ?? 0;
      if (code == 401) return const UnauthorizedError();
      return ServerError(code, e.response?.data?['message']?.toString() ?? '服务异常');
    case DioExceptionType.cancel:                 // 主动取消
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
class AuthInterceptor extends Interceptor {       // 完整的 401 自动刷新拦截器
  final Dio _dio;                                 // 引用 Dio 实例用于重发
  final Future<String?> Function() _refresh;      // 刷新 token 的函数（注入）；返回新 token 或 null
  bool _isRefreshing = false;                     // 是否正在刷新（互斥锁）
  final List<_Pending> _queue = [];               // 刷新期间挂起的请求队列

  AuthInterceptor(this._dio, this._refresh);

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) return handler.next(err);  // 非 401 → 原样抛出

    // 已经在刷新，把当前请求挂起
    if (_isRefreshing) {
      _queue.add(_Pending(err.requestOptions, handler));  // 入队等待
      return;                                     // 不调 next/resolve/reject，请求处于挂起态
    }

    _isRefreshing = true;                         // 锁住
    try {
      final newToken = await _refresh();          // 调刷新 API
      if (newToken == null) {
        // 刷新失败：抛 401 出去，让上层去登录页
        return handler.next(err);                 // 把 401 继续抛出
      }
      // 重发原请求
      final retried = await _retry(err.requestOptions, newToken);
      handler.resolve(retried);                   // resolve = 把成功响应返回给调用方
      // 重发队列里的请求
      for (final p in _queue) {
        try {
          final r = await _retry(p.options, newToken);
          p.handler.resolve(r);                   // 队列里每个请求各自 resolve
        } catch (e) {
          p.handler.reject(e is DioException ? e : DioException(requestOptions: p.options));  // 失败的就 reject
        }
      }
    } catch (e) {
      handler.next(err);                          // 整体出错就放过原 err
    } finally {
      _queue.clear();                             // 清空队列
      _isRefreshing = false;                      // 解锁，下次 401 重新刷新
    }
  }

  Future<Response> _retry(RequestOptions opt, String newToken) {
    final clone = opt.copyWith(                   // 复制原请求；不能直接改原 options（已被 reject 状态）
      headers: {...opt.headers, 'Authorization': 'Bearer $newToken'},  // 替换为新 token
    );
    return _dio.fetch(clone);                     // fetch = 用配置项发请求
  }
}

class _Pending {                                  // 挂起请求记录
  final RequestOptions options;                   // 原请求配置
  final ErrorInterceptorHandler handler;          // 原 handler（用来 resolve / reject）
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
    final res = await _dio.get(path, queryParameters: query);  // 发请求
    return decoder != null ? decoder(res.data) : res.data as T;  // 有解码器走解码器；没有则强转
  }

  Future<T> post<T>(String path, {Object? body, T Function(Object?)? decoder}) async {
    final res = await _dio.post(path, data: body);
    return decoder != null ? decoder(res.data) : res.data as T;
  }
}

// 2. 实体
class Article {                                   // 业务实体；与 API 字段一一对应
  final String id;
  final String title;
  final String content;
  Article({required this.id, required this.title, required this.content});

  factory Article.fromJson(Map<String, dynamic> j) =>  // 工厂构造：从 JSON Map 构造对象
      Article(id: j['id'] as String, title: j['title'] as String, content: j['content'] as String);
}

// 3. Repository（数据层抽象）
abstract interface class ArticleRepository {       // abstract interface = 纯接口（Dart 3 关键字）
  Future<List<Article>> list({int page = 1});
  Future<Article> detail(String id);
}

class ArticleRepositoryImpl implements ArticleRepository {  // 接口实现
  final RestClient _client;
  ArticleRepositoryImpl(this._client);

  @override
  Future<List<Article>> list({int page = 1}) async {
    return _client.get<List<Article>>(            // 泛型指定返回类型
      '/articles',
      query: {'page': page},
      decoder: (raw) =>                           // 把动态 JSON 转成 List<Article>
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
Dio dio(Ref ref) {                                // Dio 单例
  final dio = Dio(BaseOptions(baseUrl: 'https://api.example.com'));
  dio.interceptors.addAll([                       // 一次添加多个拦截器
    AuthInterceptor(dio, () => ref.read(authControllerProvider.notifier).refresh()),  // 把刷新方法注入
    LogInterceptor(),
  ]);
  return dio;
}

@Riverpod(keepAlive: true)
RestClient restClient(Ref ref) => RestClient(ref.watch(dioProvider));  // 依赖 dio

@Riverpod(keepAlive: true)
ArticleRepository articleRepo(Ref ref) => ArticleRepositoryImpl(ref.watch(restClientProvider));  // 依赖 client
```

---

## 36. Mock 与离线开发

### 36.1 拦截器层 Mock

```dart
class MockInterceptor extends Interceptor {       // 拦截器层 mock：不让请求出网，直接造响应
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path == '/articles') {            // 命中目标路径
      return handler.resolve(Response(            // resolve = 直接返回响应（不走真实网络）
        requestOptions: options,
        statusCode: 200,
        data: List.generate(20, (i) => {'id': '$i', 'title': '文章$i', 'content': '...'}),  // 造 20 条假数据
      ));
    }
    handler.next(options);                        // 未命中：交给下一个拦截器/真实请求
  }
}

// 仅在 dev 环境注入
if (kDebugMode) dio.interceptors.add(MockInterceptor());  // kDebugMode 是 dart:foundation 提供的常量
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
final sp = await SharedPreferences.getInstance(); // 单例；读取磁盘文件 → 内存缓存
await sp.setString('name', '小新');                // 异步写；底层是 Android SharedPreferences / iOS NSUserDefaults
await sp.setInt('age', 5);
await sp.setBool('dark', true);

final name = sp.getString('name');                // 同步读（已在内存）；类型不匹配返回 null
await sp.remove('name');                          // 异步删除
```

封装：

```dart
@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPrefs(Ref ref) => SharedPreferences.getInstance();  // 整个 App 复用一份 SP

@riverpod
class ThemeMode_ extends _$ThemeMode_ {           // 主题模式 Notifier；尾下划线避免与 Flutter 内置同名冲突
  @override
  Future<ThemeMode> build() async {
    final sp = await ref.watch(sharedPrefsProvider.future);  // .future 拿到 Future<T>，await 解包
    return _parse(sp.getString('theme'));         // 从 SP 读字符串，转 enum
  }

  Future<void> set(ThemeMode m) async {
    final sp = await ref.read(sharedPrefsProvider.future);  // 方法里用 read（不订阅）
    await sp.setString('theme', m.name);          // m.name 是枚举值的字符串名（'dark' / 'light' / 'system'）
    state = AsyncData(m);                         // 同步更新 state，UI 立刻刷新
  }

  ThemeMode _parse(String? s) => switch (s) {     // switch 表达式 + 字符串模式
    'dark' => ThemeMode.dark,
    'light' => ThemeMode.light,
    _ => ThemeMode.system,                        // null 或其他 → 跟随系统
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
@HiveType(typeId: 0)                              // typeId 必须全 App 唯一；不可改（已存数据要兼容）
class Article {
  @HiveField(0) final String id;                  // 字段编号；新增字段必须递增、不可重排
  @HiveField(1) final String title;
  @HiveField(2) final DateTime savedAt;
  Article({required this.id, required this.title, required this.savedAt});
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();      // 异步用 Flutter API 前必须调
  await Hive.initFlutter();                       // 初始化 Hive，自动选好存储目录
  Hive.registerAdapter(ArticleAdapter());         // 注册 build_runner 生成的 Adapter（序列化）
  await Hive.openBox<Article>('articles');        // 打开 box（≈ 表）；后续可直接同步读取
  runApp(const MyApp());
}

// 使用
final box = Hive.box<Article>('articles');        // 同步拿已打开的 box
await box.put('a-001', Article(id: 'a-001', title: '...', savedAt: DateTime.now()));  // KV 写
final a = box.get('a-001');                       // KV 读；同步
final all = box.values.toList();                  // 拿所有值
await box.delete('a-001');

// 监听变化（自动 UI 刷新）
ValueListenableBuilder(                            // 把 Listenable 接到 widget；变化触发 builder
  valueListenable: box.listenable(),               // box 变 → 通知
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
@collection                                       // 注解：Isar Collection（≈ 表）；触发代码生成
class Note {
  Id id = Isar.autoIncrement;                     // 主键；autoIncrement 让 Isar 自动分配

  @Index(type: IndexType.value, caseSensitive: false)  // 建索引；value 类型支持精确 + 前缀查询
  late String title;

  late String content;

  @Index()                                        // 默认索引；按时间排序
  late DateTime updatedAt;
}

// 初始化
final dir = await getApplicationDocumentsDirectory();  // 拿 App 私有目录
final isar = await Isar.open([NoteSchema], directory: dir.path);  // 打开 DB；NoteSchema 由代码生成

// 写
await isar.writeTxn(() async {                    // 必须在事务里写
  await isar.notes.put(Note()..title = '标题'..content = '内容'..updatedAt = DateTime.now());  // ..级联给字段赋值
});

// 查
final results = await isar.notes                  // 链式查询 API
    .filter()                                     // 进入过滤构建器
    .titleContains('Flutter', caseSensitive: false)  // 标题包含；不分大小写
    .sortByUpdatedAtDesc()                        // 按 updatedAt 倒序
    .limit(20)                                    // 最多 20 条
    .findAll();                                   // 异步执行
```

---

## 41. Drift（SQL）

> Drift 基于 SQLite，提供完整 SQL 表达能力 + 类型安全的 Dart API + 编译期校验。

```bash
flutter pub add drift drift_flutter sqlite3_flutter_libs
flutter pub add --dev drift_dev build_runner
```

```dart
class Articles extends Table {                    // 表定义；继承 drift 的 Table
  IntColumn get id => integer().autoIncrement()();         // INT 自增主键；()() 是 drift 风格——返回的是表达式
  TextColumn get title => text().withLength(min: 1, max: 200)();  // VARCHAR；带长度约束
  TextColumn get content => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();  // 默认值：现在
  BoolColumn get favorited => boolean().withDefault(const Constant(false))();    // 默认 false
}

@DriftDatabase(tables: [Articles])                // 注解：声明这是数据库
class AppDatabase extends _$AppDatabase {         // _$AppDatabase 由 build_runner 生成
  AppDatabase() : super(_openConnection());       // 传入数据库连接（实现略）
  @override
  int get schemaVersion => 1;                     // 版本号；改表结构需 +1 + 写迁移

  Future<List<Article>> allArticles() => select(articles).get();  // 查全部；类型安全的 SQL DSL
  Stream<List<Article>> watchFavorites() =>       // .watch() 返回 Stream，数据变 → 自动推
      (select(articles)..where((t) => t.favorited)).watch();
  Future<int> addArticle(ArticlesCompanion entry) => into(articles).insert(entry);  // 插入；返回新 id
}
```

---

## 42. flutter_secure_storage（安全存储）

```bash
flutter pub add flutter_secure_storage
```

```dart
final storage = const FlutterSecureStorage(       // 加密存储；底层 iOS Keychain / Android Keystore
  aOptions: AndroidOptions(encryptedSharedPreferences: true),  // Android 用加密 SP（替代旧 Keystore）
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device),  // 首次解锁后可读
);

await storage.write(key: 'token', value: 'eyJ...');  // 异步写
final token = await storage.read(key: 'token');      // 异步读；返回 String?
await storage.delete(key: 'token');
```

> ⚠️ 不要在 secure_storage 里存大量数据，性能差。它是给"敏感小数据"准备的。

---

# Part 8 · 主题与暗黑模式

## 43. ThemeData / ColorScheme / Material 3

### 43.1 一份完整的主题定义

```dart
ThemeData buildLightTheme() {                     // 工厂函数，便于复用 + 写测试
  final colorScheme = ColorScheme.fromSeed(       // 派生整套调色板
    seedColor: const Color(0xFF6750A4),           // 种子色（M3 紫）
    brightness: Brightness.light,
  );

  return ThemeData(
    useMaterial3: true,                           // M3
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colorScheme.surface, // 全 App 默认背景

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.surface,       // 与背景色一致；M3 推荐
      foregroundColor: colorScheme.onSurface,     // 文字 + 图标颜色
      centerTitle: true,                          // 居中标题
      elevation: 0,                               // 默认无阴影
      scrolledUnderElevation: 1,                  // 内容滚动到 AppBar 下方时浮起阴影 1
    ),

    // 文字
    textTheme: const TextTheme(                   // 字体阶梯
      headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, height: 1.5),
      labelMedium: TextStyle(fontSize: 12),
    ),

    // 按钮
    filledButtonTheme: FilledButtonThemeData(     // 按钮主题：影响所有 FilledButton
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),

    // 输入框
    inputDecorationTheme: InputDecorationTheme(   // 影响所有 TextField / TextFormField
      filled: true,                               // 填充背景
      fillColor: colorScheme.surfaceContainerHighest,  // 用主题色
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,              // 无描边（靠填充色区分）
      ),
    ),

    // 卡片
    cardTheme: CardTheme(                         // 影响 Card
      elevation: 0,                               // M3 倾向 elevation 0 + 表面色
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
    final mode = ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system;  // 没值则跟随系统
    return MaterialApp.router(
      themeMode: mode,                            // 决定走 theme 还是 darkTheme
      theme: buildLightTheme(),                   // 亮色主题
      darkTheme: buildDarkTheme(),                // 暗色主题
      routerConfig: ref.watch(routerProvider),    // 路由从 Provider 拿
    );
  }
}

ThemeData buildDarkTheme() {
  final cs = ColorScheme.fromSeed(                // 用同一种子色派生暗色调色板
    seedColor: const Color(0xFF6750A4),
    brightness: Brightness.dark,                  // 关键差异
  );
  return ThemeData(useMaterial3: true, colorScheme: cs, brightness: Brightness.dark);
}
```

切换 UI：

```dart
SegmentedButton<ThemeMode>(                       // M3 分段按钮；多选项互斥切换
  segments: const [
    ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.brightness_auto)),
    ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode)),
    ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode)),
  ],
  selected: {mode},                               // selected 是 Set；单选传单元素 Set
  onSelectionChanged: (s) => ref.read(themeModeProvider.notifier).set(s.first),  // s 也是 Set
)
```

---

## 45. ThemeExtension：自定义主题字段

ThemeData 没有的字段（业务自定义颜色、间距），用 ThemeExtension：

```dart
@immutable
class AppPalette extends ThemeExtension<AppPalette> {  // 自定义主题字段；继承 ThemeExtension
  final Color success;                            // 业务自定义颜色；ThemeData 没有
  final Color warning;
  final Color price;

  const AppPalette({required this.success, required this.warning, required this.price});

  @override
  AppPalette copyWith({Color? success, Color? warning, Color? price}) =>  // 必须实现 copyWith
      AppPalette(success: success ?? this.success, warning: warning ?? this.warning, price: price ?? this.price);

  @override
  AppPalette lerp(AppPalette? other, double t) {  // 主题切换动画的插值函数
    if (other == null) return this;
    return AppPalette(
      success: Color.lerp(success, other.success, t)!,  // 在 [0,1] 之间线性插值
      warning: Color.lerp(warning, other.warning, t)!,
      price: Color.lerp(price, other.price, t)!,
    );
  }

  static const light = AppPalette(success: Color(0xFF2E7D32), warning: Color(0xFFEF6C00), price: Color(0xFFD32F2F));  // 亮色预设
  static const dark = AppPalette(success: Color(0xFF66BB6A), warning: Color(0xFFFFA726), price: Color(0xFFEF5350));   // 暗色预设
}

// 注册
ThemeData buildLightTheme() => ThemeData(
  // ...
  extensions: const [AppPalette.light],           // 把扩展挂到主题；同 type 多次会覆盖
);

// 用
extension AppPaletteX on BuildContext {           // 给 BuildContext 加 getter，调用更顺手
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;  // 按 type 取扩展；非空断言
}

// 业务里
Text('¥99', style: TextStyle(color: context.palette.price))  // 直接用 context.palette
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
ThemeData(fontFamily: 'Inter', ...)               // 全局默认字体；与 pubspec.yaml 注册的 family 名一致
```

### 46.2 自定义图标字体

用 [fluttericon.com](https://fluttericon.com) 或 IconFont 生成 ttf + json，然后：

```dart
class MyIcons {
  static const home = IconData(0xe900, fontFamily: 'MyIcons');  // codePoint 对应字体里字形位
  static const cart = IconData(0xe901, fontFamily: 'MyIcons');
}

Icon(MyIcons.home)                                // 按 Material Icon 一样使用
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
  localizationsDelegates: AppLocalizations.localizationsDelegates,  // 系统组件本地化（按钮文字、日期格式等）
  supportedLocales: AppLocalizations.supportedLocales,  // 支持的语言列表（自动从 ARB 推导）
  locale: ref.watch(localeProvider),              // 当前语言；null 跟随系统
  ...
)

// 用
final t = AppLocalizations.of(context)!;          // 拿到当前语言的翻译对象；非空断言（已注册）
Text(t.hello('小新'))                              // 调用方法风格调用；占位符是参数
```

---

## 49. 动态切换语言

```dart
@riverpod
class Locale_ extends _$Locale_ {                 // 语言 Notifier；尾下划线避免与 dart:ui Locale 冲突
  @override
  Future<Locale?> build() async {                 // 初值：从 SP 读
    final sp = await ref.watch(sharedPrefsProvider.future);
    final code = sp.getString('locale');
    return code == null ? null : Locale(code);    // null = 跟随系统
  }

  Future<void> set(Locale? l) async {
    final sp = await ref.read(sharedPrefsProvider.future);
    if (l == null) {
      await sp.remove('locale');                  // null 时删除存储 → 下次回退跟随系统
    } else {
      await sp.setString('locale', l.languageCode);  // 持久化语言代码
    }
    state = AsyncData(l);                         // 同步更新 state
  }
}
```

---

## 50. 复数 / 占位符 / 日期格式

```dart
import 'package:intl/intl.dart';                  // 国际化格式化工具

DateFormat.yMMMd('zh').format(DateTime.now());     // 2026年4月27日   // 按 locale 输出"年月日"
NumberFormat.currency(locale: 'zh', symbol: '¥').format(1234.5);  // ¥1,234.50  // 货币格式 + 千分位
NumberFormat.compact(locale: 'zh').format(12345);  // 1.2万         // 中文短格式（compact）
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
class _MockClient extends Mock implements RestClient {}  // mocktail：继承 Mock + implements 接口 = 自动 mock

void main() {
  late _MockClient client;                        // late：在 setUp 中赋值
  late ArticleRepository repo;

  setUp(() {                                      // 每个 test 前调一次
    client = _MockClient();
    repo = ArticleRepositoryImpl(client);
  });

  test('list returns parsed articles', () async {
    when(() => client.get<List<Article>>(any(), query: any(named: 'query'), decoder: any(named: 'decoder')))  // 配 stub；any() 匹配任意值
        .thenAnswer((_) async => [Article(id: '1', title: 'A', content: '')]);  // 返回假数据

    final r = await repo.list(page: 1);
    expect(r, hasLength(1));                      // 断言长度 = 1
    expect(r.first.id, '1');
  });

  test('throws when client throws', () async {
    when(() => client.get(any())).thenThrow(const NetworkError('timeout'));  // 让 client 抛异常
    expect(() => repo.list(), throwsA(isA<NetworkError>()));  // 断言会抛 NetworkError
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
testWidgets('counter increments', (tester) async {  // testWidgets 提供 WidgetTester；可挂载 + 操作 widget
  await tester.pumpWidget(const ProviderScope(child: MaterialApp(home: CounterPage())));  // pumpWidget 渲染初始 widget

  expect(find.text('0'), findsOneWidget);         // 断言：找到一个 '0' 文本

  await tester.tap(find.byIcon(Icons.add));       // 模拟点击 + 图标
  await tester.pump();                            // 触发一次重建

  expect(find.text('1'), findsOneWidget);
});

testWidgets('shows error snackbar on save failure', (tester) async {
  await tester.pumpWidget(...);
  await tester.tap(find.text('保存'));
  await tester.pump(const Duration(seconds: 1));   // 等异步完成     // 推进时间 1s
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
import 'package:integration_test/integration_test.dart';  // 集成测试包

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();  // 集成测试 binding；连真机/模拟器

  testWidgets('login → home → logout', (tester) async {
    app.main();                                   // 启动真实 App（不是单 widget）
    await tester.pumpAndSettle();                 // 等所有动画/异步完成

    // 登录
    await tester.enterText(find.byKey(const Key('email')), 'a@b.com');  // 在邮箱输入框输入
    await tester.enterText(find.byKey(const Key('pwd')), '123456');
    await tester.tap(find.text('登录'));
    await tester.pumpAndSettle();                 // 等导航跳转 + 网络请求结束

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
  await expectLater(find.byType(MyCard), matchesGoldenFile('goldens/my_card.png'));  // 与黄金图比对像素
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
  final container = ProviderContainer();          // 单测里手动建 Container，不依赖 ProviderScope widget
  addTearDown(container.dispose);                 // 测试结束自动释放

  expect(container.read(counterControllerProvider), 0);
  container.read(counterControllerProvider.notifier).increment();
  expect(container.read(counterControllerProvider), 1);
});

testWidgets('home shows mocked todos', (tester) async {
  final fakeRepo = _FakeRepo();                   // 自己写的假实现
  await tester.pumpWidget(ProviderScope(
    overrides: [
      todoRepoProvider.overrideWithValue(fakeRepo),  // 用 override 替换 Repository
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
import 'dart:isolate';                            // Dart 标准库；Isolate 是独立内存空间的执行单元

// Flutter 3.7+ 推荐：compute / Isolate.run
final result = await Isolate.run(() {             // Isolate.run 在新 isolate 执行回调；自动销毁
  // 这里在另一个 isolate 执行，不阻塞 UI
  return _heavyParse(rawJsonString);              // CPU 密集计算放这里
});

// 简化版（旧 API，兼容）
final r = await compute(_heavyParse, rawJsonString);  // compute(顶层函数, 参数)；参数会被序列化
```

> ⚠️ Isolate 之间不共享内存，只能传 message。复杂对象会被序列化（必须可 SendPort 序列化）。

---

## 64. 图片优化与缓存

```dart
Image.network(
  url,
  cacheWidth: 200,           // 解码到 200 宽，省内存   // 解码后的位图大小；不是显示大小
  cacheHeight: 200,
)

// 生产用 cached_network_image
CachedNetworkImage(                               // 自动磁盘缓存的网络图组件
  imageUrl: url,
  memCacheWidth: 200,                             // 内存缓存解码尺寸
  fadeInDuration: const Duration(milliseconds: 200),  // 淡入动画时长
  placeholder: (_, __) => const SkeletonBox(),    // 加载占位（自定义骨架屏）
  errorWidget: (_, __, ___) => const Icon(Icons.broken_image),  // 失败显示
)
```

---

## 65. 列表性能：RepaintBoundary / itemExtent

```dart
ListView.builder(
  itemExtent: 80,           // 每项固定高 → 跳过测量，性能大幅提升  // ListView 知道每项高度，可直接定位
  itemCount: 1000,
  itemBuilder: (_, i) => RepaintBoundary(         // 把 child 隔离到独立 layer，重绘不影响兄弟
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
  static const _ch = MethodChannel('com.example/battery');  // channel 名两端必须完全一致；通常带反域名前缀避免冲突

  static Future<int> getLevel() async {
    final v = await _ch.invokeMethod<int>('getBatteryLevel');  // 调用原生方法；泛型指定返回类型
    return v ?? -1;                               // null 兜底
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
import 'package:pigeon/pigeon.dart';              // Pigeon 注解 + 类型库

class BatteryInfo {                               // 跨语言数据类；Pigeon 自动生成两端代码
  int? level;
  bool? charging;
}

@HostApi()                                        // 注解：原生侧实现，Dart 侧调用
abstract class BatteryApi {
  BatteryInfo getInfo();                          // 接口方法签名；Pigeon 据此生成两端代码
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
final api = BatteryApi();                         // 用生成的客户端类实例化
final info = await api.getInfo();                 // 调用，类型安全，IDE 自动补全
```

---

## 68. EventChannel：流式数据

适合传感器、推送、定位等持续事件。

```dart
const _ch = EventChannel('com.example/sensor');   // 不同于 MethodChannel；用于"原生 → Flutter"持续推送

Stream<double> orientationStream() =>
    _ch.receiveBroadcastStream().map((e) => (e as num).toDouble());  // 把动态事件转成强类型 Stream
```

---

## 69. FFI：调用 C/C++ 库

```bash
flutter pub add ffi
```

```dart
import 'dart:ffi';                                // Dart FFI（Foreign Function Interface）
import 'package:ffi/ffi.dart';                    // 辅助工具（字符串转换等）

typedef _NativeAdd = Int32 Function(Int32, Int32);  // C 侧函数签名（Native 类型）
typedef _DartAdd = int Function(int, int);          // Dart 侧调用签名（Dart 类型）

class NativeMath {
  static final _lib = DynamicLibrary.open('libnative.so');  // 打开动态库；iOS 改 .dylib，Win 改 .dll
  static final add = _lib.lookupFunction<_NativeAdd, _DartAdd>('add');  // 查找符号 + 类型转换
}

void main() {
  print(NativeMath.add(3, 4));                    // 跟普通 Dart 函数一样调
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
  static const env = String.fromEnvironment('ENV', defaultValue: 'dev');  // 编译期常量，--dart-define 注入
  static const apiBase = String.fromEnvironment('API_BASE');              // 不传则空字符串
  static bool get isProd => env == 'prod';                                // 派生 getter
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
abstract interface class ArticleRepository {     // 纯接口（Dart 3 abstract interface）
  Future<List<Article>> list({int page = 1});
}

class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource _remote;          // 远程数据源
  final ArticleLocalDataSource _local;            // 本地数据源（缓存）

  ArticleRepositoryImpl(this._remote, this._local);

  @override
  Future<List<Article>> list({int page = 1}) async {
    try {
      final fresh = await _remote.list(page: page);  // 优先尝试网络
      await _local.cache(fresh);                     // 成功后缓存
      return fresh;
    } on NetworkError {                              // 仅捕获网络错误
      return _local.cached(page: page);   // 离线降级   // 拿本地缓存，让用户至少有内容
    }
  }
}
```

### 78.2 Use Case：单一职责的业务动作

```dart
class LoadArticlesUseCase {                       // UseCase = 单一业务动作；便于单测
  final ArticleRepository _repo;
  LoadArticlesUseCase(this._repo);

  Future<List<Article>> call({int page = 1}) async {  // call 让对象可像函数一样调用：useCase()
    if (page < 1) throw ArgumentError('page must >= 1');  // 业务规则校验
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
  } on NetworkError catch (e) {                   // 类型化捕获：仅网络错误
    // 调用方处理
    rethrow;                                      // 不吞错，继续抛给上层
  }
}
```

### 79.2 sealed Result（推荐用于 Notifier 暴露给 UI）

```dart
sealed class Result<T> {                          // sealed：子类只能在本文件，编译器强制 switch 穷尽
  const Result();
}

class Ok<T> extends Result<T> {                   // 成功分支
  final T value;
  const Ok(this.value);
}

class Err<T> extends Result<T> {                  // 失败分支
  final AppError error;
  const Err(this.error);
}

// 业务
Future<Result<List<Article>>> safeList() async {  // 用 Result 取代抛异常
  try {
    return Ok(await _repo.list());
  } on AppError catch (e) {
    return Err(e);
  }
}

// UI
final r = await ref.read(articlesProvider.notifier).safeList();
switch (r) {                                      // sealed + switch：编译期检查所有分支已覆盖
  case Ok(:final value): showList(value);         // 字段解构，拿到 value
  case Err(:final error): showError(error);
}
```

> 第三方库 `dartz` / `fpdart` 提供 Either，更函数式。Riverpod 项目里直接用 `AsyncValue` 也很好。

---

## 80. 错误处理与日志规范

### 80.1 全局未捕获异常

```dart
void main() {
  FlutterError.onError = (details) {              // Flutter 框架内未捕获错误（widget 构建/布局/绘制）
    FlutterError.presentError(details);           // 默认行为：把错误打印到控制台
    Sentry.captureException(details.exception, stackTrace: details.stack);  // 上报错误监控
  };
  PlatformDispatcher.instance.onError = (error, stack) {  // Dart 异步错误（PlatformDispatcher = 引擎层）
    Sentry.captureException(error, stackTrace: stack);
    return true;                                  // 返回 true 表示已处理，避免崩溃
  };
  runZonedGuarded(                                // 兜底 Zone：捕获其他来源的未处理异常
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
final logger = Logger(printer: PrettyPrinter(methodCount: 0));  // 创建 Logger；methodCount=0 不打印调用栈

logger.d('debug');                                // debug 级别
logger.i('info');                                 // info 级别
logger.w('warning');                              // warning 级别
logger.e('error', error: e, stackTrace: st);      // error 级别 + 异常对象 + 堆栈
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
class Article {                                   // 业务实体（不含技术细节）
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
extension ArticleDTO on Article {                 // 用 extension 给 Article 增加静态方法（DTO 转换）
  static Article fromJson(Map<String, dynamic> j) => Article(
    id: j['id'] as String,
    title: j['title'] as String,
    summary: j['summary'] as String? ?? '',       // 字段可空 + 默认值，向后兼容老接口
    cover: j['cover'] as String? ?? '',
    author: j['author'] as String? ?? '',
    publishedAt: DateTime.parse(j['publishedAt'] as String),  // ISO 8601 字符串解析为 DateTime
    category: j['category'] as String? ?? 'general',
  );
}

// features/feed/data/feed_remote_ds.dart
class FeedRemoteDataSource {                      // 数据源：直接对接 API 的薄层
  final Dio _dio;
  FeedRemoteDataSource(this._dio);

  Future<List<Article>> list({required String category, required int page}) async {
    final r = await _dio.get('/articles', queryParameters: {'category': category, 'page': page, 'size': 20});
    return (r.data as List).map((e) => ArticleDTO.fromJson(e as Map<String, dynamic>)).toList();  // JSON → 实体列表
  }
}

// features/feed/domain/feed_repository.dart
abstract interface class FeedRepository {         // 抽象接口（domain 层定义）
  Future<List<Article>> list({required String category, required int page});
}

// features/feed/data/feed_repository_impl.dart
class FeedRepositoryImpl implements FeedRepository {  // 实现（data 层）；当前版本未带缓存
  final FeedRemoteDataSource _remote;
  FeedRepositoryImpl(this._remote);

  @override
  Future<List<Article>> list({required String category, required int page}) =>
      _remote.list(category: category, page: page);
}

// providers
@Riverpod(keepAlive: true)
FeedRemoteDataSource feedRemoteDS(Ref ref) => FeedRemoteDataSource(ref.watch(dioProvider));  // 依赖 Dio

@Riverpod(keepAlive: true)
FeedRepository feedRepo(Ref ref) => FeedRepositoryImpl(ref.watch(feedRemoteDSProvider));  // 依赖数据源
```

---

## 85. 状态层：Riverpod Notifier

```dart
// features/feed/presentation/feed_notifier.dart
@riverpod
class FeedController extends _$FeedController {   // 带 family 的异步 Notifier；category 由调用方传
  static const _pageSize = 20;                    // 每页大小
  int _page = 1;                                  // 当前已加载页码
  bool _hasMore = true;                           // 是否还有下一页

  @override
  Future<List<Article>> build(String category) async {  // category 是 family 参数
    _page = 1;                                    // build 重跑（category 切换时）：重置分页
    _hasMore = true;
    final list = await ref.watch(feedRepoProvider).list(category: category, page: _page);
    _hasMore = list.length >= _pageSize;          // 满页就认为还有下一页
    return list;
  }

  Future<void> refresh() async {
    _page = 1;
    state = const AsyncLoading();                 // 切到 loading（UI 显示菊花）
    state = await AsyncValue.guard(() async {
      final list = await ref.read(feedRepoProvider).list(category: category, page: _page);
      _hasMore = list.length >= _pageSize;
      return list;
    });
  }

  Future<void> loadMore() async {
    if (!_hasMore || state.isLoading) return;     // 没更多 / 正在加载 → 跳过（防抖）
    final cur = state.valueOrNull ?? [];          // 当前列表（loading 时取空）
    _page++;
    try {
      final more = await ref.read(feedRepoProvider).list(category: category, page: _page);
      _hasMore = more.length >= _pageSize;
      state = AsyncData([...cur, ...more]);       // 拼接：旧 + 新
    } catch (e, st) {
      _page--;     // 回滚                          // 失败时把页号回滚，避免下次跳号
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
  final String category;                          // 分类 id（推荐/科技/娱乐）
  const FeedPage({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncList = ref.watch(feedControllerProvider(category));  // 监听对应分类的 feed

    return RefreshIndicator(                      // 下拉刷新外壳
      onRefresh: () => ref.read(feedControllerProvider(category).notifier).refresh(),  // 调 Notifier 刷新
      child: asyncList.when(
        loading: () => const _SkeletonList(),     // 加载态：骨架屏
        error: (e, _) => _ErrorView(error: e, onRetry: () => ref.read(feedControllerProvider(category).notifier).refresh()),  // 错误态：带重试
        data: (list) {
          if (list.isEmpty) return const _EmptyView();  // 空态
          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: list.length + 1,           // +1 给"加载更多"占位
            separatorBuilder: (_, __) => const SizedBox(height: 8),  // 8 间距
            itemBuilder: (ctx, i) {
              if (i == list.length) {
                // 触发加载更多
                WidgetsBinding.instance.addPostFrameCallback((_) {  // 当前帧绘制完成后再触发，避免在 build 中改 state
                  ref.read(feedControllerProvider(category).notifier).loadMore();
                });
                return const Center(child: Padding(padding: EdgeInsets.all(16), child: CircularProgressIndicator()));
              }
              return ArticleTile(article: list[i]);  // 普通文章项
            },
          );
        },
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {       // 文章列表项；纯展示型
  final Article article;
  const ArticleTile({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => ArticleRoute(id: article.id).push(context),  // go_router_builder 类型安全跳转
        borderRadius: BorderRadius.circular(12),  // 涟漪也按圆角裁剪
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(                          // 圆角裁剪封面
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: article.cover,
                  width: 100,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(                           // 右侧主体占满剩余宽度
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium),  // 标题
                    const SizedBox(height: 4),
                    Text(article.summary, maxLines: 2, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.bodySmall),  // 摘要
                    const Spacer(),               // 把元信息推到底部
                    Row(
                      children: [
                        Text(article.author, style: Theme.of(context).textTheme.labelSmall),
                        const SizedBox(width: 8),
                        Text(_format(article.publishedAt), style: Theme.of(context).textTheme.labelSmall),  // 相对时间
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

  String _format(DateTime dt) {                   // 把 DateTime 格式化为"X 分钟前"
    final d = DateTime.now().difference(dt);      // 与现在的差值
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
class App extends ConsumerWidget {                // 总装入口：把所有 Provider 都接到 MaterialApp
  const App({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(                    // 路由模式
      title: 'News',
      theme: buildLightTheme(),                   // 亮色主题
      darkTheme: buildDarkTheme(),                // 暗色主题
      themeMode: ref.watch(themeModeProvider).valueOrNull ?? ThemeMode.system,  // 用户设置 → 跟随系统
      locale: ref.watch(localeProvider).valueOrNull,  // 当前语言；null 跟随系统
      localizationsDelegates: AppLocalizations.localizationsDelegates,  // 系统组件本地化
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: ref.watch(routerProvider),    // 路由配置（也是 Provider）
      debugShowCheckedModeBanner: false,          // 关掉右上角 debug 红角标
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
