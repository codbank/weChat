import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding: EdgeInsets.zero,
                child: new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          new Container(
              padding: EdgeInsets.only(left: 20, bottom: 30, top: 30),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: new Text(
                  '手机号登录',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: new Column(
              children: <Widget>[
                Container(
                  child: new Row(
                    children: <Widget>[
                      new Expanded(
                        child: new InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: new BorderSide(
                                  width: 1,
                                  color: Color(0xafcccccc),
                                ),
                              ),
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                new Container(
                                  padding: EdgeInsets.only(left: 8),
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: new Text('国家/地区'),
                                ),
                                new Text(
                                  '中国(+86)',
                                  style: TextStyle(
                                    color: Color(0xff09BB07),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  // padding: EdgeInsets.only(bottom: 10,left: 20,right: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: new BorderSide(
                        width: 1,
                        color: Color(0xafcccccc),
                      ),
                    ),
                  ),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(left: 8),
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: new Text('手机号'),
                      ),
                      new Expanded(
                        child: new Container(
                          child: TextField(
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '请输入手机号',
                              hintStyle: TextStyle(color: Colors.black12),
                            ),
                          ),
                        ),
                      ),
                      new Icon(Icons.close)
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 微信
          new Align(
            alignment: Alignment.bottomLeft,
            child: new FlatButton(
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    '用微信号/QQ号/邮箱登录',
                    style: TextStyle(
                      color: Color(0xff09BB07),
                    ),
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: new RaisedButton(
               color: Color(0xff09BB07),
                shape: new RoundedRectangleBorder(),
                onPressed: () {},
                child: new Container(
                  padding: EdgeInsets.all(14),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text('下一步',style: TextStyle(color: Colors.white,
                      fontSize: 16),
                      ),
                    ],
                  ),
                )),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
                      child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('找回密码', style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff09BB07)
                ),),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 1,
                    height: 15,
                    color: Colors.black12,
                  ),
                ),
                Text('紧急冻结', style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff09BB07)
                ),),
                new Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 1,
                     height: 15,
                    color: Colors.black12,
                  ),
                ),
                Text('微信安全中心', style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff09BB07)
                ),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
