part of 'edit_user_email_cubit.dart';

@freezed
class EditUserEmailState with _$EditUserEmailState {
  @With<BuildState>()
  const factory EditUserEmailState.idle(EditEmailUserData data) =
      _EditUserEmailStateIdle;

  const factory EditUserEmailState.exitFlow() = _EditUserEmailStateExitFlow;

  const factory EditUserEmailState.error(String errorMessage) =
      _EditUserEmailStateError;
}
