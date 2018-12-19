import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:wechat/sign/login.dart';


var usersHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return LoginPage();
    });