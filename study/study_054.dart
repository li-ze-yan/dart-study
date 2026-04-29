extension DurationShortcut on int {
  Duration get seconds => Duration(seconds: this);
  Duration get minutes => Duration(minutes: this * 2);
  Duration get hours => Duration(hours: this);
}

void main() async {
  await Future.delayed(2.seconds); // 比 Duration(seconds: 2) 短得多
  print('${5.minutes.inSeconds} 秒'); // 300 秒
  print('${5.hours.inSeconds} 秒');
}
