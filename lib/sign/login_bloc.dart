import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:wechat/database/model/auth.model.dart';
import '../database/database_auth.dart';
import 'package:wechat/sign/login_event.dart';
import 'package:wechat/sign/login_state.dart';
import 'package:wechat/database/model/user.model.dart';
import '../firebase_auth/auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _auth = new WxChatAuth();
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
        final result = await _testLogin(user: event.userPerson);
        print(result);
        if (result) {
          yield LoginState.successLogin();
        } else {
          final err = '登陆失败';
          yield LoginState.failedLogin(err);
        }
      } catch (err) {
        yield LoginState.failure(err.toString());
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
  Future<bool> _testLogin({UserPerson user}) async {
    await DataBaseAuthProvider.db.deleteClients();
    final result = await _auth.signIn(user.account, user.password);
    print(result);
    var auth = new AuthModel(uuid: result);
    var alreadyRegisteruser = await DataBaseAuthProvider.db.insetDB(auth);
    if(alreadyRegisteruser == 1){
      return true;
    }
    return false;
  }
}
