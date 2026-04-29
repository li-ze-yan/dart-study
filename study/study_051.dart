sealed class Event {}

class Click extends Event {
  final int x, y;
  Click(this.x, this.y);
}

class KeyPress extends Event {
  final String key;
  KeyPress(this.key);
}

class Scroll extends Event {
  final double dy;
  Scroll(this.dy);
}

String describe(Event e) => switch (e) {
      Click(:final x, :final y) when x == 0 && y == 0 => '点了原点',
      Click(:final x, :final y) => '点击 ($x, $y)',
      KeyPress(:final key) => '按下 $key',
      Scroll(:final dy) => '滚动 $dy',
      // 不需要 default，sealed 编译期保证完整
    };
