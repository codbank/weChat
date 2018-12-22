import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:wechat/database/database.dart';
import 'package:wechat/database/databaseLogin.dart';
import 'package:wechat/sign/login_event.dart';
import 'package:wechat/sign/login_state.dart';
import 'package:wechat/database/model/user.model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  //设置登陆的初始状态
  LoginState get initialState => LoginState.initial();
  void onLoginButtonPressed({UserPerson user}) {
    dispatch(
      LoginButtonPressed(userPerson: user),
    );
  }

  void onAccOrPassChange({UserPerson user}) {
    dispatch(LoginButtonCanUse(userPerson: user));
  }

  void onLoginSuccess() {
    dispatch(LoginIn());
  }

  void hasTestLoginIn() {
    dispatch(HasTestLoginIn());
  }

  @override
  Stream<LoginState> mapEventToState(
      LoginState currentState, LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginState.loading();
      try {
        // 验证用户存在
        var _testUserisVaild = await _testisVaild(user: event.userPerson);
        if (_testUserisVaild) {
           // 验证用户账户
          var accountTest = await _testAccount(user: event.userPerson);
          if (accountTest) {
            // 验证用户密码
            final passwordTest = await _testPassword(user: event.userPerson);
            if (passwordTest) {
              // 密码账户都正确 将数据存入sign表中
              var user = new UserPerson(
                account: event.userPerson.account,
                password: event.userPerson.password
              );
              DataBaseSigninProvider.db.insetDB(user);
              yield LoginState.successLogin();
            } else {
              final failed = "密码错误";
              yield LoginState.failedLogin(failed);
            }
          } else {
            final failed = "帐号错误";
            yield LoginState.failedLogin(failed);
          }
        } else {
          final failed = "请先注册";
          yield LoginState.failedLogin(failed);
        }
      } catch (err) {
        yield LoginState.failure(err);
      }
    }
    if (event is LoginButtonCanUse) {
      if (event.userPerson.account != null &&
          event.userPerson.account != '' &&
          event.userPerson.account != null &&
          event.userPerson.account != '') {
        yield LoginState.insetValue();
      } else {
        yield LoginState.initial();
      }
    }
    if (event is LoginIn) {}
    if (event is HasTestLoginIn) {
      yield LoginState.initial();
    }
  }

  // 验证账户
  Future<bool> _testAccount({UserPerson user}) async {
    var alreadyRegisteruser = await DataBaseLoginProvider.db.queryUser();
    if (alreadyRegisteruser[0].account == user.account) {
      return true;
    }
    return false;
  }

  // 验证密码
  Future<bool> _testPassword({UserPerson user}) async {
    var alreadyRegisteruser = await DataBaseLoginProvider.db.queryUser();
    if (alreadyRegisteruser[0].password == user.password) {
      return true;
    }
    return false;
  }

  // 验证是否存在
  Future<bool> _testisVaild({UserPerson user}) async {
    var alreadyRegisteruser = await DataBaseLoginProvider.db.queryUser();
    if (alreadyRegisteruser.length > 0) {
      return true;
    }
    return false;
  }
}
