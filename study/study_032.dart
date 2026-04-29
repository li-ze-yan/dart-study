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
  bool get isFinal =>
      this == OrderStatus.completed || this == OrderStatus.cancelled;

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
