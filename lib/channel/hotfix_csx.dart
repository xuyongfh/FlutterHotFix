/*
 * @Author: Cao Shixin
 * @Date: 2021-06-29 15:45:12
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2021-07-02 11:05:39
 * @Description: 
 */
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX
// import 'dart:typed_data';
import 'package:flutter/services.dart';

import 'allocation.dart';

final DynamicLibrary bsdiffLib = Platform.isAndroid
    ? DynamicLibrary.open("libcsxbsdiff.so")
    : DynamicLibrary.process();

final int Function(int x, Pointer<Uint8> data) bsdiff = bsdiffLib
    .lookup<NativeFunction<Int32 Function(Int32, Pointer<Uint8>)>>(
        "Bsdiff_bsdiff")
    .asFunction();
final int Function(int x, int y) nativeAdd = bsdiffLib
    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
    .asFunction();

class FlutterHotFixCsx {
  static const MethodChannel _channel =
      const MethodChannel('flutter_hot_fix_csx');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getAppVersion');
    return version;
  }

  static int diff(List<int> source) {
    Pointer<Uint8> soureData = allocate<Uint8>(count: source.length);
    final pointerList = soureData.asTypedList(source.length);
    pointerList.setAll(0, source);
    return bsdiff(source.length, soureData);
  }

  static int add(int a, int b) {
    return nativeAdd(a, b);
  }

  // static Pointer<Utf8> toUtf8(String string) {
  //   final units = utf8.encode(string);
  //   final Pointer<Uint8> result = allocate<Uint8>(count: units.length + 1);
  //   final Uint8List nativeString = result.asTypedList(units.length + 1);
  //   nativeString.setAll(0, units);
  //   nativeString[units.length] = 0;
  //   return result.cast();
  // }
}
