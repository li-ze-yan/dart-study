// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

import 'dart:io';

void main() {
  // Future then 解决嵌套地狱

  // 嵌套地狱
  // print('start');
  // Future(() {
  //   print('Future 1');
  //   sleep(Duration(seconds: 1));
  //   Future(() {
  //     print('Future 2');
  //     sleep(Duration(seconds: 1));
  //     Future(() {
  //       print('Future 3');
  //       sleep(Duration(seconds: 1));
  //       Future(() {
  //         print('Future 4');
  //         sleep(Duration(seconds: 1));
  //         Future(() {
  //           print('end');
  //         });
  //       });
  //     });
  //   });
  // });

  // 上面的嵌套地狱修改成 Future.then
  print('then start');
  Future(() {
    print('Future 1');
    sleep(Duration(seconds: 1));
    return 'Future 2';
  }).then((value) {
    print(value);
    sleep(Duration(seconds: 1));
    return 'Future 3';
  }).then((value) {
    print(value);
    sleep(Duration(seconds: 1));
    return 'Future 4';
  }).then((value) {
    print(value);
    sleep(Duration(seconds: 1));
    return 'end';
  }).then((value) {
    print(value);
  });
}
