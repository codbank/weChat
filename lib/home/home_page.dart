import 'package:flutter/material.dart';
import 'package:wechat/home/home_body.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dashbordIcon = Icon(
    IconData(
      0xe7f3,
      fontFamily: 'iconfont',
    ),
  );
  final contactIcon = Icon(
    IconData(
      0xe655,
      fontFamily: 'iconfont',
    ),
  );
  final fountIcon = Icon(
    IconData(
      0xe63f,
      fontFamily: 'iconfont',
    ),
  );
  final ownIcon = Icon(
    IconData(
      0xe56b,
      fontFamily: 'iconfont',
    ),
  );
  PageController _pageController;
  int _page = 0;
  void navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    _pageController = new PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

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
                        Navigator.pop(context, true);
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
          title: Text('微信'),
          actions: <Widget>[
            SizedBox(
              width: 60,
              child: new FlatButton(
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 60,
              child: new FlatButton(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
        bottomNavigationBar: new Theme(
          // data: Theme.of(context).copyWith(
          //   canvasColor: Colors.transparent,
          //   primaryColor: Colors.red,
          //   textTheme: Theme.of(context).textTheme.copyWith(
          //         caption: new TextStyle(color: Colors.yellow),
          //       ),
          // ),
          data: Theme.of(context),
          child: new BottomNavigationBar(
              items: [
                new BottomNavigationBarItem(
                    icon: dashbordIcon,
                    title: new Text(
                      "微信",
                    )),
                new BottomNavigationBarItem(
                    icon: contactIcon,
                    title: new Text(
                      "通讯录",
                    )),
                new BottomNavigationBarItem(
                  icon: fountIcon,
                  title: new Text(
                    "发现",
                  ),
                ),
                new BottomNavigationBarItem(
                  icon: ownIcon,
                  title: new Text(
                    "我",
                  ),
                )
              ],
              onTap: navigationTapped,
              currentIndex: _page,
              fixedColor: const Color(0xff09BB07),
              type: BottomNavigationBarType.fixed),
        ),
        body: new PageView(
          children: homeBodyList,
          onPageChanged: onPageChanged,
          controller: _pageController,
        ),
      ),
    );
  }
}
