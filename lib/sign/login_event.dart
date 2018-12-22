import 'package:flutter/material.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String account;
  final String password;

  LoginButtonPressed({@required this.account, @required this.password});
}

class LoginIn extends LoginEvent {}

class LoginButtonCanUse extends LoginEvent {
  final String account;
  final String password;

  LoginButtonCanUse({@required this.account, @required this.password});
}
