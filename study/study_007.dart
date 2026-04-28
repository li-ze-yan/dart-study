void main() {
  // 模拟从表单/接口拿到的字段，统一用字符串
  const rawName = '野原新之助';
  const rawAge = '5';
  const rawHeight = '105.3';

  // 解析数字字段时给容错
  final age = int.tryParse(rawAge) ?? 0;
  final height = double.tryParse(rawHeight) ?? 0.0;

  // 派生字段用 final 表示"算一次就别动"
  final bornYear = DateTime.now().year - age;

  // 用三引号字符串组装多行展示
  final card = '''
========================
姓名: $rawName
年龄: $age 岁
身高: ${height.toStringAsFixed(1)} cm
出生年份(估算): $bornYear
========================''';

  print(card);
}
