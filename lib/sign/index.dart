import 'package:flutter/material.dart';
import '../route/application.dart';

class LoginHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/login.jpg'), fit: BoxFit.cover),
      ),
      child: new Column(
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              new FlatButton(
                onPressed: () {},
                child: new Text(
                  '语言',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 30),
            child: new Row(
              children: <Widget>[
                new Container(
                  width: 120,
                  height: 50,
                  child: new RaisedButton(
                    color: Color(0xff09BB07),
                    child: new Text(
                      '登录',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                    onPressed: () {
                      Application.router.navigateTo(context, 'login');
                    },
                  ),
                ),
                Spacer(),
                Container(
                  width: 120,
                  height: 50,
                  child: new RaisedButton(
                    color: Colors.white,
                    child: new Text(
                      '注册',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
