/*
 * @Author: Cao Shixin
 * @Date: 2021-06-28 17:15:18
 * @LastEditors: Cao Shixin
 * @LastEditTime: 2021-07-02 11:06:22
 * @Description: 
 */
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_hot_fix_csx/channel/hotfix_csx.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on $_index'),
        ),
        floatingActionButton: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _index++;
                _deal();
              });
            },
            icon: Icon(Icons.add),
            label: Text('点击测试')),
      ),
    );
  }

  void _deal() {
    // switch (_index) {
    //   case 1:
    //包合并
    // FlutterHotFixCsx.diff(['a'.hashCode, 'b'.hashCode, 'c'.hashCode]);
    var result = FlutterHotFixCsx.add(2, 3);
    print('>>>>>>>.$result');
    //     break;
    //   case 2:
    //     //包拆分

    //     break;
    //   default:
    // }
  }
}
