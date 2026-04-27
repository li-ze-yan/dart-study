# Flutter 生产级集成专题（支付 / IM / 推送 / 埋点）

> **前置阅读**：[`dart-tutorial-new.md`](dart-tutorial-new.md) → [`flutter-tutorial.md`](flutter-tutorial.md) → [`flutter-tutorial-ecommerce.md`](flutter-tutorial-ecommerce.md)
>
> 本文是电商扩展的延伸，针对四个**真实上线时绕不过去的集成专题**：
>
> - **Part 1 · 支付**：微信 / 支付宝 / Apple IAP / Google Play Billing
> - **Part 2 · IM 客服**：长连接架构 + 自建 WS 完整实现 + 三方 SDK 选型
> - **Part 3 · 推送**：APNs / FCM / 国内厂商通道 / 极光 / 通知点击跳转
> - **Part 4 · 埋点**：事件总线设计 + 神策/友盟/Firebase Analytics + 隐私合规
>
> 所有代码假设你已采用上一份扩展中的架构（Riverpod + go_router + Dio + freezed + Apple/Google 登录）。

---

## 目录

### Part 1 · 支付集成
- [1.1 支付方式决策树（最关键）](#11-支付方式决策树最关键)
- [1.2 抽象层：统一 PaymentService 设计](#12-抽象层统一-paymentservice-设计)
- [1.3 后端协议约定（RESTful）](#13-后端协议约定restful)
- [1.4 微信支付（fluwx）](#14-微信支付fluwx)
- [1.5 支付宝支付（tobias）](#15-支付宝支付tobias)
- [1.6 Apple IAP（in_app_purchase）](#16-apple-iapin_app_purchase)
- [1.7 Google Play Billing](#17-google-play-billing)
- [1.8 多支付方式收银台](#18-多支付方式收银台)
- [1.9 与订单系统联动 / 状态轮询 / 退款](#19-与订单系统联动--状态轮询--退款)
- [1.10 上线前合规与坑点](#110-上线前合规与坑点)

### Part 2 · IM 客服系统
- [2.1 IM 实现路径决策](#21-im-实现路径决策)
- [2.2 长连接架构总览](#22-长连接架构总览)
- [2.3 消息协议设计](#23-消息协议设计)
- [2.4 自建 WS：连接层（心跳 + 重连）](#24-自建-ws连接层心跳--重连)
- [2.5 自建 WS：消息层（队列 + ACK + 离线）](#25-自建-ws消息层队列--ack--离线)
- [2.6 本地存储（Hive 会话与消息）](#26-本地存储hive-会话与消息)
- [2.7 Riverpod 集成与状态层](#27-riverpod-集成与状态层)
- [2.8 客服会话 UI](#28-客服会话-ui)
- [2.9 商品卡片 / 订单卡片消息](#29-商品卡片--订单卡片消息)
- [2.10 三方 IM SDK 接入指南](#210-三方-im-sdk-接入指南)
- [2.11 IM 常见坑](#211-im-常见坑)

### Part 3 · 推送通知
- [3.1 通道决策（APNs / FCM / 厂商 / 聚合）](#31-通道决策apns--fcm--厂商--聚合)
- [3.2 整体架构](#32-整体架构)
- [3.3 iOS：APNs 配置](#33-iosapns-配置)
- [3.4 Android：FCM 配置](#34-androidfcm-配置)
- [3.5 Flutter 端集成（firebase_messaging + flutter_local_notifications）](#35-flutter-端集成firebase_messaging--flutter_local_notifications)
- [3.6 Token 上报与生命周期](#36-token-上报与生命周期)
- [3.7 通知点击跳转 + 深链接](#37-通知点击跳转--深链接)
- [3.8 国内厂商通道（HMS / OPush / mPush / VPush）](#38-国内厂商通道hms--opush--mpush--vpush)
- [3.9 极光 / 个推聚合方案](#39-极光--个推聚合方案)
- [3.10 静默推送 / 角标 / 自定义声音](#310-静默推送--角标--自定义声音)
- [3.11 推送策略与坑点](#311-推送策略与坑点)

### Part 4 · 数据上报与埋点
- [4.1 平台决策](#41-平台决策)
- [4.2 埋点架构总览](#42-埋点架构总览)
- [4.3 事件总线（核心）](#43-事件总线核心)
- [4.4 公共属性 / 上下文](#44-公共属性--上下文)
- [4.5 自动埋点：路由曝光](#45-自动埋点路由曝光)
- [4.6 自动埋点：Widget 曝光（VisibilityDetector）](#46-自动埋点widget-曝光visibilitydetector)
- [4.7 业务手动埋点](#47-业务手动埋点)
- [4.8 上报策略（实时 / 批量 / 弱网兜底）](#48-上报策略实时--批量--弱网兜底)
- [4.9 多通道适配（神策 / 友盟 / Firebase）](#49-多通道适配神策--友盟--firebase)
- [4.10 隐私合规与用户同意](#410-隐私合规与用户同意)
- [4.11 与崩溃 / 性能监控的关系（Sentry / Bugly）](#411-与崩溃--性能监控的关系sentry--bugly)
- [4.12 埋点验收与排查](#412-埋点验收与排查)

### 附录
- [附录 X：仍待你拍板的开放问题](#附录-x仍待你拍板的开放问题)

---

# Part 1 · 支付集成

## 1.1 支付方式决策树（最关键）

支付选错最痛的一刀是**苹果会拒审**。先把决策树记住：

```
你的应用要付款的是？
│
├─ 实物商品 / 线下服务（电商、外卖、酒店、票务）
│   │
│   ├─ 国内用户 → 微信支付 + 支付宝（必备） + 银联（可选）
│   │
│   └─ 海外用户 → Stripe / PayPal / Apple Pay / Google Pay
│
├─ 虚拟商品 / 数字内容（订阅、解锁高级功能、游戏币、虚拟道具、付费章节）
│   │
│   ├─ iOS App  →  必须 Apple IAP（in_app_purchase）
│   │             绕过会被拒审 / 下架（除非属于白名单：教育、企业等少数例外）
│   │
│   └─ Android App → 必须 Google Play Billing（Play 商店发行时）
│                  → 自有渠道（apk）可走微信/支付宝
│
└─ App 内打赏 / 捐赠
    └─ iOS：苹果允许"个人对个人"打赏走第三方支付（如打赏作者），
       但"用户向 App 经营者"打赏算虚拟商品，需走 IAP。
       **判定模糊，建议提前邮件咨询审核组。**
```

**核心心智**：
- **30% 苹果税 / Google 抽成**：虚拟商品在 iOS / Android 商店分发**逃不掉**。
- **不能引导**：iOS 上不能出现"在我们网站充值更便宜"这种话术，会被拒审（4.7 / 3.1.1 条款）。
- **退款流程不同**：第三方支付退款由你后端调 API；IAP 退款是用户找苹果，你只能监听 `Refund` 事件。

> 🌟 **最常见的电商场景**：实物商品 + 国内用户。所以本文重点写 **微信 + 支付宝**，再讲 IAP 与 Google Billing 应对"会员订阅 / 解锁功能"等虚拟付费需求。

---

## 1.2 抽象层：统一 PaymentService 设计

无论底层是哪种 SDK，业务层只关心：
1. **选了什么支付方式**
2. **要付款的订单 ID 和金额**
3. **结果**：成功 / 失败 / 取消

```dart
// lib/features/payment/domain/payment_method.dart
enum PaymentMethod {
  wechat('WECHAT'),
  alipay('ALIPAY'),
  appleIAP('APPLE_IAP'),
  googleBilling('GOOGLE_BILLING'),
  unionpay('UNIONPAY');

  final String code;
  const PaymentMethod(this.code);
}

// 支付结果
@freezed
sealed class PayResult with _$PayResult {
  const factory PayResult.success({required String orderId, String? channelTxnId}) = PaySuccess;
  const factory PayResult.cancelled() = PayCancelled;
  const factory PayResult.failed({required String message, String? code}) = PayFailed;
  const factory PayResult.pending({required String orderId}) = PayPending;  // 需要服务端轮询
}
```

```dart
// lib/features/payment/domain/payment_service.dart
abstract interface class PaymentService {
  Future<PayResult> pay({
    required PaymentMethod method,
    required String orderId,
  });
}
```

每种支付实现一个 Channel，最后用 `PaymentService` 聚合：

```dart
// lib/features/payment/data/payment_service_impl.dart
class PaymentServiceImpl implements PaymentService {
  final WeChatPayChannel _wechat;
  final AlipayChannel _alipay;
  final AppleIAPChannel _iap;
  final GoogleBillingChannel _billing;
  final PaymentApi _api;

  PaymentServiceImpl(this._wechat, this._alipay, this._iap, this._billing, this._api);

  @override
  Future<PayResult> pay({required PaymentMethod method, required String orderId}) async {
    // 1) 找服务端要支付参数
    final params = await _api.createPayment(orderId: orderId, method: method);

    // 2) 唤起对应 SDK
    return switch (method) {
      PaymentMethod.wechat => _wechat.pay(params),
      PaymentMethod.alipay => _alipay.pay(params),
      PaymentMethod.appleIAP => _iap.pay(orderId: orderId, productId: params.productId!),
      PaymentMethod.googleBilling => _billing.pay(orderId: orderId, productId: params.productId!),
      _ => throw const PayException('unsupported_method', '不支持的支付方式'),
    };
  }
}

@Riverpod(keepAlive: true)
PaymentService paymentService(Ref ref) => PaymentServiceImpl(
  ref.watch(weChatPayChannelProvider),
  ref.watch(alipayChannelProvider),
  ref.watch(appleIAPChannelProvider),
  ref.watch(googleBillingChannelProvider),
  ref.watch(paymentApiProvider),
);
```

---

## 1.3 后端协议约定（RESTful）

```
POST /api/v1/payments
Body: { "orderId": "o-001", "method": "WECHAT" }
Response.data:                                # 不同 method 返回不同形状
  # 微信
  {
    "method": "WECHAT",
    "appId": "wx...", "partnerId": "...", "prepayId": "...",
    "noncestr": "...", "timestamp": "...", "package": "...", "sign": "..."
  }
  # 支付宝
  {
    "method": "ALIPAY",
    "orderInfo": "<已经签好名的字符串>"
  }
  # Apple IAP / Google
  {
    "method": "APPLE_IAP" | "GOOGLE_BILLING",
    "productId": "com.yourapp.vip_monthly",
    "internalPaymentId": "p-xyz"            # 用于回调时双向找到本地订单
  }

POST /api/v1/payments/{paymentId}/verify
Body: { "channelTxnId": "...", "receipt": "..." }   # IAP 时带 receipt
Response.data: { "status": "PAID" | "PENDING" | "FAILED" }

GET /api/v1/orders/{orderId}/status
Response.data: { "status": "PAID" | "PENDING_PAYMENT" | ... }
```

> ⚠️ **重要原则**：**支付状态以服务端为准**。即使 SDK 返回 success，后端没收到回调也不算成功；即使 SDK 返回失败，可能服务端已经收到回调（弱网延迟）。**永远在支付流程结束后再请求一次订单状态**。

---

## 1.4 微信支付（fluwx）

```bash
flutter pub add fluwx
```

> 📌 fluwx 是社区维护的微信开放平台 + 微信支付聚合 SDK，主流且活跃。

### 1.4.1 平台配置

#### iOS
1. 微信开放平台注册 App，拿 AppID / UniversalLink。
2. Xcode：
   - URL Types 添加：`weixin` / `wechat` / `your-appid`
   - Capabilities 添加 Associated Domains：`applinks:your-domain.com`
   - 构建一个 `apple-app-site-association` 文件部署到 UniversalLink 域名
3. `Info.plist` 添加 `LSApplicationQueriesSchemes`：`weixin`, `weixinULAPI`, `weixinURLParamsAPI`。

#### Android
1. 包名 + 签名 SHA-1 在开放平台后台配置。
2. `MainActivity` 包名要和注册一致。
3. 添加 `WXEntryActivity`（fluwx 已自动注入，无需手写，但要注意混淆规则）。

### 1.4.2 SDK 初始化

```dart
// main.dart 或 app 启动早期
import 'package:fluwx/fluwx.dart';

Future<void> initWeChat() async {
  await registerWxApi(
    appId: 'wxYOUR_APPID',
    universalLink: 'https://yourdomain.com/app/',
  );
}
```

### 1.4.3 唤起支付

```dart
// lib/features/payment/data/wechat_pay_channel.dart
class WeChatPayChannel {
  StreamSubscription? _sub;
  Completer<PayResult>? _pending;

  WeChatPayChannel() {
    _sub = weChatResponseEventHandler.listen(_onResp);
  }

  Future<PayResult> pay(PayParams params) async {
    _pending = Completer<PayResult>();
    final ok = await payWithWeChat(
      appId: params.appId!,
      partnerId: params.partnerId!,
      prepayId: params.prepayId!,
      packageValue: params.package!,
      nonceStr: params.noncestr!,
      timestamp: int.parse(params.timestamp!),
      sign: params.sign!,
    );
    if (!ok) {
      _pending = null;
      return const PayResult.failed(message: '唤起微信失败');
    }
    return _pending!.future;
  }

  void _onResp(WeChatResponse resp) {
    final c = _pending;
    if (c == null) return;
    if (resp is WeChatPaymentResponse) {
      // errCode: 0 成功, -1 错误, -2 用户取消
      switch (resp.errCode) {
        case 0:
          c.complete(const PayResult.success(orderId: ''));
          break;
        case -2:
          c.complete(const PayResult.cancelled());
          break;
        default:
          c.complete(PayResult.failed(message: resp.errStr ?? '微信支付失败', code: '${resp.errCode}'));
      }
      _pending = null;
    }
  }

  void dispose() {
    _sub?.cancel();
  }
}

@Riverpod(keepAlive: true)
WeChatPayChannel weChatPayChannel(Ref ref) {
  final ch = WeChatPayChannel();
  ref.onDispose(ch.dispose);
  return ch;
}
```

> ⚠️ **`fluwx` API 在 5.x / 6.x / 11.x 之间变化较大**：上面是主流版本的写法骨架，正式接入时**对照当前版本文档**调整方法名（如 `payWithWeChat` 在不同版本可能叫 `pay`）。

---

## 1.5 支付宝支付（tobias）

```bash
flutter pub add tobias
```

### 1.5.1 平台配置

#### iOS
- 在支付宝开放平台 → 网页&移动应用 → 创建应用，启用"App 支付"。
- URL Types 添加 `alipay` schema（应用 ID 反过来）。
- `Info.plist` 加 `LSApplicationQueriesSchemes`：`alipay`, `alipayshare`。

#### Android
- 把 `Sign Cert MD5` 给开放平台审核。
- `AndroidManifest.xml` 一般不需要额外配置。

### 1.5.2 唤起

```dart
import 'package:tobias/tobias.dart';

class AlipayChannel {
  Future<PayResult> pay(PayParams params) async {
    // 服务端把已签名的 orderInfo 作为单一字符串返回
    final res = await Tobias().pay(params.orderInfo!);
    final code = res['resultStatus'] as String?;
    switch (code) {
      case '9000': return const PayResult.success(orderId: '');
      case '6001': return const PayResult.cancelled();
      case '8000': return const PayResult.pending(orderId: '');     // 需轮询
      default: return PayResult.failed(message: res['memo']?.toString() ?? '支付宝失败', code: code);
    }
  }
}
```

> 📌 支付宝的"订单信息字符串" `orderInfo` **必须由服务端用商户私钥签名**，App 拿到的是已签好的串。**不要在 App 端做签名**——私钥泄漏后果严重。

---

## 1.6 Apple IAP（in_app_purchase）

> ⚠️ **铁律**：iOS 卖**虚拟商品**只能用 IAP；卖**实物**禁止用 IAP（条款 3.1.5）。混淆会被拒。

```bash
flutter pub add in_app_purchase
```

### 1.6.1 商品配置（App Store Connect）

1. App Store Connect → 你的 App → "App 内购买项目"。
2. 类型选择：
   - **消耗型 (Consumable)**：金币、解锁次数（可重复购买）。
   - **非消耗型 (Non-Consumable)**：永久解锁（一次性）。
   - **自动续期订阅 (Auto-Renewable Subscription)**：会员、付费内容。
   - **非续期订阅 (Non-Renewing)**：固定时长会员（少用）。
3. 填写 Product ID（建议 `bundleId.feature`：`com.yourapp.vip_monthly`）。
4. **Sandbox 测试账号**：Users and Access → Sandbox Testers 创建。

### 1.6.2 实现

```dart
// lib/features/payment/data/apple_iap_channel.dart
import 'package:in_app_purchase/in_app_purchase.dart';

class AppleIAPChannel {
  final InAppPurchase _iap = InAppPurchase.instance;
  StreamSubscription<List<PurchaseDetails>>? _sub;
  final _resultByPaymentId = <String, Completer<PayResult>>{};

  Future<void> init() async {
    final available = await _iap.isAvailable();
    if (!available) {
      // 设备不支持（如未登录 Apple ID 或区域限制）
      return;
    }
    // 全局监听购买回调
    _sub = _iap.purchaseStream.listen(_onPurchaseUpdate);
  }

  Future<List<ProductDetails>> queryProducts(Set<String> ids) async {
    final response = await _iap.queryProductDetails(ids);
    if (response.notFoundIDs.isNotEmpty) {
      // 调试时常见：商品在 ASC 没设好或没等同步生效
      print('IAP 未找到的商品: ${response.notFoundIDs}');
    }
    return response.productDetails;
  }

  Future<PayResult> pay({required String orderId, required String productId}) async {
    final products = await queryProducts({productId});
    if (products.isEmpty) {
      return const PayResult.failed(message: 'IAP 商品未配置或未生效');
    }

    // applicationUserName 用于把 IAP 交易和你的 user / order 绑定
    final param = PurchaseParam(
      productDetails: products.first,
      applicationUserName: orderId,
    );

    final completer = Completer<PayResult>();
    _resultByPaymentId[orderId] = completer;

    // Consumable / NonConsumable 调用不同方法
    final isConsumable = _isConsumable(productId);
    if (isConsumable) {
      await _iap.buyConsumable(purchaseParam: param);
    } else {
      await _iap.buyNonConsumable(purchaseParam: param);
    }
    return completer.future;
  }

  Future<void> _onPurchaseUpdate(List<PurchaseDetails> purchases) async {
    for (final p in purchases) {
      switch (p.status) {
        case PurchaseStatus.pending:
          break;   // 加载中
        case PurchaseStatus.error:
          _resolve(p.purchaseID, PayResult.failed(message: p.error?.message ?? 'IAP 错误'));
          break;
        case PurchaseStatus.canceled:
          _resolve(p.purchaseID, const PayResult.cancelled());
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // ★ 关键：把 receipt 发给服务端校验
          final ok = await _verifyOnServer(p);
          if (ok) {
            _resolve(p.purchaseID, const PayResult.success(orderId: ''));
          } else {
            _resolve(p.purchaseID, const PayResult.failed(message: 'IAP 服务端校验失败'));
          }
          // 必须 completePurchase，否则苹果重复推送同一笔
          if (p.pendingCompletePurchase) {
            await _iap.completePurchase(p);
          }
          break;
      }
    }
  }

  void _resolve(String? id, PayResult r) {
    if (id == null) return;
    final c = _resultByPaymentId.remove(id);
    c?.complete(r);
  }

  Future<bool> _verifyOnServer(PurchaseDetails p) async {
    // 调用你的后端 /payments/{paymentId}/verify
    // p.verificationData.serverVerificationData 是 receipt（base64）
    return true;     // 实际实现替换
  }

  bool _isConsumable(String productId) =>
      productId.contains('coins') || productId.contains('boost');

  void dispose() {
    _sub?.cancel();
  }
}
```

### 1.6.3 服务端验证（思路简介）

1. App 把 `serverVerificationData` 发给后端。
2. 后端调 Apple `/inAppPurchase/verifyReceipt`（旧）或 **App Store Server API**（新，2023+ 推荐）。
3. 验证 `aud` / `bid` / `exp`，检查防重放（同一个 transactionId 不能多次发货）。
4. 返回成功后才发货（解锁权益）。

---

## 1.7 Google Play Billing

`in_app_purchase` 同时支持 iOS 和 Android。Android 端额外注意：

### 1.7.1 平台配置

1. Play Console → 你的 App → 创建商品（Managed product / Subscription）。
2. **应用必须先发布到 Internal Testing**，商品才能查询到。
3. `android/app/build.gradle`：

```groovy
android {
    defaultConfig {
        multiDexEnabled true
    }
}
```

### 1.7.2 实现

代码和 IAP 几乎一样（`in_app_purchase` 已经抽象了 iOS / Android）。差异：

```dart
class GoogleBillingChannel {
  final InAppPurchase _iap = InAppPurchase.instance;

  Future<PayResult> pay({required String orderId, required String productId}) async {
    // 同 AppleIAPChannel 的实现
    // ...
    // 服务端验证用 purchaseToken（不是 receipt）
  }
}
```

### 1.7.3 服务端验证（思路）

1. App 发送 `purchaseToken` 给后端。
2. 后端调用 Google Play Developer API：
   - `purchases.products.get`（一次性商品）
   - `purchases.subscriptions.get`（订阅）
3. 验证 orderId、purchaseState、acknowledgementState；下发权益后调 `acknowledge` 或 `consume`。

> ⚠️ **acknowledge 时限**：3 天内没 acknowledge 的购买会被自动退款。后端通知必须及时。

---

## 1.8 多支付方式收银台

```dart
class CashierPage extends ConsumerStatefulWidget {
  final String orderId;
  final Money amount;
  final bool allowIAP;          // 虚拟商品时为 true
  const CashierPage({super.key, required this.orderId, required this.amount, this.allowIAP = false});

  @override
  ConsumerState<CashierPage> createState() => _CashierPageState();
}

class _CashierPageState extends ConsumerState<CashierPage> {
  PaymentMethod? _selected;
  bool _paying = false;

  @override
  void initState() {
    super.initState();
    _selected = _availableMethods.first;
  }

  List<PaymentMethod> get _availableMethods {
    if (widget.allowIAP) {
      // 虚拟商品：仅平台官方
      return defaultTargetPlatform == TargetPlatform.iOS
          ? [PaymentMethod.appleIAP]
          : [PaymentMethod.googleBilling];
    }
    return [PaymentMethod.wechat, PaymentMethod.alipay];
  }

  Future<void> _confirm() async {
    setState(() => _paying = true);
    try {
      final r = await ref.read(paymentServiceProvider).pay(
        method: _selected!,
        orderId: widget.orderId,
      );

      // ★ 不要相信 SDK 结果，再问一次服务端
      final status = await ref.read(orderRepositoryProvider).getStatus(widget.orderId);

      if (mounted) {
        if (status == OrderStatus.paid) {
          PayResultRoute(orderId: widget.orderId, success: true).pushReplacement(context);
        } else {
          // 状态还未到，进入"等待"页（带轮询）
          PayPendingRoute(orderId: widget.orderId).pushReplacement(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('支付失败: $e')));
      }
    } finally {
      if (mounted) setState(() => _paying = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('支付')),
      body: Column(
        children: [
          const SizedBox(height: 32),
          Text('应付', style: TextStyle(color: Colors.grey.shade600)),
          Text(widget.amount.format(), style: const TextStyle(fontSize: 32, color: Colors.red, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          ..._availableMethods.map((m) => RadioListTile<PaymentMethod>(
            value: m,
            groupValue: _selected,
            onChanged: (v) => setState(() => _selected = v),
            title: Text(_label(m)),
            secondary: Icon(_icon(m)),
          )),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _paying ? null : _confirm,
                child: _paying ? const CircularProgressIndicator() : Text('确认支付 ${widget.amount.format()}'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _label(PaymentMethod m) => switch (m) {
    PaymentMethod.wechat => '微信支付',
    PaymentMethod.alipay => '支付宝',
    PaymentMethod.appleIAP => 'App Store 内购',
    PaymentMethod.googleBilling => 'Google Play',
    PaymentMethod.unionpay => '银联',
  };

  IconData _icon(PaymentMethod m) => switch (m) {
    PaymentMethod.wechat => Icons.chat,
    PaymentMethod.alipay => Icons.account_balance_wallet,
    PaymentMethod.appleIAP => Icons.apple,
    PaymentMethod.googleBilling => Icons.shop,
    PaymentMethod.unionpay => Icons.credit_card,
  };
}
```

---

## 1.9 与订单系统联动 / 状态轮询 / 退款

### 1.9.1 待支付状态轮询页

弱网或微信"返回 App 慢" 都会让 SDK 回调延迟，需要轮询：

```dart
class PayPendingPage extends ConsumerStatefulWidget {
  final String orderId;
  const PayPendingPage({super.key, required this.orderId});
  @override
  ConsumerState<PayPendingPage> createState() => _PayPendingPageState();
}

class _PayPendingPageState extends ConsumerState<PayPendingPage> {
  Timer? _timer;
  int _retries = 0;
  static const _maxRetries = 20;          // 最多查 20 次（约 1 分钟）

  @override
  void initState() {
    super.initState();
    _poll();
  }

  Future<void> _poll() async {
    if (!mounted || _retries >= _maxRetries) return;
    _retries++;
    try {
      final status = await ref.read(orderRepositoryProvider).getStatus(widget.orderId);
      if (!mounted) return;
      if (status == OrderStatus.paid) {
        PayResultRoute(orderId: widget.orderId, success: true).pushReplacement(context);
        return;
      }
    } catch (_) {/* 继续轮询 */}
    _timer = Timer(const Duration(seconds: 3), _poll);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text('正在确认支付结果…'),
            const SizedBox(height: 8),
            Text('已查询 $_retries 次', style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 24),
            TextButton(
              onPressed: () => context.go('/orders?status=pending'),
              child: const Text('稍后查看'),
            ),
          ],
        ),
      ),
    );
  }
}
```

### 1.9.2 退款

退款由**服务端**调三方支付的退款 API；App 端只展示状态。订单 `OrderStatus.refunding` → `refunded`。

IAP 退款是**用户主动找苹果**：
- `App Store Server Notifications V2` 推送 `REFUND` 事件给后端。
- 后端收到后扣权益（如取消会员）。
- App 下次进入时刷新订单列表能看到退款标记。

---

## 1.10 上线前合规与坑点

### 合规
- [ ] **iOS 虚拟商品没走 IAP** → 100% 拒审。
- [ ] **iOS 有"web 充值更便宜"等引流文案** → 拒审。
- [ ] **国内电商必须有 ICP 备案 / 经营许可证**才能接微信 / 支付宝。
- [ ] **隐私政策必须列出**收集了哪些用户信息（设备号、IP、订单等）。
- [ ] **未成年人保护**：游戏类需要实名认证 + 防沉迷。

### 坑
1. **支付成功但回调丢失**：用户已扣款 → 你后端没发货 → 投诉。**永远轮询订单状态**。
2. **重复支付**：用户连点两次按钮 → 创建两个支付订单。前端必须置 loading；后端按 `orderId` 幂等。
3. **金额改动**：前端不要参与金额计算；后端基于商品 / 优惠券计算最终金额，前端只展示。
4. **Sandbox 测试**：iOS 真机用 Sandbox Apple ID；Android 用 License Tester；正式 Apple ID 在 Sandbox 商品上付款会真扣钱。
5. **支付宝沙箱**：开放平台有 Sandbox 环境，**完全独立**的网关 URL 和密钥。
6. **fluwx 多版本兼容**：商家版微信 / 企业微信不能调起支付。

---

# Part 2 · IM 客服系统

## 2.1 IM 实现路径决策

```
你需要的 IM 功能复杂度？
│
├─ 仅"商家客服"（用户与几个客服聊天）
│   ├─ 接 Intercom / Zendesk / Crisp / 美洽（轻松开发，月费）
│   └─ 用三方 IM SDK + 简单后端
│
├─ 用户之间也能聊（社交、社区）
│   ├─ 接 SendBird / Stream Chat（海外）
│   ├─ 接 网易云信 / 腾讯云 IM / LeanCloud / 环信（国内）
│   └─ 自建 WebSocket（完全可控、长期成本低）
│
└─ 需要超大规模（百万 DAU 级别消息）
    └─ 必须自建 + 专门 IM 团队（消息存储、会话路由、群消息扩散）
```

**我们的电商场景**：用户↔商家客服。**推荐组合**：自建 WS 轻量实现（本文 §2.4–2.9 完整代码），或直接接腾讯云 IM / 网易云信（§2.10 给指南）。

---

## 2.2 长连接架构总览

```
┌──────────┐     WebSocket (wss://)     ┌────────────┐
│ Flutter  │ <─────────────────────────> │ IM Server  │
│ Client   │                             │  (Go/Node) │
└──────────┘                             └─────┬──────┘
                                               │
                                         ┌─────▼──────┐
                                         │  消息存储   │  Redis (会话/在线状态) + MongoDB/MySQL (历史)
                                         └────────────┘
                                               │
                                         ┌─────▼──────┐
                                         │  推送服务   │  → APNs / FCM (离线推送)
                                         └────────────┘
```

App 必须解决的事：
1. **建立连接**（带 token 鉴权）
2. **心跳保活**
3. **断线重连**（指数退避）
4. **应用前后台切换** → iOS 后台保活有限，要主动断开
5. **消息可靠性**：发送 ACK / 消息去重 / 时序保证
6. **消息持久化**：本地 DB（Hive/Isar）保存，离线打开也能看
7. **离线消息拉取**：上线后拉新消息

---

## 2.3 消息协议设计

JSON 协议（简单、可读、易调试）：

```dart
@freezed
sealed class WsFrame with _$WsFrame {
  const factory WsFrame.auth({required String token}) = AuthFrame;
  const factory WsFrame.ping() = PingFrame;
  const factory WsFrame.pong() = PongFrame;
  const factory WsFrame.msg({required IMMessage message}) = MsgFrame;
  const factory WsFrame.ack({required String clientMsgId, required String serverMsgId, required DateTime serverTime}) = AckFrame;
  const factory WsFrame.read({required String conversationId, required String upToMsgId}) = ReadFrame;
  const factory WsFrame.error({required String code, required String message}) = ErrorFrame;

  factory WsFrame.fromJson(Map<String, dynamic> j) => _$WsFrameFromJson(j);
}
```

> `WsFrame` 用 freezed 的 sealed union 自动得到 `toJson`，加 `@JsonKey` 让 type 字段自动反序列化（freezed 默认就这么做）。

```dart
@freezed
class IMMessage with _$IMMessage {
  const factory IMMessage({
    required String clientMsgId,         // 客户端生成（UUID）
    String? serverMsgId,                 // 服务端确认后回填
    required String conversationId,
    required String fromUserId,
    required String toUserId,            // 客服会话里就是商家或用户的某种 ID
    required IMContent content,
    required DateTime createdAt,
    @Default(IMMessageStatus.sending) IMMessageStatus status,
  }) = _IMMessage;
  factory IMMessage.fromJson(Map<String, dynamic> j) => _$IMMessageFromJson(j);
}

enum IMMessageStatus {
  @JsonValue('SENDING') sending,
  @JsonValue('SENT') sent,
  @JsonValue('FAILED') failed,
  @JsonValue('READ') read,
}

@freezed
sealed class IMContent with _$IMContent {
  const factory IMContent.text(String text) = TextContent;
  const factory IMContent.image({required String url, int? width, int? height}) = ImageContent;
  const factory IMContent.product({required String productId, required String title, required String cover, required String priceText}) = ProductContent;
  const factory IMContent.order({required String orderId, required String orderNo, required String coverImage, required String summary, required String totalText}) = OrderContent;
  const factory IMContent.system(String text) = SystemContent;

  factory IMContent.fromJson(Map<String, dynamic> j) => _$IMContentFromJson(j);
}
```

---

## 2.4 自建 WS：连接层（心跳 + 重连）

```bash
flutter pub add web_socket_channel uuid
```

```dart
// lib/features/im/data/im_socket.dart
import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

enum SocketState { disconnected, connecting, connected }

class IMSocket {
  final String url;
  final Future<String?> Function() tokenProvider;

  final _stateCtl = StreamController<SocketState>.broadcast();
  final _frameCtl = StreamController<WsFrame>.broadcast();

  Stream<SocketState> get stateStream => _stateCtl.stream;
  Stream<WsFrame> get frameStream => _frameCtl.stream;
  SocketState get state => _state;

  WebSocketChannel? _channel;
  StreamSubscription? _channelSub;
  Timer? _pingTimer;
  Timer? _reconnectTimer;
  Timer? _pongTimeout;
  SocketState _state = SocketState.disconnected;
  int _reconnectAttempt = 0;
  bool _stopped = false;

  IMSocket({required this.url, required this.tokenProvider});

  Future<void> connect() async {
    if (_state != SocketState.disconnected) return;
    _stopped = false;
    _setState(SocketState.connecting);

    final token = await tokenProvider();
    if (token == null) {
      _setState(SocketState.disconnected);
      _scheduleReconnect();
      return;
    }

    try {
      _channel = IOWebSocketChannel.connect(
        Uri.parse('$url?token=$token'),
        pingInterval: null,                  // 心跳我们自己管
      );
      _channelSub = _channel!.stream.listen(
        _onData,
        onError: _onError,
        onDone: _onDone,
        cancelOnError: true,
      );
      _send(const WsFrame.auth(token: ''));   // 真实 token 已经在 URL 里
      _setState(SocketState.connected);
      _reconnectAttempt = 0;
      _startPing();
    } catch (e) {
      _setState(SocketState.disconnected);
      _scheduleReconnect();
    }
  }

  void disconnect() {
    _stopped = true;
    _reconnectTimer?.cancel();
    _pingTimer?.cancel();
    _pongTimeout?.cancel();
    _channelSub?.cancel();
    _channel?.sink.close();
    _channel = null;
    _setState(SocketState.disconnected);
  }

  void send(WsFrame frame) {
    if (_state != SocketState.connected) return;
    _send(frame);
  }

  void _send(WsFrame f) {
    _channel?.sink.add(jsonEncode(f.toJson()));
  }

  void _onData(dynamic raw) {
    try {
      final json = jsonDecode(raw as String) as Map<String, dynamic>;
      final frame = WsFrame.fromJson(json);
      if (frame is PongFrame) {
        _pongTimeout?.cancel();
      } else {
        _frameCtl.add(frame);
      }
    } catch (e) {
      print('IM 解析失败: $e');
    }
  }

  void _onError(Object e) {
    _setState(SocketState.disconnected);
    _scheduleReconnect();
  }

  void _onDone() {
    _setState(SocketState.disconnected);
    if (!_stopped) _scheduleReconnect();
  }

  void _startPing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 25), (_) {
      if (_state != SocketState.connected) return;
      _send(const WsFrame.ping());
      // 10 秒内没收到 pong 就当断了
      _pongTimeout?.cancel();
      _pongTimeout = Timer(const Duration(seconds: 10), () {
        _channel?.sink.close();
      });
    });
  }

  void _scheduleReconnect() {
    if (_stopped) return;
    _reconnectTimer?.cancel();
    // 指数退避：2, 4, 8, 16, 30, 30...
    _reconnectAttempt++;
    final delaySec = (1 << _reconnectAttempt).clamp(2, 30);
    _reconnectTimer = Timer(Duration(seconds: delaySec), connect);
  }

  void _setState(SocketState s) {
    if (_state == s) return;
    _state = s;
    _stateCtl.add(s);
  }

  void dispose() {
    disconnect();
    _stateCtl.close();
    _frameCtl.close();
  }
}
```

---

## 2.5 自建 WS：消息层（队列 + ACK + 离线）

```dart
// lib/features/im/data/im_repository.dart
class IMRepository {
  final IMSocket _socket;
  final IMMessageStorage _storage;     // §2.6
  final Dio _dio;
  final _uuid = const Uuid();

  // clientMsgId → 等待 ACK 的 Completer
  final _pendingAcks = <String, Completer<IMMessage>>{};

  IMRepository(this._socket, this._storage, this._dio) {
    _socket.frameStream.listen(_onFrame);
    _socket.stateStream.listen(_onState);
  }

  Future<IMMessage> send({
    required String conversationId,
    required String toUserId,
    required IMContent content,
    required String fromUserId,
  }) async {
    final msg = IMMessage(
      clientMsgId: _uuid.v4(),
      conversationId: conversationId,
      fromUserId: fromUserId,
      toUserId: toUserId,
      content: content,
      createdAt: DateTime.now(),
      status: IMMessageStatus.sending,
    );

    // 1) 立刻入库 + 上屏（乐观)
    await _storage.upsert(msg);

    // 2) 发到服务端
    final completer = Completer<IMMessage>();
    _pendingAcks[msg.clientMsgId] = completer;
    _socket.send(WsFrame.msg(message: msg));

    // 3) 等待 ACK，10 秒超时算失败
    return completer.future.timeout(
      const Duration(seconds: 10),
      onTimeout: () async {
        _pendingAcks.remove(msg.clientMsgId);
        final failed = msg.copyWith(status: IMMessageStatus.failed);
        await _storage.upsert(failed);
        return failed;
      },
    );
  }

  Future<void> resend(IMMessage msg) async {
    final reset = msg.copyWith(status: IMMessageStatus.sending);
    await _storage.upsert(reset);
    final completer = Completer<IMMessage>();
    _pendingAcks[msg.clientMsgId] = completer;
    _socket.send(WsFrame.msg(message: reset));
  }

  void markRead(String conversationId, String upToMsgId) {
    _socket.send(WsFrame.read(conversationId: conversationId, upToMsgId: upToMsgId));
    _storage.markReadUpTo(conversationId, upToMsgId);
  }

  void _onFrame(WsFrame frame) async {
    switch (frame) {
      case AckFrame(:final clientMsgId, :final serverMsgId, :final serverTime):
        final c = _pendingAcks.remove(clientMsgId);
        final stored = await _storage.byClientMsgId(clientMsgId);
        if (stored != null) {
          final updated = stored.copyWith(
            serverMsgId: serverMsgId,
            createdAt: serverTime,
            status: IMMessageStatus.sent,
          );
          await _storage.upsert(updated);
          c?.complete(updated);
        }
      case MsgFrame(:final message):
        // 收到对方消息（或自己其它端的同步）
        await _storage.upsert(message);
      case ReadFrame(:final conversationId, :final upToMsgId):
        // 对方已读
        await _storage.markPeerRead(conversationId, upToMsgId);
      case ErrorFrame(:final code, :final message):
        print('[IM] error $code: $message');
      default:
        break;
    }
  }

  Future<void> _onState(SocketState s) async {
    if (s == SocketState.connected) {
      // 上线：拉离线消息
      await _pullOfflineMessages();
    }
  }

  /// 上线后调用 HTTP 接口拉取本地最新 msgId 之后的消息（解决离线丢失）
  Future<void> _pullOfflineMessages() async {
    final lastServerMsgId = await _storage.lastServerMsgId();
    final r = await _dio.get('/im/sync', queryParameters: {
      if (lastServerMsgId != null) 'after': lastServerMsgId,
      'limit': 200,
    });
    final messages = (r.data as List).map((e) => IMMessage.fromJson(e as Map<String, dynamic>)).toList();
    for (final m in messages) {
      await _storage.upsert(m);
    }
  }
}
```

---

## 2.6 本地存储（Hive 会话与消息）

```bash
flutter pub add hive hive_flutter
flutter pub add --dev hive_generator build_runner
```

```dart
// lib/features/im/data/im_message_storage.dart
@HiveType(typeId: 1)
class IMMessageEntity {
  @HiveField(0) String clientMsgId;
  @HiveField(1) String? serverMsgId;
  @HiveField(2) String conversationId;
  @HiveField(3) String fromUserId;
  @HiveField(4) String toUserId;
  @HiveField(5) String contentJson;            // 序列化的 IMContent
  @HiveField(6) DateTime createdAt;
  @HiveField(7) String status;                 // IMMessageStatus.name

  IMMessageEntity({
    required this.clientMsgId,
    this.serverMsgId,
    required this.conversationId,
    required this.fromUserId,
    required this.toUserId,
    required this.contentJson,
    required this.createdAt,
    required this.status,
  });
}

class IMMessageStorage {
  late Box<IMMessageEntity> _msgBox;
  late Box _metaBox;

  Future<void> init() async {
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(IMMessageEntityAdapter());
    }
    _msgBox = await Hive.openBox<IMMessageEntity>('im_messages');
    _metaBox = await Hive.openBox('im_meta');
  }

  Future<void> upsert(IMMessage m) async {
    final key = m.clientMsgId;
    final entity = IMMessageEntity(
      clientMsgId: m.clientMsgId,
      serverMsgId: m.serverMsgId,
      conversationId: m.conversationId,
      fromUserId: m.fromUserId,
      toUserId: m.toUserId,
      contentJson: jsonEncode(m.content.toJson()),
      createdAt: m.createdAt,
      status: m.status.name,
    );
    await _msgBox.put(key, entity);

    if (m.serverMsgId != null) {
      final cur = _metaBox.get('lastServerMsgId') as String?;
      if (cur == null || m.serverMsgId!.compareTo(cur) > 0) {
        await _metaBox.put('lastServerMsgId', m.serverMsgId);
      }
    }
  }

  Future<IMMessage?> byClientMsgId(String id) async {
    final e = _msgBox.get(id);
    if (e == null) return null;
    return _toModel(e);
  }

  List<IMMessage> ofConversation(String conversationId) {
    return _msgBox.values
        .where((e) => e.conversationId == conversationId)
        .map(_toModel)
        .toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }

  ValueListenable<Box<IMMessageEntity>> listenable() => _msgBox.listenable();

  Future<String?> lastServerMsgId() async => _metaBox.get('lastServerMsgId') as String?;

  Future<void> markReadUpTo(String convId, String upToMsgId) async {
    // 简化：把本会话内所有 status=sent 的消息改为 read
    for (final e in _msgBox.values.where((x) => x.conversationId == convId)) {
      if (e.status == IMMessageStatus.sent.name) {
        e.status = IMMessageStatus.read.name;
        await e.save();
      }
    }
  }

  Future<void> markPeerRead(String convId, String upToMsgId) async {
    // 类似实现，用于"对方已读"标记
  }

  IMMessage _toModel(IMMessageEntity e) => IMMessage(
    clientMsgId: e.clientMsgId,
    serverMsgId: e.serverMsgId,
    conversationId: e.conversationId,
    fromUserId: e.fromUserId,
    toUserId: e.toUserId,
    content: IMContent.fromJson(jsonDecode(e.contentJson) as Map<String, dynamic>),
    createdAt: e.createdAt,
    status: IMMessageStatus.values.firstWhere((s) => s.name == e.status),
  );
}
```

---

## 2.7 Riverpod 集成与状态层

```dart
// lib/features/im/presentation/im_providers.dart
@Riverpod(keepAlive: true)
Future<IMMessageStorage> imStorage(Ref ref) async {
  final s = IMMessageStorage();
  await s.init();
  return s;
}

@Riverpod(keepAlive: true)
IMSocket imSocket(Ref ref) {
  final socket = IMSocket(
    url: AppEnv.imWsUrl,         // wss://im.yourdomain.com/ws
    tokenProvider: () async {
      final session = await ref.read(secureSessionStorageProvider).read();
      return session?.accessToken;
    },
  );
  // 登录态变化时重连
  ref.listen(authControllerProvider, (prev, next) {
    if (next.valueOrNull != null) {
      socket.connect();
    } else {
      socket.disconnect();
    }
  });
  ref.onDispose(socket.dispose);
  return socket;
}

@Riverpod(keepAlive: true)
Future<IMRepository> imRepository(Ref ref) async {
  final storage = await ref.watch(imStorageProvider.future);
  final socket = ref.watch(imSocketProvider);
  return IMRepository(socket, storage, ref.watch(dioProvider));
}

@riverpod
Stream<List<IMMessage>> conversationMessages(Ref ref, String conversationId) async* {
  final storage = await ref.watch(imStorageProvider.future);
  // 首次输出 + 监听后续变化
  yield storage.ofConversation(conversationId);
  await for (final _ in storage.listenable() as Stream) {
    yield storage.ofConversation(conversationId);
  }
}

@riverpod
SocketState imConnectionState(Ref ref) {
  final socket = ref.watch(imSocketProvider);
  ref.listen(authControllerProvider, (_, __) {});       // 让登录态变化触发重新求值
  return socket.state;
}
```

> 上面 `conversationMessages` 用了 `Stream` 简化，实际可改成 `StreamProvider` + `valueListenable.toStream()`，或者直接 watch Hive box。

---

## 2.8 客服会话 UI

```dart
class CustomerServiceChatPage extends ConsumerStatefulWidget {
  final String conversationId;
  final String myUserId;
  final String peerUserId;
  final String peerName;
  const CustomerServiceChatPage({
    super.key,
    required this.conversationId,
    required this.myUserId,
    required this.peerUserId,
    required this.peerName,
  });

  @override
  ConsumerState<CustomerServiceChatPage> createState() => _CustomerServiceChatPageState();
}

class _CustomerServiceChatPageState extends ConsumerState<CustomerServiceChatPage> {
  final _input = TextEditingController();
  final _scroll = ScrollController();

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    _input.clear();
    final repo = await ref.read(imRepositoryProvider.future);
    await repo.send(
      conversationId: widget.conversationId,
      toUserId: widget.peerUserId,
      content: IMContent.text(text),
      fromUserId: widget.myUserId,
    );
    // 滚到底
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.jumpTo(_scroll.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncMessages = ref.watch(conversationMessagesProvider(widget.conversationId));
    final connState = ref.watch(imConnectionStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.peerName),
            Text(_connText(connState),
                 style: TextStyle(fontSize: 12, color: connState == SocketState.connected ? Colors.green : Colors.orange)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: asyncMessages.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('$e')),
              data: (msgs) => ListView.builder(
                controller: _scroll,
                padding: const EdgeInsets.all(8),
                itemCount: msgs.length,
                itemBuilder: (_, i) => _MessageBubble(message: msgs[i], myUserId: widget.myUserId),
              ),
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey.shade300))),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () => _showTools(context),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _input,
                      decoration: const InputDecoration(hintText: '输入消息...', border: OutlineInputBorder()),
                      maxLines: null,
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.send), onPressed: _send),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _connText(SocketState s) => switch (s) {
    SocketState.connected => '在线',
    SocketState.connecting => '连接中…',
    SocketState.disconnected => '离线',
  };

  void _showTools(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => SizedBox(
        height: 120,
        child: GridView.count(
          crossAxisCount: 4,
          children: const [
            _Tool(icon: Icons.image, label: '图片'),
            _Tool(icon: Icons.shopping_bag, label: '商品'),
            _Tool(icon: Icons.receipt_long, label: '订单'),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends ConsumerWidget {
  final IMMessage message;
  final String myUserId;
  const _MessageBubble({required this.message, required this.myUserId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isMine = message.fromUserId == myUserId;
    final align = isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bubbleColor = isMine ? Theme.of(context).colorScheme.primaryContainer : Colors.grey.shade200;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: align,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.7),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: bubbleColor, borderRadius: BorderRadius.circular(8)),
              child: _renderContent(context),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(_formatTime(message.createdAt), style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
              if (isMine) ...[
                const SizedBox(width: 4),
                _statusIcon(message.status, ref),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderContent(BuildContext ctx) => switch (message.content) {
    TextContent(:final text) => Text(text),
    ImageContent(:final url) => CachedNetworkImage(imageUrl: url, height: 160),
    ProductContent(:final productId, :final title, :final cover, :final priceText) =>
        _ProductCard(productId: productId, title: title, cover: cover, priceText: priceText),
    OrderContent(:final orderId, :final orderNo, :final coverImage, :final summary, :final totalText) =>
        _OrderCard(orderId: orderId, orderNo: orderNo, cover: coverImage, summary: summary, total: totalText),
    SystemContent(:final text) => Text(text, style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
  };

  Widget _statusIcon(IMMessageStatus s, WidgetRef ref) => switch (s) {
    IMMessageStatus.sending => const SizedBox(width: 12, height: 12, child: CircularProgressIndicator(strokeWidth: 1.5)),
    IMMessageStatus.failed => GestureDetector(
      onTap: () async => (await ref.read(imRepositoryProvider.future)).resend(message),
      child: const Icon(Icons.error, size: 12, color: Colors.red),
    ),
    IMMessageStatus.sent => Icon(Icons.check, size: 12, color: Colors.grey.shade500),
    IMMessageStatus.read => Icon(Icons.done_all, size: 12, color: Colors.blue.shade400),
  };

  String _formatTime(DateTime dt) => '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}
```

---

## 2.9 商品卡片 / 订单卡片消息

```dart
class _ProductCard extends StatelessWidget {
  final String productId;
  final String title;
  final String cover;
  final String priceText;
  const _ProductCard({required this.productId, required this.title, required this.cover, required this.priceText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ProductDetailRoute(id: productId).push(context),
      child: SizedBox(
        width: 220,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedNetworkImage(imageUrl: cover, width: 60, height: 60, fit: BoxFit.cover),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13)),
                  Text(priceText, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
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

业务集成：用户在商品详情页点"咨询客服"，传入 productId，自动发送一条 ProductContent 消息：

```dart
Future<void> openCustomerServiceWithProduct(BuildContext ctx, WidgetRef ref, Product p) async {
  final repo = await ref.read(imRepositoryProvider.future);
  final me = ref.read(currentUserProvider);
  if (me == null) return;
  await repo.send(
    conversationId: 'cs-merchant-001',
    toUserId: 'merchant-001',
    fromUserId: me.id,
    content: IMContent.product(
      productId: p.id,
      title: p.title,
      cover: p.images.firstOrNull ?? '',
      priceText: p.price.format(),
    ),
  );
  if (ctx.mounted) {
    ChatRoute(conversationId: 'cs-merchant-001').push(ctx);
  }
}
```

---

## 2.10 三方 IM SDK 接入指南

如果你不想自建，下面是三家国内主流方案的对比与接入要点：

| 平台 | 优点 | 缺点 | Flutter 包 |
| --- | --- | --- | --- |
| **腾讯云 IM** | 文档全、SDK 稳定、生态强 | 文档有点繁、接入步骤多 | `tencent_cloud_chat`（官方） |
| **网易云信** | 商业产品成熟、客服侧 SaaS 完整 | 价格略高 | `nim_core_v2`（官方） |
| **LeanCloud** | 接入简单、中小型项目友好 | 国际化、支持力度变化 | 社区包 |
| **环信 EaseIMKit** | UI 一体化方案 | 强耦合 | 官方 |

### 腾讯云 IM 极简接入

```bash
flutter pub add tencent_cloud_chat tencent_cloud_chat_sdk
```

```dart
// 启动初始化
await TencentCloudChat.controller.initUIKit(
  config: TencentCloudChatConfig(
    sdkAppID: 1400000000,
    userID: currentUser.id,
    userSig: '<服务端生成>',
  ),
);

// 进入会话
TencentCloudChatNavigator.navigateTo(
  page: TencentCloudChatNavigatorPage.message,
  conversationID: 'c2c_merchant_001',
);
```

> 三方 SDK 的优势：消息可靠性、群、音视频等问题都帮你解决；劣势：定制空间小、依赖大、迁移成本高。**电商客服场景选三方完全合理**，自建是给社交 / IM 中台团队的事。

---

## 2.11 IM 常见坑

1. **WebSocket 在 iOS 后台 30 秒后会被系统挂起** → 后台通过 APNs 推送代替；返回前台立刻拉同步。
2. **消息时序错乱** → 服务端必须给每条消息单调递增 `serverMsgId`；客户端按 serverMsgId 排序，本地未确认的消息按 createdAt 插队。
3. **重复消息** → 用 `clientMsgId` 做幂等，已存在就 update。
4. **多端同步** → 同一用户多设备同时在线，服务端要把消息扩散到所有连接。
5. **Hive box 不要在 isolate 间共享**：每个 isolate 单独 open。
6. **Token 过期**：401 时关闭连接，刷新 token 后重连。

---

# Part 3 · 推送通知

## 3.1 通道决策（APNs / FCM / 厂商 / 聚合）

```
你的目标用户在？
│
├─ 海外（包括有 Google 服务的安卓机）
│   ├─ iOS → APNs（苹果直推）
│   └─ Android → FCM（Firebase Cloud Messaging）
│
└─ 国内
    ├─ iOS → APNs
    └─ Android → 必须用厂商通道，否则杀进程后收不到
        ├─ 直接接：HMS（华为）、OPush、mPush（小米）、VPush（vivo）、荣耀
        ├─ 聚合 SDK：极光 JPush / 个推 GeTui / 友盟 UPush（推荐！省事）
        └─ 国内 FCM 在没 GMS 的设备完全不可用
```

**推荐组合**：
- **海外 / 多端**：firebase_messaging（一套 SDK 同时管 APNs 和 FCM）
- **国内为主**：极光 JPush 或 个推（聚合厂商通道，省去六家分别接入）

---

## 3.2 整体架构

```
┌────────────┐     1. 上报 device_token     ┌──────────────┐
│  Flutter   │ ────────────────────────────>│  你的后端    │
│   App      │                              │              │
└────┬───────┘                              └──────┬───────┘
     │ 注册                                        │ 触发推送
     │                                             │ (新订单/客服消息/营销)
     ▼                                             ▼
┌────────────┐                              ┌──────────────┐
│ APNs / FCM │ <──────────────────────────  │ 推送平台/SDK │
│ /厂商通道  │                              │  Server      │
└────┬───────┘                              └──────────────┘
     │ 系统推送
     ▼
┌────────────┐
│   设备     │ → 显示通知 → 用户点击 → 打开 App / 跳转页面
└────────────┘
```

---

## 3.3 iOS：APNs 配置

1. **Apple Developer**：
   - Identifiers → 你的 App ID → 启用 "Push Notifications"。
   - Keys → 创建 APNs Auth Key（`.p8` 文件）。**这个 key 给后端用，不放 App 里**。
2. **Xcode**：
   - Signing & Capabilities → `+` → Push Notifications。
   - 同时加 `Background Modes` → Remote notifications（用于静默推送）。
3. 真机才能测试 APNs（模拟器 iOS 16+ 才支持）。

---

## 3.4 Android：FCM 配置

1. **Firebase Console**：
   - 创建项目 → 添加 Android App（包名一致）。
   - 下载 `google-services.json` 放入 `android/app/`。
2. **Gradle**：
   ```groovy
   // android/build.gradle
   buildscript {
       dependencies {
           classpath 'com.google.gms:google-services:4.4.2'
       }
   }
   // android/app/build.gradle
   apply plugin: 'com.google.gms.google-services'
   ```
3. **iOS 也用 Firebase？** 同步加 `GoogleService-Info.plist`。

---

## 3.5 Flutter 端集成（firebase_messaging + flutter_local_notifications）

```bash
flutter pub add firebase_core firebase_messaging flutter_local_notifications
```

### 3.5.1 初始化

```dart
// lib/core/push/push_service.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// 后台 isolate 入口（必须 top-level）
@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  // 后台/被杀状态下，系统会拉起这个 isolate
  // 注意：这里不能用 Riverpod；记日志/落库即可
  print('[push:bg] ${message.messageId} ${message.data}');
}

class PushService {
  late FlutterLocalNotificationsPlugin _local;
  final void Function(Map<String, dynamic> data) onTap;

  PushService({required this.onTap});

  Future<void> init() async {
    await Firebase.initializeApp();

    // 1) 申请通知权限（iOS / Android 13+）
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true, badge: true, sound: true, provisional: false,
    );
    print('[push] permission: ${settings.authorizationStatus}');

    // 2) 后台消息处理器
    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

    // 3) 初始化本地通知插件（用于前台手动展示通知）
    _local = FlutterLocalNotificationsPlugin();
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    await _local.initialize(
      const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (resp) {
        if (resp.payload != null) {
          final data = jsonDecode(resp.payload!) as Map<String, dynamic>;
          onTap(data);
        }
      },
    );

    // 4) 创建 Android 通知渠道
    await _local
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(const AndroidNotificationChannel(
          'main_channel',
          '默认通知',
          description: '应用通知',
          importance: Importance.high,
        ));

    // 5) 前台收到推送
    FirebaseMessaging.onMessage.listen((m) async {
      final notif = m.notification;
      if (notif != null) {
        await _showLocal(notif.title, notif.body, m.data);
      }
    });

    // 6) 用户从通知中点击进入 App
    FirebaseMessaging.onMessageOpenedApp.listen((m) => onTap(m.data));

    // 7) App 是被通知冷启动？
    final initialMsg = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMsg != null) {
      // 延迟到首帧之后处理（避免路由还没初始化）
      WidgetsBinding.instance.addPostFrameCallback((_) => onTap(initialMsg.data));
    }
  }

  Future<void> _showLocal(String? title, String? body, Map<String, dynamic> data) async {
    await _local.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails('main_channel', '默认通知', importance: Importance.high, priority: Priority.high),
        iOS: DarwinNotificationDetails(),
      ),
      payload: jsonEncode(data),
    );
  }

  Future<String?> getDeviceToken() async {
    return FirebaseMessaging.instance.getToken();
  }

  Stream<String> get onTokenRefresh => FirebaseMessaging.instance.onTokenRefresh;
}
```

### 3.5.2 启动早期初始化

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ...
  runApp(const ProviderScope(child: App()));
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    // 初始化推送（需要拿到 router 才能跳转）
    Future.microtask(() async {
      final push = PushService(onTap: (data) => _handleTap(data));
      await push.init();
      ref.read(pushServiceProvider).set(push);
    });
  }

  void _handleTap(Map<String, dynamic> data) {
    // 见 §3.7
  }
}
```

---

## 3.6 Token 上报与生命周期

```dart
@Riverpod(keepAlive: true)
class PushTokenSync extends _$PushTokenSync {
  @override
  Future<void> build() async {
    final push = ref.watch(pushServiceProvider);

    // 用户登录后才上报
    ref.listen(authControllerProvider, (prev, next) async {
      if (next.valueOrNull != null) {
        await _upload(push);
      }
    });

    // Token 刷新（系统重置）也要上报
    push.onTokenRefresh.listen((newToken) async {
      if (ref.read(authControllerProvider).valueOrNull != null) {
        await ref.read(dioProvider).post('/users/me/devices', data: {'token': newToken, 'platform': _platform()});
      }
    });
  }

  Future<void> _upload(PushService push) async {
    final token = await push.getDeviceToken();
    if (token == null) return;
    await ref.read(dioProvider).post('/users/me/devices', data: {
      'token': token,
      'platform': _platform(),
      'appVersion': AppEnv.version,
    });
  }

  String _platform() {
    if (kIsWeb) return 'web';
    return defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';
  }
}
```

> ⚠️ 退出登录时记得调 `DELETE /users/me/devices`，否则前用户继续收新用户的推送。

---

## 3.7 通知点击跳转 + 深链接

服务端推送时附加 `data` payload：

```json
{
  "notification": {"title": "新订单", "body": "您有一笔订单待支付"},
  "data": {
    "type": "ORDER",
    "orderId": "o-001",
    "deeplink": "/orders/o-001"
  }
}
```

App 处理：

```dart
void _handleTap(Map<String, dynamic> data) {
  final type = data['type'] as String?;
  switch (type) {
    case 'ORDER':
      final orderId = data['orderId'] as String;
      OrderDetailRoute(id: orderId).push(navigatorKey.currentContext!);
      break;
    case 'CHAT':
      final convId = data['conversationId'] as String;
      ChatRoute(conversationId: convId).push(navigatorKey.currentContext!);
      break;
    case 'CAMPAIGN':
      final url = data['deeplink'] as String;
      navigatorKey.currentContext!.go(url);
      break;
    default:
      navigatorKey.currentContext!.go('/home');
  }
}
```

> 💡 用 go_router 时，`router.go(deeplink)` 一行直接消费 deeplink。

---

## 3.8 国内厂商通道（HMS / OPush / mPush / VPush）

国内 Android 系统会**杀掉非系统白名单的进程**，只有走厂商通道才能保证应用被杀后还能收到推送。

每家流程类似：
1. 在厂商开放平台注册 App，拿 AppKey / AppSecret。
2. 集成厂商 SDK（每家一个 SDK，互不兼容）。
3. 拿到的 token 上报到自有后端。
4. 后端调厂商 push API。

**手撸成本极高**——所以推荐聚合方案。

---

## 3.9 极光 / 个推聚合方案

```bash
flutter pub add jpush_flutter
# 或
flutter pub add getuiflut
```

聚合 SDK 内部已经接入了 6 大厂商通道：你只调 JPush API，它选最合适的通道下发。

### JPush 接入示例

```dart
import 'package:jpush_flutter/jpush_flutter.dart';

final jpush = JPush();

await jpush.setup(
  appKey: 'YOUR_APPKEY',
  channel: 'developer-default',
  production: kReleaseMode,
);

// 拿到 RegistrationID（极光的设备唯一 ID，给后端用）
jpush.getRegistrationID().then((rid) {
  // 上报后端
});

// 收到推送
jpush.addEventHandler(
  onReceiveNotification: (msg) async => print('[jpush] $msg'),
  onOpenNotification: (msg) async {
    final data = msg['extras'] as Map?;
    _handleTap(Map<String, dynamic>.from(data ?? {}));
  },
);
```

> 💡 极光控制台后台还可以发**应用内消息**、**A/B 测试**、**RFM 分群**等运营功能，比纯通道方便。

---

## 3.10 静默推送 / 角标 / 自定义声音

### 静默推送（不显示通知，只让 App 知道有事）

服务端发：

```json
{
  "data": {"type": "SYNC_NEW_MESSAGES"},
  "apns": {"headers": {"apns-priority": "5"}, "payload": {"aps": {"content-available": 1}}},
  "android": {"priority": "high"}
}
```

App 端：

```dart
FirebaseMessaging.onMessage.listen((m) async {
  if (m.notification == null) {
    // 这就是静默推送
    if (m.data['type'] == 'SYNC_NEW_MESSAGES') {
      ref.read(imRepositoryProvider).pullOfflineMessages();
    }
  }
});
```

> ⚠️ iOS 静默推送会被系统**限频**（每小时 2-3 条），不能当 IM 用。

### 角标

```dart
// 用 flutter_app_badger 或 flutter_local_notifications
import 'package:flutter_app_badger/flutter_app_badger.dart';

await FlutterAppBadger.updateBadgeCount(unreadCount);
```

### 自定义声音

iOS：把 `.caf` 文件加进 Xcode，推送 payload 里 `aps.sound = 'custom.caf'`。
Android：放在 `res/raw/`，通知渠道创建时指定。

---

## 3.11 推送策略与坑点

### 策略
- **及时性强（IM、订单状态）**：实时通道 + 弹通知。
- **批量营销**：服务端用消息队列限流，避免下发风暴。
- **频率控制**：单用户每天 ≤ 3 条营销，否则用户关推送。
- **静默时段**：22:00 ~ 8:00 不发非紧急通知（用户体验关键）。

### 坑
1. **iOS 用户拒绝通知后无法补救**：Settings → 通知开启需要用户主动操作；用 `permission_handler` 引导。
2. **Android 13+ 必须运行时申请权限**：`Manifest.permission.POST_NOTIFICATIONS`。
3. **国内安卓机不接厂商通道 = 杀进程后丢推**：测试时一定要杀掉进程再发推送。
4. **冷启动消息丢失**：`getInitialMessage()` 可能在 router 初始化前调，必须 `addPostFrameCallback`。
5. **重复推送**：服务端要做幂等（同一事件不要重复发）。
6. **token 不会立刻有**：第一次启动 + 申请权限期间 `getToken()` 可能返回 null，要监听 `onTokenRefresh`。

---

# Part 4 · 数据上报与埋点

## 4.1 平台决策

| 平台 | 优势 | 适合 |
| --- | --- | --- |
| **神策** | 国内业界标准、字段级控制、私有部署 | 中大型 ToC，重数据团队 |
| **友盟 U-App** | 接入简单、免费、看板成熟 | 中小型 ToC，一站式 |
| **GrowingIO** | 自动埋点强、免运维 | 运营驱动型产品 |
| **Firebase Analytics** | 海外标配、与 Crashlytics 联动 | 海外业务 |
| **Mixpanel / Amplitude** | 留存漏斗自由度高 | 海外、产品驱动 |
| **数数科技 ThinkingData** | 游戏行业老大 | 游戏 |
| **自建（Kafka + ClickHouse + 自研 SDK）** | 完全可控 | 大厂、对数据强需求 |

**推荐组合**：国内业务 = **神策 + 友盟（崩溃）**；海外 = **Firebase Analytics + Sentry**。

---

## 4.2 埋点架构总览

无论后端哪家，**App 端的事件抽象层应该自己掌握**，避免被 SDK 锁定。

```
业务代码                  事件总线                后端
┌─────────────┐          ┌──────────┐          ┌────────────┐
│ Page / WG   │ track()  │ Event    │ flush()  │ 神策       │
│ Notifier    │ ───────> │ Bus      │ ───────> │ 友盟       │
│             │          │  ↓       │          │ Firebase   │
└─────────────┘          │ Buffer   │          │ Self-host  │
                         │ ↓        │          └────────────┘
                         │ Batch    │
                         └──────────┘
```

业务只关心 `track('event_name', {...})`，下面的多通道分发由"事件总线"统一处理。

---

## 4.3 事件总线（核心）

### 4.3.1 接口

```dart
// lib/core/analytics/analytics.dart
abstract interface class AnalyticsSink {
  Future<void> track({
    required String event,
    required Map<String, Object?> properties,
  });
  Future<void> identify({required String userId, Map<String, Object?>? userProps});
  Future<void> setUserProperty(String key, Object? value);
  Future<void> reset();
}
```

### 4.3.2 多通道聚合

```dart
class CompositeAnalytics implements AnalyticsSink {
  final List<AnalyticsSink> _sinks;
  CompositeAnalytics(this._sinks);

  @override
  Future<void> track({required String event, required Map<String, Object?> properties}) async {
    await Future.wait(_sinks.map((s) => s.track(event: event, properties: properties).catchError((e) {
      print('[analytics] sink failed: $e');     // 一家失败不影响其他
    })));
  }

  @override
  Future<void> identify({required String userId, Map<String, Object?>? userProps}) async {
    await Future.wait(_sinks.map((s) => s.identify(userId: userId, userProps: userProps)));
  }

  @override
  Future<void> setUserProperty(String key, Object? value) async {
    await Future.wait(_sinks.map((s) => s.setUserProperty(key, value)));
  }

  @override
  Future<void> reset() async {
    await Future.wait(_sinks.map((s) => s.reset()));
  }
}
```

### 4.3.3 总入口（业务代码只接触这个）

```dart
// lib/core/analytics/track.dart
class Track {
  final AnalyticsSink _sink;
  final ContextProvider _context;
  Track(this._sink, this._context);

  Future<void> event(String name, [Map<String, Object?> props = const {}]) async {
    final merged = {
      ..._context.commonProperties(),
      ...props,
    };
    await _sink.track(event: name, properties: merged);
  }

  // 业务封装
  Future<void> productView(String productId, String title) =>
      event('product_view', {'product_id': productId, 'product_title': title});

  Future<void> addToCart(String productId, String skuId, int qty, int totalCents) =>
      event('add_to_cart', {
        'product_id': productId, 'sku_id': skuId, 'quantity': qty, 'total_cents': totalCents,
      });

  Future<void> orderSubmit(String orderId, int totalCents, String paymentMethod) =>
      event('order_submit', {'order_id': orderId, 'total_cents': totalCents, 'payment_method': paymentMethod});

  Future<void> orderPaid(String orderId, int totalCents) =>
      event('order_paid', {'order_id': orderId, 'total_cents': totalCents});

  Future<void> search(String keyword, int resultCount) =>
      event('search', {'keyword': keyword, 'result_count': resultCount});
}
```

### 4.3.4 Riverpod 注入

```dart
@Riverpod(keepAlive: true)
AnalyticsSink analyticsSink(Ref ref) {
  return CompositeAnalytics([
    SensorsAnalyticsSink(),
    FirebaseAnalyticsSink(),
    if (kDebugMode) ConsoleAnalyticsSink(),       // 开发期打印
  ]);
}

@Riverpod(keepAlive: true)
Track track(Ref ref) {
  return Track(
    ref.watch(analyticsSinkProvider),
    ContextProvider(ref),
  );
}
```

---

## 4.4 公共属性 / 上下文

每条事件都应自动带上：用户 ID、App 版本、平台、网络类型、渠道、locale 等。

```dart
class ContextProvider {
  final Ref _ref;
  ContextProvider(this._ref);

  Map<String, Object?> commonProperties() {
    final user = _ref.read(currentUserProvider);
    final theme = _ref.read(themeModeProvider).valueOrNull;
    return {
      'user_id': user?.id,
      'is_logged_in': user != null,
      'app_version': AppEnv.version,
      'app_channel': AppEnv.channel,
      'platform': _platform(),
      'os_version': Platform.operatingSystemVersion,
      'locale': PlatformDispatcher.instance.locale.toString(),
      'theme': theme?.name,
      'timestamp_ms': DateTime.now().millisecondsSinceEpoch,
    };
  }

  String _platform() {
    if (kIsWeb) return 'web';
    return defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android';
  }
}
```

> 💡 这些字段在神策叫 "公共属性"，在 GA 叫 "User Properties"，在 Mixpanel 叫 "Super Properties"。各家叫法不同，**App 端统一管理就好**。

---

## 4.5 自动埋点：路由曝光

每次页面进入自动发一条 `screen_view`。go_router 装一个 NavigatorObserver：

```dart
// lib/core/analytics/track_observer.dart
class TrackObserver extends NavigatorObserver {
  final Track track;
  TrackObserver(this.track);

  @override
  void didPush(Route route, Route? previousRoute) {
    _send(route, 'screen_view');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (newRoute != null) _send(newRoute, 'screen_view');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    if (previousRoute != null) _send(previousRoute, 'screen_back');
  }

  void _send(Route route, String event) {
    final name = route.settings.name ?? '<anonymous>';
    track.event(event, {
      'route_name': name,
      'route_args': route.settings.arguments?.toString(),
    });
  }
}
```

注入 go_router：

```dart
GoRouter(
  observers: [TrackObserver(ref.read(trackProvider))],
  // ...
)
```

---

## 4.6 自动埋点：Widget 曝光（VisibilityDetector）

商品卡片"曝光"事件（用户看到才算）：

```bash
flutter pub add visibility_detector
```

```dart
class TrackedProductCard extends ConsumerWidget {
  final Product product;
  final String source;       // home / search / category
  const TrackedProductCard({super.key, required this.product, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VisibilityDetector(
      key: Key('product-${product.id}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5) {
          // 一次性事件：用 Notifier 状态防重复
          ref.read(productImpressionTrackerProvider.notifier).fire(product.id, source);
        }
      },
      child: ProductCard(product: product),
    );
  }
}

@riverpod
class ProductImpressionTracker extends _$ProductImpressionTracker {
  final _fired = <String>{};        // 一次会话只发一次

  @override
  void build() {}

  void fire(String productId, String source) {
    final key = '$productId:$source';
    if (_fired.contains(key)) return;
    _fired.add(key);
    ref.read(trackProvider).event('product_impression', {
      'product_id': productId,
      'source': source,
    });
  }
}
```

---

## 4.7 业务手动埋点

业务关键节点必须手动埋（自动埋点抓不到上下文）：

```dart
// 商品详情页
class ProductDetailPage extends ConsumerStatefulWidget {
  final String id;
  const ProductDetailPage({super.key, required this.id});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
    // 进入页面时埋点（路由级 screen_view 之外的业务事件）
    Future.microtask(() {
      final detail = ref.read(productDetailProvider(widget.id)).valueOrNull;
      if (detail != null) {
        ref.read(trackProvider).productView(widget.id, detail.base.title);
      }
    });
  }
  // ...
}

// 加购按钮
ElevatedButton(
  onPressed: () async {
    await ref.read(cartControllerProvider.notifier).add(skuId, qty);
    await ref.read(trackProvider).addToCart(productId, skuId, qty, totalCents);
  },
  child: const Text('加入购物车'),
)

// 下单成功
PayResult result = await pay();
if (result is PaySuccess) {
  await ref.read(trackProvider).orderPaid(orderId, totalCents);
}
```

---

## 4.8 上报策略（实时 / 批量 / 弱网兜底）

### 默认策略：批量 + 弱网兜底

```dart
class BufferedAnalyticsSink implements AnalyticsSink {
  final AnalyticsSink _delegate;
  final Duration flushInterval;
  final int maxBufferSize;
  final List<_Event> _buffer = [];
  Timer? _timer;

  BufferedAnalyticsSink(this._delegate, {this.flushInterval = const Duration(seconds: 10), this.maxBufferSize = 50}) {
    _timer = Timer.periodic(flushInterval, (_) => _flush());
  }

  @override
  Future<void> track({required String event, required Map<String, Object?> properties}) async {
    _buffer.add(_Event(event, properties));
    if (_buffer.length >= maxBufferSize) {
      await _flush();
    }
  }

  Future<void> _flush() async {
    if (_buffer.isEmpty) return;
    final batch = List<_Event>.from(_buffer);
    _buffer.clear();
    try {
      for (final e in batch) {
        await _delegate.track(event: e.event, properties: e.properties);
      }
    } catch (_) {
      // 失败放回（带上限避免无限增长）
      if (_buffer.length + batch.length < maxBufferSize * 2) {
        _buffer.insertAll(0, batch);
      }
    }
  }

  // identify / reset / setUserProperty 透传
  @override
  Future<void> identify({required String userId, Map<String, Object?>? userProps}) =>
      _delegate.identify(userId: userId, userProps: userProps);
  @override
  Future<void> setUserProperty(String key, Object? value) => _delegate.setUserProperty(key, value);
  @override
  Future<void> reset() => _delegate.reset();
}

class _Event {
  final String event;
  final Map<String, Object?> properties;
  _Event(this.event, this.properties);
}
```

### 退到后台时强制 flush

```dart
class _AppLifecycleHandler with WidgetsBindingObserver {
  final BufferedAnalyticsSink sink;
  _AppLifecycleHandler(this.sink) {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused || state == AppLifecycleState.hidden) {
      sink._flush();
    }
  }
}
```

### 关键事件实时上报

下单、支付这种高价值事件**不要进 buffer**：

```dart
class _DirectImportantEvents implements AnalyticsSink {
  // 把 order_paid / register / first_purchase 之类直接落库
}

// 在 CompositeAnalytics 里再分一层即可
```

---

## 4.9 多通道适配（神策 / 友盟 / Firebase）

### 神策

```bash
flutter pub add sensors_analytics_flutter_plugin
```

```dart
class SensorsAnalyticsSink implements AnalyticsSink {
  Future<void> init() async {
    await SensorsAnalyticsFlutterPlugin.init(serverUrl: 'https://your-sa-server/sa', isDebug: kDebugMode);
  }

  @override
  Future<void> track({required String event, required Map<String, Object?> properties}) async {
    await SensorsAnalyticsFlutterPlugin.track(event, properties);
  }

  @override
  Future<void> identify({required String userId, Map<String, Object?>? userProps}) async {
    await SensorsAnalyticsFlutterPlugin.login(userId);
    if (userProps != null) {
      await SensorsAnalyticsFlutterPlugin.profileSet(userProps);
    }
  }

  @override
  Future<void> setUserProperty(String key, Object? value) async {
    await SensorsAnalyticsFlutterPlugin.profileSet({key: value});
  }

  @override
  Future<void> reset() async {
    await SensorsAnalyticsFlutterPlugin.logout();
  }
}
```

### 友盟 UMeng

```bash
flutter pub add umeng_common_sdk
```

```dart
class UmengAnalyticsSink implements AnalyticsSink {
  Future<void> init() async {
    UmengCommonSdk.initCommon('IOS_APPKEY', 'ANDROID_APPKEY', 'channel-default');
  }

  @override
  Future<void> track({required String event, required Map<String, Object?> properties}) async {
    final stringMap = properties.map((k, v) => MapEntry(k, '$v'));
    await UmengCommonSdk.onEvent(event, stringMap);
  }

  // identify / setUserProperty / reset 类似
}
```

### Firebase Analytics

```bash
flutter pub add firebase_analytics
```

```dart
class FirebaseAnalyticsSink implements AnalyticsSink {
  final _fa = FirebaseAnalytics.instance;

  @override
  Future<void> track({required String event, required Map<String, Object?> properties}) async {
    // Firebase 限制 event name 40 字符 / property 25 个 / value 100 字符
    final filtered = <String, Object>{};
    properties.forEach((k, v) {
      if (v != null) filtered[k] = v;
    });
    await _fa.logEvent(name: _normalize(event), parameters: filtered);
  }

  @override
  Future<void> identify({required String userId, Map<String, Object?>? userProps}) async {
    await _fa.setUserId(id: userId);
    if (userProps != null) {
      for (final entry in userProps.entries) {
        await _fa.setUserProperty(name: entry.key, value: '${entry.value}');
      }
    }
  }

  @override
  Future<void> setUserProperty(String key, Object? value) =>
      _fa.setUserProperty(name: key, value: '$value');

  @override
  Future<void> reset() => _fa.setUserId(id: null);

  String _normalize(String s) => s.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_').substring(0, math.min(s.length, 40));
}
```

> ⚠️ Firebase 对事件 / 参数命名有严格限制：只能字母数字下划线，事件名不能以 `firebase_` / `google_` 开头。**前期定义统一规范**很重要。

### 控制台 Sink（开发期）

```dart
class ConsoleAnalyticsSink implements AnalyticsSink {
  @override
  Future<void> track({required String event, required Map<String, Object?> properties}) async {
    print('[analytics] $event ${properties.entries.where((e) => e.value != null).map((e) => '${e.key}=${e.value}').join(' ')}');
  }
  @override
  Future<void> identify({required String userId, Map<String, Object?>? userProps}) async {
    print('[analytics] identify $userId $userProps');
  }
  @override
  Future<void> setUserProperty(String key, Object? value) async {
    print('[analytics] property $key=$value');
  }
  @override
  Future<void> reset() async => print('[analytics] reset');
}
```

---

## 4.10 隐私合规与用户同意

### 4.10.1 法规

| 地区 | 关键法规 |
| --- | --- |
| 中国大陆 | 《个人信息保护法》《数据安全法》《App 收集使用个人信息合规要求》 |
| 欧盟 | GDPR |
| 美国加州 | CCPA / CPRA |
| 苹果 | App Tracking Transparency (ATT) + Privacy Manifest |
| 谷歌 | Data safety section（Play Console 必填） |

### 4.10.2 同意管理（CMP）

打开 App 时弹出"同意接收 cookie / 上报"等：

```dart
// 简化的同意状态
@riverpod
class ConsentController extends _$ConsentController {
  @override
  Future<bool> build() async {
    final sp = await ref.watch(sharedPrefsProvider.future);
    return sp.getBool('analytics_consent') ?? false;
  }

  Future<void> grant() async {
    final sp = await ref.read(sharedPrefsProvider.future);
    await sp.setBool('analytics_consent', true);
    state = const AsyncData(true);
  }

  Future<void> revoke() async {
    final sp = await ref.read(sharedPrefsProvider.future);
    await sp.setBool('analytics_consent', false);
    state = const AsyncData(false);
    await ref.read(analyticsSinkProvider).reset();
  }
}
```

`Track.event` 加守卫：

```dart
Future<void> event(String name, [Map<String, Object?> props = const {}]) async {
  final consent = _ref.read(consentControllerProvider).valueOrNull ?? false;
  if (!consent) return;     // 没同意，不上报
  // ...
}
```

### 4.10.3 iOS ATT

iOS 14.5+ 想拿 IDFA（广告归因 ID），必须弹 ATT 提示：

```bash
flutter pub add app_tracking_transparency
```

```dart
final status = await AppTrackingTransparency.requestTrackingAuthorization();
if (status == TrackingStatus.authorized) {
  // 允许追踪 → 上报 IDFA
}
```

`Info.plist` 必加：

```xml
<key>NSUserTrackingUsageDescription</key>
<string>我们使用您的活动数据为您推荐更好的商品</string>
```

### 4.10.4 Privacy Manifest（iOS 17+ 强制）

`PrivacyInfo.xcprivacy`：声明你访问的"敏感 API"和"数据收集类别"。

模板（电商常见）：

```xml
<dict>
  <key>NSPrivacyTracking</key><false/>
  <key>NSPrivacyCollectedDataTypes</key>
  <array>
    <dict>
      <key>NSPrivacyCollectedDataType</key><string>NSPrivacyCollectedDataTypeDeviceID</string>
      <key>NSPrivacyCollectedDataTypeLinked</key><true/>
      <key>NSPrivacyCollectedDataTypeTracking</key><false/>
      <key>NSPrivacyCollectedDataTypePurposes</key>
      <array><string>NSPrivacyCollectedDataTypePurposeAnalytics</string></array>
    </dict>
    <!-- email / userID / 浏览历史 等 -->
  </array>
  <key>NSPrivacyAccessedAPITypes</key>
  <array>
    <dict>
      <key>NSPrivacyAccessedAPIType</key><string>NSPrivacyAccessedAPICategoryUserDefaults</string>
      <key>NSPrivacyAccessedAPITypeReasons</key><array><string>CA92.1</string></array>
    </dict>
  </array>
</dict>
```

---

## 4.11 与崩溃 / 性能监控的关系（Sentry / Bugly）

埋点关注"用户做了什么"，崩溃关注"App 出了什么错"。两套系统**独立但要联动**。

```bash
flutter pub add sentry_flutter
```

```dart
Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://your-dsn@sentry.io/123';
      options.environment = AppEnv.env;
      options.release = AppEnv.version;
      options.tracesSampleRate = 0.2;     // 性能监控采样
    },
    appRunner: () => runApp(const ProviderScope(child: App())),
  );
}

// 业务里手动上报
try {
  await dangerous();
} catch (e, st) {
  await Sentry.captureException(e, stackTrace: st);
  rethrow;
}
```

**联动思路**：
- 埋点的 `user_id` 与 Sentry 的 `user.id` 保持一致 → 在 Sentry 里看用户事件序列。
- 关键事件（崩溃、支付失败）同时打到神策 → 既看用户路径又看技术故障。

国内主流替代：**Bugly**（腾讯，免费）、**友盟错误分析**。

---

## 4.12 埋点验收与排查

### 验收（最容易翻车的环节）

埋点最大的问题是**"埋了没传 / 传了没字段 / 字段拼错"**。验收三板斧：

1. **本地控制台 Sink 实时打印**：开发期一眼看出有没有发出。
2. **服务端实时调试通道**：神策 / 友盟 / GA 都有"调试模式"，事件秒级到看板，方便对照。
3. **专门的 QA 校对表**：每个事件 + 每个字段一行，QA 按表点完所有路径核对。

### 常见问题排查

| 现象 | 可能原因 |
| --- | --- |
| 事件全无 | Consent 未授权 / SDK 初始化失败 / 网络拦截 |
| 部分用户少事件 | App 杀进程没 flush / 弱网失败 |
| 字段缺失 | 模型变了忘了改埋点 |
| user_id 不准 | 登录前事件无 user_id；登录后没 identify |
| 数据延迟 | 批量上报间隔太长 |

### 黄金法则

- **事件名用动词 + 名词，全小写下划线**：`product_view` / `order_paid` / `search_executed`。
- **属性命名风格全局一致**：`product_id` 而不是 `productId`/`pid`/`product`。
- **金额永远用分（int）传**：避免 0.1 + 0.2 浮点误差。
- **建立"事件字典"**：在 Notion / 飞书维护一份，新增事件先查字典；参考文末附录的电商事件清单。

### 电商核心事件清单（拿走可用）

| 事件名 | 触发时机 | 关键属性 |
| --- | --- | --- |
| `app_launch` | App 启动 | `cold/warm`, `launch_ms` |
| `screen_view` | 路由进入 | `route_name`, `from` |
| `product_impression` | 商品卡曝光 | `product_id`, `source`, `position` |
| `product_view` | 进商品详情 | `product_id`, `from` |
| `add_to_cart` | 加入购物车 | `product_id`, `sku_id`, `quantity`, `total_cents` |
| `cart_view` | 进购物车 | `item_count`, `total_cents` |
| `checkout_start` | 进结算页 | `item_count`, `total_cents` |
| `coupon_applied` | 应用优惠券 | `coupon_id`, `discount_cents` |
| `address_select` | 选地址 | — |
| `order_submit` | 提交订单 | `order_id`, `total_cents`, `payment_method` |
| `order_paid` | 支付成功 | `order_id`, `total_cents`, `payment_method` |
| `order_cancelled` | 取消订单 | `order_id`, `reason` |
| `search` | 搜索 | `keyword`, `result_count` |
| `register` | 注册 | `provider`(apple/google/email) |
| `login` | 登录 | `provider` |
| `logout` | 退出 | — |
| `share` | 分享 | `target_type`, `target_id`, `channel` |

---

# 附录 X：仍待你拍板的开放问题

四个专题都给了"完整可落地"骨架，但每家具体业务规模不同，下列细节按你的实际情况二选一或更精细化：

### 关于支付
1. **国内电商主体**：是公司自有的还是接微信小程序聚合？
2. **会员订阅**：要不要做？（涉及 IAP / Google Subscription 的续费、宽限期处理）
3. **退款流程**：用户能否在 App 内主动申请退款？还是导回客服？
4. **风控**：支付前是否要二次身份验证（短信、面容）？

### 关于 IM
5. **客服形态**：单一商家客服（1 vs 多），还是平台模式（多商家各自客服）？
6. **群聊**：是否需要？群聊大幅复杂化（成员管理、群消息扩散、@提醒）。
7. **消息留存**：本地保存多久？服务端保存多久？（涉及合规 + 存储成本）
8. **多端同步**：用户多设备登录是否同步？

### 关于推送
9. **国内厂商通道**：你的目标用户里 Android 占比多少？是否能接受额外接极光 / 个推（需要预算）？
10. **Web Push**：Flutter Web 是否需要支持桌面浏览器推送？

### 关于埋点
11. **数据栈选型**：神策（自建/SaaS）vs 友盟 vs Firebase？决定 SDK 接入和埋点字段映射。
12. **隐私强度**：是否仅在欧盟 / 加州走严格 Consent，其他地区默认开启？
13. **A/B 实验平台**：要不要接 GrowingIO / Optimizely / 自建？

把任意一条答上来，我可以为它写一份"解决方案 + 完整代码"专题。

---

> 📚 **生产集成专题到此结束**。整套教程的目录链路是：
>
> ```
> Dart 语言基础（dart-tutorial-new.md）
>    ↓
> Flutter 通用教程（flutter-tutorial.md）
>    ↓
> 电商实战 + freezed + 三方登录（flutter-tutorial-ecommerce.md）
>    ↓
> 支付 / IM / 推送 / 埋点（flutter-tutorial-integrations.md）  ← 你在这
> ```
>
> 这套体系已经覆盖了从语法地基到一个真实电商 App 上线全流程的几乎所有关键决策点。下一步建议：先按主教程 + 电商 + 这一份的目录搭出 lib/ 骨架，把 mock 模式跑通；再按本份逐个集成支付 → 推送 → 埋点 → IM（顺序基于"业务收益排序"）。
