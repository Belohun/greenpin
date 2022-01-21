part of 'login_page_cubit.dart';

@freezed
class LoginPageState with _$LoginPageState {

  @With<BuildState>()
  const factory LoginPageState.idle() = _LoginPageStateIdle;
}
