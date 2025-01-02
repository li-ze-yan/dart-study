// ignore_for_file: unnecessary_cast, unnecessary_type_check, prefer_collection_literals, prefer_for_elements_to_map_fromiterable, dead_code, prefer_function_declarations_over_variables, hash_and_equals

import 'dart:io';

void main() {
  // Future.value
  var f1 = Future(() {
    return 'abc';
  });
  f1.then((value) => print(value));

  var f2 = Future.value('abc');
  f2.then((value) => print(value));

  // Future.delayed
  var f3 = Future(() {
    sleep(Duration(seconds: 2));
    print('f3');
  });

  Future.delayed(Duration(seconds: 4), () => print('f4'));

  // whenComplete 抛出异常也会执行的代码
  // 如果不抛出异常，那么就会按照顺序执行 whenComplete 放在哪里就在哪里执行
  // 当 onError 捕获异常的时候 catchError 就不会捕获异常
  Future(() {
    print('网络数据结束');
    return 'abc';
  }).then((value) {
    print('value=$value');
    return 'def';
  }).then((value) {
    print('value=$value');
    return null;
  }).whenComplete(() {
    print('所有操作完成');
  });
}
