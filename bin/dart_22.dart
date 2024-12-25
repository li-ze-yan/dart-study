// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable

void main() {
  // addEntries addAll
  Map<String, int> map = Map();
  map['a'] = 1;
  map.addEntries([MapEntry('b', 2)]);
  map.addAll({'c': 3});
  print(map);
}
