class Age {
  final int value;
  Age(this.value)
      : assert(value >= 0, '年龄不能为负'),
        assert(value <= 150, '年龄不应该超过 150');
}
