// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case

void main() {
  /**
   * mixin 混入
   * 在Dart中，Mixins可以看作是一种特殊的类，它不能被实例化，但可以被其他类使用
   * 当一个类使用了一个Mixin时，该Mixin中的成员（包括属性和方法）就会被加入到该类的成员中，从而实现了代码的复用
   * 
   * mixin的优势
   * 灵活性：Mixins可以在不修改原始类代码的情况下，为其添加新的功能。这使得代码更加模块化，便于维护和扩展
   * 多重继承：Dart中的类只能继承自一个父类，但可以通过使用多个Mixins来实现类似多重继承的效果
   * 组合优于继承：有时，使用Mixins进行代码复用比使用继承更加自然和直观。通过将功能拆分成独立的Mixins，可以使代码结构更加清晰和易于理解
   * 
   * mixin的限制
   * Mixins不能继承自其他Mixins
   * Mixins中的成员不能被子类覆盖（除非使用on关键字）
   * Mixins中的构造函数不能被子类调用
   * 
   * on 声明超类
   * 为了定义 super 调用所解析的类型。因此，只有当需要在混入内部进行 super 调用时才应使用它
   */

  MyClass myClass = MyClass();

  myClass.printMessage();
  myClass.printMessage2();
  myClass.draw2();
}

mixin Printable {
  void printMessage() {
    print('The class uses the Printable mixin.');
  }

  void printMessage2(); // 强制重写 抽象方法
}

class Drawable {
  void draw() {
    print('The class uses the Drawable mixin.');
  }
}

mixin DrawableMixin on Drawable {
  void draw2() {
    print('The class uses the DrawableMixin mixin.');
    super.draw();
  }
}

class MyClass extends Drawable with DrawableMixin, Printable {
  @override
  void printMessage2() {
    print('The class uses the Printable mixin.');
  }
}
