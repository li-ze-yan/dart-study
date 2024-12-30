// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable

void main() {
  // 判断类型
  const a = '1';
  if (a is String) {
    print('a is String');
  } else {
    print('a is not String');
  }

  if (a is! String) {
    print('a is not String');
  } else {
    print('a is String');
  }

  const b = 1;
  if (b is Object) {
    print('b is Object');
  } else {
    print('b is not Object');
  }
}
