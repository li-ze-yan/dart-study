// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case

void main() {
  /**
   * interface 接口
   * 在接口的定义库之外的库中可以实现该接口，但不能扩展它
   * 可以被实例化
   * 在当前库之外不能被 extends 继承
   * 可以 implements 实现
   */
  Textable textable = Textable();
  textable.getText();

  Description description = Description();
  description.getText();

  Damn damn = Damn();
  damn.getText();
  damn.run();
}

interface class Textable {
  void getText() {
    print('接口中的 Text 执行');
  }
}

interface class Runnable {
  void run() {
    print('接口中的 run 执行');
  }
}

abstract interface class Drawable {
  void draw();
}

class Spark {
  external spark();
}

interface class Shirk {
  external shirk();
  void mustShirk() {
    print('Shirk 中的 shirk 执行');
  }
}

class Description extends Textable {
  @override
  void getText() {
    print('Description 中的 Text 执行');
  }
}

class Damn implements Textable, Runnable {
  @override
  void getText() {
    print('Damn 中的 Text 执行');
  }

  @override
  void run() {
    print('Damn 中的 run 执行');
  }
}

class DrawableDamn extends Drawable {
  // 继承自 abstract Drawable 接口 强制重写
  @override
  void draw() {
    print('DrawableDamn 中的 draw 执行');
  }
}

class SparkDamn extends Spark {
  // 继承自 external 方法 不强制重写
  @override
  spark() {
    print('SparkDamn 中的 spark 执行');
  }
}

class ShirkDamn implements Shirk {
  // 继承自 external 接口方法 不强制重写
  @override
  shirk() {
    print('ShirkDamn 中的 shirk 执行');
  }

  // 继承自 Shirk 接口方法 强制重写
  @override
  void mustShirk() {
    print('ShirkDamn 中的 mustShirk 执行');
  }
}
