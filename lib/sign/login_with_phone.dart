import 'package:flutter/material.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone(
      {Key key,
      @required TextEditingController text,
      @required this.loginstate,
      this.loginBloc})
      : _text = text,
        super(key: key);

  final TextEditingController _text;
  final loginstate;
  final loginBloc;

  @override
  LoginWithPhoneState createState() {
    return new LoginWithPhoneState();
  }
}

class LoginWithPhoneState extends State<LoginWithPhone> {
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
                            width: MediaQuery.of(context).size.width * 0.25,
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
                      controller: widget._text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入手机号',
                        hintStyle: TextStyle(color: Colors.black12),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        if (text.isEmpty) {
                        } else {}
                      },
                    ),
                  ),
                ),
                new Icon(Icons.close)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
