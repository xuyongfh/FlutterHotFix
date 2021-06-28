/*
 * @Author: Cao Shixin
 * @Date: 2021-06-28 17:15:16
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2021-06-28 17:57:03
 * @Description: 
 */
import 'dart:async';

import 'package:flutter/services.dart';

export 'base/hotfix_manager.dart';

class FlutterHotFixCsx {
  static const MethodChannel _channel =
      const MethodChannel('flutter_hot_fix_csx');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
