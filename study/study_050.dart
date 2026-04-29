String classify(int x) => switch (x) {
      0 => '零',
      > 0 && < 10 => '小正数',
      > 0 when x.isEven => '大偶数', // when 加额外条件
      > 0 => '大奇数',
      _ => '负数',
    };

void main() {
  print(classify(5));
  print(classify(10));
  print(classify(15));
  print(classify(-5));
}
