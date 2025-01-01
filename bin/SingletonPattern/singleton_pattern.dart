void main() {}

class Person {
  static final Person _instance = Person._init();

  String name = '';
  Person._init();

  factory Person() {
    return _instance;
  }

  showInfo() {
    print('name=$name');
  }
}
