// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {}

class Animal {
  int _age = 2;
  double _height = 0.5;

  int get age {
    return _age;
  }

  set age(int value) {
    if (value > 0) {
      _age = value;
    } else {
      print('年龄不能小于0');
    }
  }

  double get height {
    return _height;
  }

  set height(double value) {
    if (value > 0) {
      _height = value;
    } else {
      print('身高不能小于0');
    }
  }

  void show() {
    print('age: $_age, height: $_height');
  }
}
