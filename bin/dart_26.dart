// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable

void main() {
  var list = [1, 2, 3];
  Iterable iterable = [2, 3, 4];
  print(list);
  print(iterable);
  print(list is List);
  print(iterable is List);
  print(list is Iterable);
  print(iterable is Iterable);
}
