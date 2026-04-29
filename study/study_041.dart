class UserProfile {
  final int id;
  final String name;
  final int posts;
  UserProfile(this.id, this.name, this.posts);
  @override
  String toString() => 'UserProfile(#$id, $name, ${posts}posts)';
}

/// 模拟"调用接口"获取一个用户的资料：随机延迟 + 偶发失败。
Future<UserProfile> fetchProfile(int id) async {
  await Future.delayed(Duration(milliseconds: 200 + id * 50));
  if (id == 7) throw Exception('用户 7 不存在');
  return UserProfile(id, '用户#$id', id * 3);
}

/// 批量并发拉取，单个失败不影响其他（用每个 future 单独 catch）。
Future<List<UserProfile>> fetchAll(List<int> ids) async {
  // 把每个 future 包装成"成功返回 UserProfile，失败返回 null"
  final futures = ids.map((id) async {
    try {
      return await fetchProfile(id);
    } catch (e) {
      print('  [跳过] id=$id 失败: $e');
      return null; // 失败用 null 占位
    }
  });

  final results = await Future.wait(futures);

  // 过滤掉 null 并断言非空
  return results.whereType<UserProfile>().toList();
}

void main() async {
  print('开始批量请求...');
  final stopwatch = Stopwatch()..start();
  final profiles = await fetchAll([1, 3, 5, 7, 9]);
  stopwatch.stop();
  print('---\n成功 ${profiles.length} 个，耗时 ${stopwatch.elapsedMilliseconds}ms');
  profiles.forEach(print);
}
