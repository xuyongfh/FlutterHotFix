/*
 * @Author: Cao Shixin
 * @Date: 2021-06-25 10:10:58
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2021-06-28 17:36:35
 * @Description: 
 */
import 'dart:ffi';
import 'dart:io';

// 打开动态库, dylib是mac上的动态库的后缀
final DynamicLibrary dylib = Platform.isAndroid
    ? DynamicLibrary.open("libbsdiff.so")
    : DynamicLibrary.open("bsdiff.framework/bsdiff");
// 这里是最难理解的一步, 后面会详细解说
final int Function(int argc, List<String> char) bsdiffBspatch = dylib
    .lookup<NativeFunction<int Function(int, List<String>)>>("Bsdiff_bspatch")
    .asFunction();

class DiffZipOp {
  static void bspatch(String filePath, Function(bool success) result) {
    bsdiffBspatch(4, []);
  }
}
