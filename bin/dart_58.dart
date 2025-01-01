// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals
import './dart_59.dart';

void main() {
  var p1 = Person('张三', 20);
  p1.showInfo();

  /**
   * 异常错误断言
   */

  /**
   * assert 断言
   * 断言为true，程序继续执行，断言为false，程序会抛出异常，代码停止执行，除非存在 try catch 捕获异常
   */
  assert(2 + 2 == 4);
  // assert(2 + 2 == 5);

  try {
    assert(false);
  } catch (e) {
    print('e=$e');
  }

  /**
   * throw 抛出异常
   * throw 后面跟一个异常对象，程序会抛出异常，代码停止执行，除非存在 try catch 捕获异常
   */
  try {
    throw Exception('抛出异常');
  } catch (e) {
    print('e=$e');
  }
  /**
   * on
   * on 后面跟异常类型，程序会捕获该异常类型
   */
  try {
    throw Exception('抛出异常');
  } on Exception catch (e) {
    print('e=$e');
  }
}
