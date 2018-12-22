import 'package:flutter/material.dart';
import 'package:wechat/sign/login_bloc.dart';
import 'package:wechat/sign/login_event.dart';
import 'package:wechat/sign/login_state.dart';
import 'package:wechat/sign/login_with_account.dart';
import 'package:wechat/sign/login_with_phone.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wechat/database/model/user.model.dart';
class LoginPage extends StatefulWidget {
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc _loginBloc = LoginBloc();
  final _text = TextEditingController();
  final _account = TextEditingController();
  final _password = TextEditingController();
  bool nextStep = true;
  bool loginFlag = false;
  bool loginType = false;
  void showColoredToast(msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEvent, LoginState>(
      bloc: _loginBloc,
      builder: (
        BuildContext context,
        LoginState loginstate,
      ) {
        if (_loginFailed(loginstate)) {
          showColoredToast(loginstate.failed);
          _loginBloc.hasTestLoginIn();
        }
        if (_loginSuccessed(loginstate)) {
          showColoredToast(loginstate.success);
          Future.delayed(Duration(milliseconds: 100)).then((_) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => route == null);
          });
        }
        return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Stack(
            children: [
              new Column(
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
                    padding: EdgeInsets.only(
                        left: 20, bottom: loginType ? 30 : 15, top: 30),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: new Text(
                        loginType ? '手机号登录' : '微信号/QQ号/邮箱登录',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  loginType
                      ? new LoginWithPhone(
                          text: _text,
                          loginstate: loginstate,
                          loginBloc: _loginBloc)
                      : new LoginWithAccount(
                          account: _account,
                          password: _password,
                          loginstate: loginstate,
                          loginBloc: _loginBloc),
                  // 微信
                  new Align(
                    alignment: Alignment.bottomLeft,
                    child: new FlatButton(
                        onPressed: () {
                          setState(() {
                            loginType = !loginType;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            loginType ? '用微信号/QQ号/邮箱登录' : '用手机号登陆',
                            style: TextStyle(
                                color: Color(0xff00695c),
                                fontWeight: FontWeight.w300),
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: new RaisedButton(
                        disabledColor: Color(0xcf09BB07).withOpacity(0.4),
                        color: Color(0xff09BB07),
                        shape: new RoundedRectangleBorder(),
                        onPressed: loginstate.isLoginButtonEnable
                            ? () {
                                FocusScope.of(context).requestFocus(
                                  new FocusNode(),
                                );
                                if (loginType) {
                                  // 是手机号登陆
                                } else {
                                  // 微信号/QQ号/邮箱登录
                                  final user = new UserPerson(
                                    account: _account.text,
                                    password: _password.text,
                                  );
                                  _loginBloc.onLoginButtonPressed(user: user);
                                }
                              }
                            : null,
                        child: new Container(
                          padding: EdgeInsets.all(14),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text(
                                loginType ? '下一步' : '登陆',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
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
                        Text(
                          '找回密码',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff00695c),
                              fontWeight: FontWeight.w300),
                        ),
                        new Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 1,
                            height: 20,
                            color: Colors.black12,
                          ),
                        ),
                        Text(
                          '紧急冻结',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff00695c),
                              fontWeight: FontWeight.w300),
                        ),
                        new Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: 1,
                            height: 20,
                            color: Colors.black12,
                          ),
                        ),
                        Text(
                          '微信安全中心',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff00695c),
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              loginstate.isLoading ? new LoginLoading() : Container()
            ],
          ),
        );
      },
    );
  }

  bool _loginFailed(LoginState state) => state.failed.isNotEmpty;
  bool _loginSuccessed(LoginState state) => state.success.isNotEmpty;
}

class LoginLoading extends StatelessWidget {
  const LoginLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.black12.withOpacity(0.5),
        child: new Center(
          child: new Container(
            width: MediaQuery.of(context).size.width - 150,
            height: MediaQuery.of(context).size.width / 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.black.withOpacity(0.65)),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 30,
                ),
                SpinKitRing(
                  color: Colors.white,
                  lineWidth: 3,
                  size: 30,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  '加载中...',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w100),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
