/// 简易内存仓储：支持泛型 ID 与实体类型
class Repository<ID, T> {
  final Map<ID, T> _store = {};
  final ID Function(T) _idOf; // 提取 ID 的函数

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

  print(users.findAll());
  print(products.findAll());

  print(users.findById(1)); // User(1, 小新)
  print(products.findById('SKU-002')); // Product(SKU-002, 49.9)
  print('用户共 ${users.count} 人');
}
