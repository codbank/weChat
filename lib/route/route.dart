import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:wechat/home/home_page.dart';
import 'package:wechat/register/register_page.dart';
import 'package:wechat/sign/login.dart';

var usersHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return LoginPage();
});
var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HomePage();
});
var registerHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return RegisterPage();
});
