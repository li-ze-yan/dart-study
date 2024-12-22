void main() {
  const a = 1;
  const b = '2';
  var c = 3;
  final int d;

  print('$a $b $c');

  c = 4;
  d = 5;
  print('$c $d');

  // The final variable 'd' can only be set once.
  // d = 6;

  // const f = DateTime.now();
  final DateTime e = DateTime.now();
  print(e);
}
