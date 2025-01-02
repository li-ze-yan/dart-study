// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type
import 'dart:math';
// import './dart_78.dart';

void main() {
  // sealed 封闭类不能在文件外使用
  // var v1 = Vehicle();
  /**
 * 解构类实例
 * 对象模式匹配，允许给类的对象里面公开的 getter 进行解构
 * 所有实例变量生成一个隐式的 getter 方法
 * 非 final 实例对象和没有初始化器的延迟 final 实例变量也会生成一个隐式的 setter 方法
 * 要解构类的实例，使用 var 或者 final 在类名称后面加()，里面用 getter: 加上用来解构创建的变量
 */

  var Circle(radius: c) = Circle(10);
  final Circle(radius: d) = Circle(10);
  print(c);
  print(d);
  c = 20;
  // d = 20;
  print(c);

  var Circle(getName: name) = Circle(100);
  print(name);

  final Circle(:radius) = Circle(1000);
  print(radius);

  var c1 = Circle(100);
  switch (c1) {
    case Square():
      print('square');
      break;
    case Square(length: var s) || Circle(radius: var s) when s > 0:
      print('s = $s');
      break;
    default:
      print('no match');
  }

  var area = calculateArea(c1);
  print(area);
}

class Shape {}

class Circle extends Shape {
  double radius;

  Circle(this.radius);

  get getName {
    return 'Circle';
  }
}

class Square extends Shape {
  double length;
  Square(this.length);
}

double calculateArea(Shape shape) {
  return switch (shape) {
    Circle(radius: var r) => r * r * pi,
    Square(length: var l) => l * l,
    _ => 0,
  };
}
