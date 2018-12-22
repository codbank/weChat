import 'package:meta/meta.dart';

class LoginState {
  final bool isLoading;
  final bool isLoginButtonEnable;
  final String err;
  final String failed;
  final String success;
  const LoginState({
    @required this.isLoading,
    @required this.isLoginButtonEnable,
    @required this.err,
    @required this.failed,
    @required this.success,
  });
  factory LoginState.initial() {
    return LoginState(
      isLoading: false,
      isLoginButtonEnable: false,
      err: '',
      failed: '',
      success: '',
    );
  }
  factory LoginState.insetValue() {
    return LoginState(
      isLoading: false,
      isLoginButtonEnable: true,
      err: '',
      failed: '',
      success: '',
    );
  }
  factory LoginState.loading() {
    return LoginState(
      isLoading: true,
      isLoginButtonEnable: false,
      err: '',
      failed: '',
      success: '',
    );
  }
  factory LoginState.failure(String error) {
    return LoginState(
      isLoading: false,
      isLoginButtonEnable: true,
      err: error,
      failed: '',
      success: '',
    );
  }
  factory LoginState.failedLogin(String failed) {
    return LoginState(
      isLoading: false,
      isLoginButtonEnable: true,
      err: '',
      failed: failed,
      success: '',
    );
  }
  factory LoginState.successLogin() {
    return LoginState(
      isLoading: false,
      isLoginButtonEnable: true,
      err: '',
      failed: '',
      success: '登陆成功',
    );
  }
  String toString() =>
      'LoginState { isLoading: $isLoading, isLoginButtonEnabled: $isLoginButtonEnable,failed: $failed, error: $err }';
}
