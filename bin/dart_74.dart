// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals
void main() {
  var (a, b) = (100, 200);
  print(a);
  print(b);
  var (c, _, d) = (100, 200, 'hello');
  print(c);
  print(d);

  var list = [1, 2, 3];
  var list2 = [4, 5, 6];
  var list3 = [7, 8, 9];
  int x, y, z;
  [x, y, z] = list;
  var [xx, yy, zz] = list2;
  var [xxx, ...args] = list3;
  print(x);
  print(y);
  print(z);
  print(xx);
  print(yy);
  print(zz);
  print(xxx);
  print(args);

  // 元祖的多返回值，通过解构来完成
  (String, int) userInfo() {
    return ('张三', 18);
  }

  var (name, age) = userInfo();
}

/**
 * 元祖
 * 解构
 */
