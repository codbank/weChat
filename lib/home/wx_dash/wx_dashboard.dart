import 'package:flutter/material.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

class WxDashBoard extends StatefulWidget {
  _WxDashBoardState createState() => _WxDashBoardState();
}

class _WxDashBoardState extends State<WxDashBoard> {
   String debugLable = 'Unknown';
final JPush jpush = new JPush();
  @override
  void initState() {
    super.initState();
  }
// 编写视图
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(),
    );
  }
}