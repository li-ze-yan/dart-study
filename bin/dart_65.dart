// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

void main() {
  // Future 泛型
  var f1 = Future<String>.value('abc');

  var f3 = fun1();
  f3.then((value) => print(value));
}

Future fun1() {
  return Future<String>.value('abc');
}
