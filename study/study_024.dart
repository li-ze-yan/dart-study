// 接口 1：能转 JSON
abstract interface class JsonSerializable {
  Map<String, dynamic> toJson();
}

// 接口 2：能比较新旧
abstract interface class Versioned {
  int get version;
}

// 接口 3: 作者
abstract interface class AuthName {
  String get name;
}

// final class
final class Hobby {
  final String hobby;
  Hobby(this.hobby);
}

// 一个类同时实现两个接口（用逗号分隔）
class Article implements JsonSerializable, Versioned, AuthName {
  final String id;
  final String title;
  @override
  final int version;
  @override
  final String name;

  Article(this.id, this.title, {this.version = 1, required this.name});

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'version': version,
        'name': name,
      };
}

class Comment implements JsonSerializable {
  final String text;
  Comment(this.text);

  @override
  Map<String, dynamic> toJson() => {'text': text};
}

/// 工具函数：只关心"能不能 toJson"，不关心具体类型
void persist(JsonSerializable item) {
  print('保存: ${item.toJson()}');
}

void main() {
  persist(Article('a1', 'Dart 进阶', name: '李泽言1')); // ✅
  persist(Comment('好文章')); // ✅

  // Article 既是 JsonSerializable 又是 Versioned，可以作为两种"接口"传递
  final Versioned v = Article('a2', 'Flutter', name: '李泽言2');
  print('版本: ${v.version}');
}
