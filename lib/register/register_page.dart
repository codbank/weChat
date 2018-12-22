import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wechat/database/database.dart';
import 'package:wechat/database/model/user.model.dart';
import 'package:wechat/register/register_bloc.dart';
import 'package:wechat/register/register_event.dart';
import 'package:wechat/register/register_loading.dart';
import 'package:wechat/register/register_state.dart';
import 'package:wechat/register/register_textfiled.dart';
import 'package:wechat/sign/login.dart';

class RegisterPage extends StatefulWidget {
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterBloc _registerBloc = RegisterBloc();
  final _account = TextEditingController();
  final _password = TextEditingController();
  var dataList;

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

  bool _registerSuccessed(RegisterState state) => state.success.isNotEmpty;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterEvent, RegisterState>(
      bloc: _registerBloc,
      builder: (
        BuildContext context,
        RegisterState registerState,
      ) {
        if (_registerSuccessed(registerState)) {
          showColoredToast(registerState.success);
          _registerBloc.hasRegister();
        }
        return FutureBuilder<List<UserPerson>>(
            future: DataBaseLoginProvider.db.getClinets(),
            builder: (BuildContext context,
                AsyncSnapshot<List<UserPerson>> snapshot) {
              if (snapshot.hasData) {
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
                            padding:
                                EdgeInsets.only(left: 20, bottom: 30, top: 30),
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: new Text(
                                '手机号注册',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                          new RegisterTextFiled(
                              account: _account,
                              password: _password,
                              registerState: registerState,
                              registerBloc: _registerBloc),
                          // 微信
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: new RaisedButton(
                              disabledColor: Color(0xcf09BB07).withOpacity(0.4),
                              color: Color(0xff09BB07),
                              shape: new RoundedRectangleBorder(),
                              onPressed: registerState.isRegisterButtonEnable
                                  ? () {
                                      FocusScope.of(context).requestFocus(
                                        new FocusNode(),
                                      );
                                      //注册
                                      final user = new UserPerson(
                                        account: _account.text,
                                        password: _password.text,
                                      );
                                      _registerBloc.onRegisterButtonPressed(
                                          user: user);
                                    }
                                  : null,
                              child: new Container(
                                padding: EdgeInsets.all(14),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Text(
                                      '注册',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      registerState.isLoading ? new LoginLoading() : Container()
                    ],
                  ),
                  // 测试时使用,删除数据库所有数据
                  // floatingActionButton: FloatingActionButton(
                  //   child: Icon(Icons.close),
                  //   onPressed: (){
                  //     DataBaseLoginProvider.db.deleteClients();
                  //   },
                  // ),
                );
              } else {
                return RegisterLoading();
              }
            });
      },
    );
  }
}
