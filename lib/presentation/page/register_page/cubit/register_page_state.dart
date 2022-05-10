part of 'register_page_cubit.dart';

@freezed
class RegisterPageState with _$RegisterPageState {
  @With<BuildState>()
  const factory RegisterPageState.idle(RegisterPageData data) =
      _RegisterPageStateIdle;

  const factory RegisterPageState.exitFlow() = _RegisterPageStateExitFlow;

  const factory RegisterPageState.successfulRegister() =
      _RegisterPageStateSuccessfulRegister;

  const factory RegisterPageState.error(String errorMessage) =
      _RegisterPageStateError;

  const factory RegisterPageState.scrollToStart() =
      _RegisterPageStateScrollToStart;
}
