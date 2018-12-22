import 'package:flutter/material.dart';
import 'package:wechat/database/model/user.model.dart';
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final UserPerson userPerson;

  LoginButtonPressed({@required this.userPerson});
}

class LoginIn extends LoginEvent {}
class HasTestLoginIn extends LoginEvent {}
class LoginButtonCanUse extends LoginEvent {
 final UserPerson userPerson;

  LoginButtonCanUse({@required this.userPerson});
}
