extension type Email(String value) {
  bool get isValid => RegExp(r'^.+@.+\..+$').hasMatch(value);
  String get domain => value.split('@').last;
}

void main() {
  final e = Email('alice@example.com');
  print(e.isValid); // true
  print(e.domain); // example.com
}
