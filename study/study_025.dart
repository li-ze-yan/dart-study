// 基础类
class Post {
  final String title;
  final String body;
  Post(this.title, this.body);
}

// Mixin 1：可点赞
mixin Likable {
  int _likes = 0;
  int get likes => _likes;
  void like() => _likes++;
  void unlike() {
    if (_likes > 0) _likes--;
  }
}

// Mixin 2：可评论
mixin Commentable {
  final List<String> _comments = [];
  List<String> get comments => List.unmodifiable(_comments);
  void comment(String text) => _comments.add(text);
}

// Mixin 3：可分享（仅适用于有 title 的 Post 子类）
mixin Sharable on Post {
  /// 复用父类的 title 字段
  String shareLink() =>
      'https://blog.com/share?t=${Uri.encodeComponent(title)}';
}

// 组合：一个完整的文章
class Article extends Post with Likable, Commentable, Sharable {
  Article(super.title, super.body);
}

// 另一个例子：草稿只能点赞，不能评论或分享
class Draft extends Post with Likable {
  Draft(super.title, super.body);
}

void main() {
  final a = Article('Dart Mixin 详解', '内容…');
  a.like();
  a.like();
  a.comment('好文！');
  a.comment('期待下一篇');
  print('点赞: ${a.likes}');
  print('评论: ${a.comments}');
  print('分享链接: ${a.shareLink()}');

  final d = Draft('草稿', '...');
  d.like();
  d.like();
  print('点赞: ${d.title}');
  print('body: ${d.body}');
  print('点赞数: ${d.likes}');
  // d.comment('xxx');   // ❌ Draft 没 with Commentable
}
