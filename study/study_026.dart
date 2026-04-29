class Box<T> {
  T value;
  Box(this.value);

  T get content => value;
  void set(T newValue) => value = newValue;
}

void main() {
  final b1 = Box<int>(42);
  final b2 = Box<String>('hello');
  // b1.set('text');  // ❌ 类型错误
}
