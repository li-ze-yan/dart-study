extension StringB on String {
  int parseInt() {
    try {
      return int.parse(this);
    } catch (e) {
      return 0;
    }
  }
}
