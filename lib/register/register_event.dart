
import 'package:wechat/database/model/user.model.dart';
import 'package:flutter/foundation.dart';
abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final UserPerson user;
  RegisterButtonPressed({@required this.user});
}

class RegisterIn extends RegisterEvent {}
class HasRegister extends RegisterEvent {}

class RegisterButtonCanUse extends RegisterEvent {
  final UserPerson user;
  RegisterButtonCanUse({@required this.user});
}
