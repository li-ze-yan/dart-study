// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  Future(() {
    print('网络数据结束');
    return 'abc';
  }).then((value) {
    print('value=$value');
    return 'def';
  }).then((value) {
    print('value=$value');
    return null;
  });
}
