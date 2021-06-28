/*
 * @Author: Cao Shixin
 * @Date: 2021-06-25 10:10:12
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2021-06-28 18:20:06
 * @Description: 
 */
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_hot_fix_csx/helper/log_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadOp {
  factory DownloadOp() => _getInstance();
  static DownloadOp get instance => _getInstance();
  static DownloadOp? _instance;
  static DownloadOp _getInstance() {
    return _instance ??= new DownloadOp._internal();
  }

  late Dio _dio;

  DownloadOp._internal() {
    _dio = Dio();
    //设置连接超时时间
    _dio.options.connectTimeout = 10000;
    //设置数据接收超时时间
    _dio.options.receiveTimeout = 10000;
  }

  /* 下载文件保存本地
   * url：下载文件的远端地址
   * savePath： 保存本地的路径
   */
  Future<bool> downloadFile(String url, String savePath) async {
    bool status = await Permission.storage.isGranted;
    //判断如果还没拥有读写权限就申请获取权限
    if (!status) {
      await Permission.storage.request().isGranted;
    }
    Response response;
    try {
      response = await _dio.download(url, savePath);
      if (response.statusCode == 200) {
        LogHelper.instance.logInfo('下载请求成功');
        return true;
      } else {
        LogHelper.instance.logInfo('接口出错:$response');
        return false;
      }
    } catch (e) {
      LogHelper.instance.logInfo('服务器出错或网络连接失败！$e');
      return false;
    }
  }

  /*
   * 请求远端json文件的内容获取
   */
  Future<Map<String, dynamic>> getJsonUrlContent(String url) async {
    Response response;
    try {
      response = await _dio.get(url);
      if (response.statusCode == 200) {
        LogHelper.instance.logInfo('jsonUrl请求成功');
        return jsonDecode(response.data);
      } else {
        LogHelper.instance.logInfo('json接口:$url出错:$response');
        return {};
      }
    } catch (e) {
      LogHelper.instance.logInfo('json服务器出错或网络连接失败！$e');
      return {};
    }
  }
}
