import 'package:meta/meta.dart';

class RegisterState {
  final bool isLoading;
  final bool isRegisterButtonEnable;
  final String err;
  final String failed;
  final String success;
  const RegisterState({
    @required this.isLoading,
    @required this.isRegisterButtonEnable,
    @required this.err,
    @required this.failed,
    @required this.success,
  });
  factory RegisterState.initial() {
    return RegisterState(
      isLoading: false,
      isRegisterButtonEnable: false,
      err: '',
      failed: '',
      success: '',
    );
  }
  factory RegisterState.insetValue() {
    return RegisterState(
      isLoading: false,
      isRegisterButtonEnable: true,
      err: '',
      failed: '',
      success: '',
    );
  }
  factory RegisterState.loading() {
    return RegisterState(
      isLoading: true,
      isRegisterButtonEnable: false,
      err: '',
      failed: '',
      success: '',
    );
  }
  factory RegisterState.failure(String error) {
    return RegisterState(
      isLoading: false,
      isRegisterButtonEnable: true,
      err: error,
      failed: '',
      success: '',
    );
  }
  factory RegisterState.failedRegister(String failed) {
    return RegisterState(
      isLoading: false,
      isRegisterButtonEnable: true,
      err: '',
      failed: failed,
      success: '',
    );
  }
  factory RegisterState.successRegister() {
    return RegisterState(
      isLoading: false,
      isRegisterButtonEnable: true,
      err: '',
      failed: '',
      success: '注册成功',
    );
  }
}
