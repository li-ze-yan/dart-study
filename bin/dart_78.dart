// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type
void main() {
  /**
 * sealed
 * 要创建一个已知的，可枚举的子类型集合
 * 使用 sealed 修饰符
 * 允许创建一个对这些子类型进行切换的语句，其在静态上被确保是详尽无遗的
 * sealed 修饰符防止类在其自己的库之外被扩展或实现，封闭类被隐式认为是抽象的
 * 
 * 它们不能被自身实例化
 * 它们可以有工厂构造函数
 * 它们可以为它们的子类定义构造函数使用
 * 但是，封闭类的子类并不是隐式抽象的
 */

  // Vehicle vehicle = Vehicle(); // error
  Car car = Car();
  print(getVehicleType(car));
}

String getVehicleType(Vehicle? vehicle) {
  return switch (vehicle) {
    Car() => 'car',
    Truck() => 'truck',
    Bicycle() => 'bicycle',
    _ => 'unknown'
  };
}

sealed class Vehicle {}

class Car extends Vehicle {}

class Truck extends Vehicle {}

class Bicycle extends Vehicle {}
