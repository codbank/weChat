import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:wechat/database/database.dart';
import 'package:wechat/database/model/user.model.dart';
import 'package:wechat/register/register_event.dart';
import 'package:wechat/register/register_state.dart';
import 'package:wechat/sign/login_event.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  @override
  //设置登陆的初始状态
  RegisterState get initialState => RegisterState.initial();
  void onRegisterButtonPressed({UserPerson user}) {
    dispatch(
      RegisterButtonPressed(user: user),
    );
  }

  void onAccOrPassChange({UserPerson user}) {
    dispatch(RegisterButtonCanUse(user: user));
  }
  void hasRegister() {
    dispatch(HasRegister());
  }
  void onLoginSuccess() {
    dispatch(RegisterIn());
  }

  @override
  Stream<RegisterState> mapEventToState(
      RegisterState currentState, RegisterEvent event) async* {
    if (event is RegisterButtonPressed) {
      yield RegisterState.loading();
      try {
        await _getResult(event.user);
        yield RegisterState.successRegister();
      } catch (err) {
        yield RegisterState.failure(err);
      }
    }
    if (event is RegisterButtonCanUse) {
      if (event.user.account != null &&
          event.user.account != '' &&
          event.user.password != null &&
          event.user.password != '') {
        yield RegisterState.insetValue();
      } else {
        yield RegisterState.initial();
      }
    }
    if (event is LoginIn) {}
    if (event is HasRegister) {
       yield RegisterState.initial();
    }
    
  }

  // insert 是像数据库插入数据，我们只想保持数据表中只有一个用户，有两种办法，一种是删掉原来表中所有数据，一种是修改
  //删除所有的比较简单，在这里我们去修改他
  Future _getResult(UserPerson user) async {
    // 查询
    var data = await DataBaseLoginProvider.db.queryUser();
    if (data.length == 0) {
      DataBaseLoginProvider.db.insetDB(user);
    } else {
      var addNewUser = new UserPerson(
        id: data[0].id,
        account: user.account,
        password: user.password
      );
      await DataBaseLoginProvider.db.updataUser(addNewUser);
    }
  }
}
