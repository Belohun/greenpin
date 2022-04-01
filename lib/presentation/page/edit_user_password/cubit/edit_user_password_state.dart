part of 'edit_user_password_cubit.dart';

@freezed
class EditUserPasswordState with _$EditUserPasswordState {
  @With<BuildState>()
  const factory EditUserPasswordState.idle(EditUserPasswordData data) =
  _EditUserEmailStateIdle;

  const factory EditUserPasswordState.exitFlow() = _EditUserPasswordStateExitFlow;

  const factory EditUserPasswordState.error(String errorMessage) =
  _EditUserPasswordStateError;

  factory EditUserPasswordState.initIdle() => _EditUserEmailStateIdle(EditUserPasswordData.empty());
}
