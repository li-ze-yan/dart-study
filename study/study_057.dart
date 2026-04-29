// extension type: 给底层类型贴"标签"，编译期防混淆，零运行时开销
//
// 问题：实际项目中，用户 ID、订单 ID、商品 ID 底层都是 String/num，
//       不靠类型系统区分的话，很容易把 orderId 误传给接收 userId 的函数。
//       void deleteUser(String id) { ... }
//       deleteUser(orderId);  // 逻辑错误，但编译期不会报
//
// 解决：extension type 让编译器帮你拦：
//       deleteUser(UserId) 只接受 UserId，传 OrderId 或 String 都编译失败。
// 关键：编译后 UserId 就是 String，没有额外包装对象，性能无损。

extension type UserId(String value) {}
extension type OrderId(String value) {}

void deleteUser(UserId id) {
  print('删除用户 $id');
}

void main() {
  final uid = UserId('u-123');
  final oid = OrderId('o-456');

  deleteUser(uid); // ✅
  // deleteUser(oid);       // ❌ 编译错误：OrderId 不是 UserId
  // deleteUser('u-789');   // ❌ 编译错误：普通 String 也不行
}
