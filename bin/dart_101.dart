// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals, pattern_never_matches_value_type, unnecessary_cast_pattern, unreachable_switch_case, avoid_init_to_null
import './extensiontype/stringa.dart' as m1;
import './extensiontype/stringb.dart' as m2;

void main() {
  var str1 = m1.StringA('1').parseInt();
  var str2 = m2.StringB('hello').parseInt();

  print(str1);
  print(str2);
}
