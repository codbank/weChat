import 'package:flutter/material.dart';
import 'package:wechat/database/model/user.model.dart';
import 'package:wechat/register/register_bloc.dart';
import 'package:wechat/register/register_state.dart';

class RegisterTextFiled extends StatefulWidget {
  final TextEditingController account;
  final TextEditingController password;
  final RegisterState registerState;
  final RegisterBloc registerBloc;
  const RegisterTextFiled({
    Key key,
    this.account,
    this.password,
    this.registerState,
    this.registerBloc,
  }) : super(key: key);

  _RegisterTextFiledState createState() => _RegisterTextFiledState();
}

class _RegisterTextFiledState extends State<RegisterTextFiled> {
  bool accountFlag = true;
  bool passwordFlag = true;

  getRegisterState() {
    final UserPerson user = new UserPerson(
        account: widget.account.text, password: widget.password.text);
    widget.registerBloc.onAccOrPassChange(user: user);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                      // padding: EdgeInsets.only(bottom: 10),
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
                            child: new Text('帐号'),
                          ),
                          new Expanded(
                            child: new Container(
                              child: TextField(
                                textAlign: TextAlign.left,
                                controller: widget.account,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '请输入帐号',
                                  hintStyle: TextStyle(color: Colors.black12),
                                ),
                                onChanged: (val) {
                                  if (widget.account.text.length > 0) {
                                    setState(() {
                                      accountFlag = false;
                                    });
                                  } else {
                                    setState(() {
                                      accountFlag = true;
                                    });
                                  }
                                  getRegisterState();
                                },
                              ),
                            ),
                          ),
                          accountFlag
                              ? Container()
                              : new GestureDetector(
                                  child: new Icon(
                                    Icons.close,
                                    color: Colors.black38,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      widget.account.text = '';
                                      accountFlag = true;
                                    });
                                    getRegisterState();
                                  },
                                )
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
                  child: new Text('密码'),
                ),
                new Expanded(
                  child: new Container(
                    child: TextField(
                      textAlign: TextAlign.left,
                      controller: widget.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入密码',
                        hintStyle: TextStyle(color: Colors.black12),
                      ),
                      onChanged: (val) {
                        if (widget.password.text.length > 0) {
                          setState(() {
                            passwordFlag = false;
                          });
                        } else {
                          setState(() {
                            passwordFlag = true;
                          });
                        }
                        getRegisterState();
                      },
                    ),
                  ),
                ),
                passwordFlag
                    ? Container()
                    : new GestureDetector(
                        child: new Icon(
                          Icons.close,
                          color: Colors.black38,
                        ),
                        onTap: () {
                          setState(() {
                            widget.password.text = '';
                            passwordFlag = true;
                          });
                          getRegisterState();
                        },
                      )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
