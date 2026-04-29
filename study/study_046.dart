({double mean, double max, double min}) stats(List<double> xs) {
  if (xs.isEmpty) return (mean: 0, max: 0, min: 0);
  final sum = xs.fold<double>(0, (a, b) => a + b);
  return (
    mean: sum / xs.length,
    max: xs.reduce((a, b) => a > b ? a : b),
    min: xs.reduce((a, b) => a < b ? a : b),
  );
}

void main() {
  final s = stats([3.0, 5.0, 2.0, 8.0]);
  print('avg=${s.mean}, max=${s.max}, min=${s.min}');
}
