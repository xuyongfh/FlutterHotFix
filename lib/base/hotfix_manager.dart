/*
 * @Author: Cao Shixin
 * @Date: 2021-06-25 10:06:56
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2021-06-28 17:24:15
 * @Description: 热更新资源管理
 */

import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hot_fix_csx/helper/hotfix_helper.dart';
import 'package:flutter_hot_fix_csx/helper/log_helper.dart';
import 'package:flutter_hot_fix_csx/helper/shared_preference_helper.dart';
import 'package:flutter_hot_fix_csx/helper/zip_helper.dart';
import 'package:flutter_hot_fix_csx/operation/check_resource_op.dart';

import 'common.dart';
import 'constant.dart';
import 'enum.dart';

class HotFixManager with WidgetsBindingObserver {
  factory HotFixManager() => _getInstance();
  static HotFixManager get instance => _getInstance();
  static HotFixManager? _instance;
  static HotFixManager _getInstance() {
    return _instance ??= new HotFixManager._internal();
  }

  LogInfoCall get logInfo => _logInfo;

  late LogInfoCall _logInfo;

  HotFixManager._internal() {
    WidgetsBinding.instance?.addObserver(this);
    LogHelper.instance.logCall = _logInfo;
    _isResourceIntegrityCheck = false;
  }

  /// 当应用生命周期发生变化时 , 会回调该方法
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    /*
     * AppLifecycleState.paused:进入后台
     * AppLifecycleState.resumed:进入前台
     * AppLifecycleState.inactive:应用进入非活动状态 , 如来了个电话 , 电话应用进入前台
     * AppLifecycleState.detached:应用程序仍然在 Flutter 引擎上运行 , 但是与宿主 View 组件分离
     */
    LogHelper.instance.logInfo('应用活跃状态：$state');
    if (state == AppLifecycleState.resumed) {
      //应用进入前台
    }
  }

  /* 开启资源监听，
   * hasNewResource：有新资源的回调
   */
  @required
  void start(VoidCallback hasNewResource) async {
    LogHelper.instance.logInfo('开启资源检测');
    var isFirst = await SharedPreferenceService.instance
        .get(Constant.hotfixConfigKeyIsFirst, true);
    if (!isFirst) {
      //有资源，校验本地资源

    } else if (await ZipHelper.unZipFile('', '')) {
      //首次解压成功

    } else {
      //全量下载

    }
  }

  /* 
   * 校验资源是否有可用资源
   */
  Future<bool> checkForNewResource() async {
    return false;
  }

  /*
   * 检查资源是否都已准备好
   */
  Future<bool> checkResourceAlready() async {
    return true;
  }

  /*
   * 解压基准包,响应是否解压成功
   */
  Future<bool> unZipBaseResource() async {
    return true;
  }

  /*
   * 网络资源校验
   */
  void startHotFix() {}

  /*
   * 校验资源完备（这里后面要考虑资源是否存在并行存在，需要做一下安全处理，同一时间只能执行一个）
   * integrityType 资源完备性校验的排次类型
   * block 资源是否可用
   */
  late bool _isResourceIntegrityCheck;
  void asyncCheckRecourceType(HotFixResourceIntegrityType integrityType,
      Function(bool) resourceAvaliable) {
    if (!_isResourceIntegrityCheck) {
      _isResourceIntegrityCheck = true;
      var resourceDirect = HotFixHelper.currentValidResourceBasePath();
      rootBundle
          .loadString(resourceDirect + Constant.hotfixResourceListFile)
          .then((value) {
        if (value.isNotEmpty) {
          var manifestJson = json.decode(value);
          CheckResourceOp.checkResourceFull(manifestJson, resourceDirect,
              (checkIsComplete, checkError) {
            _isResourceIntegrityCheck = false;
            if (!checkIsComplete) {
              //全量下载
            } else {
              resourceAvaliable(true);
            }
          });
        } else {
          dealAsynCheckIntegrityResourceType(integrityType, resourceAvaliable);
        }
      });
    } else {
      resourceAvaliable(false);
    }
  }

  /*
   * 资源不完整的处理方案
   * integrityType 资源完备性校验的排次类型
   * block 资源是否可用
   */
  void dealAsynCheckIntegrityResourceType(
      HotFixResourceIntegrityType integrityType,
      Function(bool resourceAvaliable) resourceAvaliable) {
    switch (integrityType) {
      case HotFixResourceIntegrityType.After:
        {
          //重新解压一次上一次的结果，并刷新页面，然后进行再一次异步校验
          unarchiveLatestZipBack((preRecourceType) {
// [HotFixHelper setValidResourceType:preRecourceType];

            updateResourcePath();
            resourceIsChanged();
            asyncCheckRecourceType(
                HotFixResourceIntegrityType.AfterAgain, resourceAvaliable);
          });
        }
        break;
      case HotFixResourceIntegrityType.AfterAgain:
      case HotFixResourceIntegrityType.First:
        {
          readyTotalDownloadOperation(true);
          resourceAvaliable(false);
        }
        break;
    }
  }

  /*
   * 解压缩最新资源包资源
   * backResult 解压结果:解压成功才会回调将要转成的路径类型（这里处理为内部校验完成之后再修改）
   */
  void unarchiveLatestZipBack(
      Function(HotFixValidResource preRecourceType)? backResult) {}
  /*
   * 更新管理器资源路径，以供快捷返回
   */
  void updateResourcePath() {
    // self.htmlPath = [HotFixHelper currentValidResourceHtmlPath];
    // self.baseURL = [HotFixHelper currentValidResourceBaseURL];
  }
  /*
   * 资源已更新
   */
  void resourceIsChanged() {
    //记录非首次加载
    // [HotFixHelper theVersionHasLoad];
    //回调刷新UI，后面flutter适用通知适用组建刷新重新获取资源
  }

  /*
   * 全量下载
   */
  void readyTotalDownloadOperation(bool needlLatest) {
    if (needlLatest) {
      getLatestConfig();
    }
    //获取全量下载地址
    var fullResourceZipUrl = '';
    // NSURL *downloadURL = [FBDownloadHelper getTotalURL];
    if (fullResourceZipUrl.isEmpty) {
      //无下载地址，异常结束 TODO:异常结束-无全量下载地址
    }
    startTotalDownloadOperation(fullResourceZipUrl);
  }

  /*
   * 获取最新配置文件
   * 返回，下载文件是否成功
   */
  Future<bool> getLatestConfig() async {
    return true;
  }

  /*
   * 开始全量下载操作，这是一个操作集合
   */
  void startTotalDownloadOperation(String loadUrl) {

  }

  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
  }
}
