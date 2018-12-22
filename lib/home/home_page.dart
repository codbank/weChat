import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Future<bool> showdialog() async {
      return showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('你确定退出吗?'),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text('确定'),
                      onPressed: () {
                        Navigator.pop(context,true);
                      },
                    ),
                    FlatButton(
                      child: Text('取消'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            );
          });
    }

    return WillPopScope(
      onWillPop: showdialog,
      child: Scaffold(
        appBar: AppBar(
          title: Text('sss'),
        ),
        body: Container(
          child: new Center(
            child: Text('登陆成功'),
          ),
        ),
      ),
    );
  }
}
