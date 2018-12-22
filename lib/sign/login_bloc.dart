import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:wechat/sign/login_event.dart';
import 'package:wechat/sign/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  //设置登陆的初始状态
  LoginState get initialState => LoginState.initial();
  void onLoginButtonPressed({String account, String password}) {
    dispatch(
      LoginButtonPressed(account: account, password: password),
    );
  }

  void onAccOrPassChange({String account, String password}) {
    dispatch(LoginButtonCanUse(account: account, password: password));
  }

  void onLoginSuccess() {
    dispatch(LoginIn());
  }

  @override
  Stream<LoginState> mapEventToState(
      LoginState currentState, LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginState.loading();
      try {
        final loginIng =
            await _getResult(account: event.account, password: event.password);
        if (loginIng) {
          yield LoginState.successLogin();
        } else {
          final failed = "帐号或密码错误";
          yield LoginState.failedLogin(failed);
        }
      } catch (err) {
        print('ssss');
        yield LoginState.failure(err);
      }
    }
    if (event is LoginButtonCanUse) {
      if (event.account != null &&
          event.account != '' &&
          event.password != null &&
          event.password != '') {
        yield LoginState.insetValue();
      } else {
        yield LoginState.initial();
      }
    }
    if (event is LoginIn) {}
  }

  Future<bool> _getResult({
    String account,
    String password,
  }) async {
    await Future.delayed(Duration(seconds: 2));
    String valiAccount = 'flutter';
    final valiPassword = 'a123456';
    var flag;
    flag = account.toString() == valiAccount.toString() &&
            valiPassword.toString() == password.toString()
        ? true
        : false;
    return flag;
  }
}
