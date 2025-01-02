// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals
import 'dart:io';

void main() {
  print('1111');
  getData();
  print('2222');
}

getData() {
  Future(() {
    print('start');
    sleep(Duration(seconds: 2));
    print('end');
  });
}
