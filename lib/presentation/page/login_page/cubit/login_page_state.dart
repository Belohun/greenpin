part of 'login_page_cubit.dart';

@freezed
class LoginPageState with _$LoginPageState {

  @With<BuildState>()
  const factory LoginPageState.idle(LoginPageData data) = _LoginPageStateIdle;

  const factory LoginPageState.loginSuccessful() = _LoginPageStateLoginSuccessful;

  const factory LoginPageState.error(String errorMessage) = _LoginPageStateError;

}
