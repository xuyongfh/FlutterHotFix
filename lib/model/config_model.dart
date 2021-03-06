/*
 * @Author: Cao Shixin
 * @Date: 2021-06-29 13:32:47
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2021-06-30 10:20:25
 * @Description: 本地存储校验的config.json内部key键使用
 */
import 'package:flutter_hot_fix_csx/base/enum.dart';

class ConfigModel {
  //当前可用资源的的类型
  late int currentValidResource;
  HotFixValidResource get currentValidResourceType =>
      {
        0: HotFixValidResource.None,
        1: HotFixValidResource.Base,
        2: HotFixValidResource.Fix,
        3: HotFixValidResource.FixTmp
      }[currentValidResource] ??
      HotFixValidResource.None;
  //记录是否是第一次加载
  late bool isFirst;
  //记录上一次进行热更新的时间
  late String lastHotfixTime;

  ConfigModel(
      {this.currentValidResource = 0,
      this.isFirst = false,
      this.lastHotfixTime = ''});

  ConfigModel.fromJson(Map json) {
    currentValidResource = json['currentValidResource'] ?? 0;
    isFirst = json['isFirst'] ?? false;
    lastHotfixTime = json['lastHotfixTime'] ?? '';
  }

  Map toJson() {
    var data = <String, dynamic>{};
    data['currentValidResource'] = currentValidResource;
    data['isFirst'] = isFirst;
    data['lastHotfixTime'] = lastHotfixTime;
    return data;
  }
}
