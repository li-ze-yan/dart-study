extension DateTimeFriendly on DateTime {
  /// 是否是今天
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// 友好显示：刚刚 / N 分钟前 / N 小时前 / N 天前 / 完整日期
  String get humanize {
    final diff = DateTime.now().difference(this);
    if (diff.inSeconds < 60) return '刚刚';
    if (diff.inMinutes < 60) return '${diff.inMinutes} 分钟前';
    if (diff.inHours < 24) return '${diff.inHours} 小时前';
    if (diff.inDays < 7) return '${diff.inDays} 天前';
    return '$year-${_pad(month)}-${_pad(day)}';
  }

  /// 私有辅助：补 0
  String _pad(int n) => n.toString().padLeft(2, '0');
}

void main() {
  final now = DateTime.now();
  print(now.isToday); // true
  print(now.subtract(const Duration(minutes: 3)).humanize); // 3 分钟前
  print(now.subtract(const Duration(days: 10)).humanize); // 类似 2026-04-17
}
