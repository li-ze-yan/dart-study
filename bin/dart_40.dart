// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  Student s = Student();
  s.show();
  s.name = '李四';
  s.age = 21;
  s.height = 1.8;
  s.show();
}

class Student {
  // 私有变量: 使用下划线（_）前缀来表示私有变量，例如 _name、_age 和 _height
  // 相同文件下可以访问，不同文件下不能直接访问私有变量和私有方法
  // Getter: 使用 get 关键字定义，返回私有变量的值
  // Setter: 使用 set 关键字定义，接受一个参数来设置私有变量的值，并可以添加验证逻辑
  String _name = '张三';
  int _age = 20;
  double _height = 1.75;

  // getter
  String get name {
    return _name;
  }

  // setter
  set name(String value) {
    if (_name.isNotEmpty) {
      _name = value;
    } else {
      print('名字不能为空');
    }
  }

  // getter
  int get age {
    return _age;
  }

  // setter
  set age(int value) {
    if (value > 0) {
      _age = value;
    } else {
      print('年龄不能小于0');
    }
  }

  // getter
  double get height {
    return _height;
  }

  // setter
  set height(double value) {
    if (value > 0) {
      _height = value;
    } else {
      print('身高不能小于0');
    }
  }

  show() {
    print('name: $_name, age: $_age, height: $_height');
  }
}
