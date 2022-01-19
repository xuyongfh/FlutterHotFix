/*
 * @Author: Cao Shixin
 * @Date: 2021-06-28 17:15:16
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2021-06-29 15:46:23
 * @Description: 
 */
import 'package:flutter/services.dart';
import 'package:flutter_hot_fix_csx/channel/hotfix_csx.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_hot_fix_csx');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await FlutterHotFixCsx.platformVersion, '42');
  });
}
