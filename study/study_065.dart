abstract class Animal {
  final String name;
  Animal(this.name);
}

class Cat extends Animal {
  Cat(super.name);
  void purr() => print('$name 在咕噜咕噜');
}

class Dog extends Animal {
  Dog(super.name);
  void wag() => print('$name 摇尾巴');
}

abstract class Hospital {
  /// covariant 关键字：允许专科医院收窄类型
  void treat(covariant Animal patient);
}

/// 综合医院：处理任何动物
class GeneralHospital extends Hospital {
  @override
  void treat(Animal patient) {
    print('给 ${patient.name} 做基础检查');
  }
}

/// 猫专科：只收猫
class CatClinic extends Hospital {
  @override
  void treat(Cat patient) {
    // 收窄到 Cat（合法因为父类标了 covariant）
    print('给猫 ${patient.name} 做猫专属检查');
    patient.purr();
  }
}

void main() {
  final hospitals = <Hospital>[GeneralHospital(), CatClinic()];

  // 注意：当 CatClinic 用 Hospital 引用调用、传入 Dog 时，
  // 静态类型检查能过，但运行时会因类型不匹配抛 TypeError。
  // 这就是 covariant 的"权力换责任"——你来保证类型正确。
  for (final h in hospitals) {
    try {
      h.treat(Cat('咪咪'));
    } catch (e) {
      print('  ⚠️ $e');
    }
  }
}
