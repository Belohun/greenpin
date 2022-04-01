part of 'edit_user_cubit.dart';

@freezed
class EditUserState with _$EditUserState {
  @With<BuildState>()
  const factory EditUserState.idle(EditUserData data) = _EditUserStateIdle;

  const factory EditUserState.exitFlow() = _EditUserStateExitFlow;

  @With<BuildState>()
  const factory EditUserState.loading() = EditUserStateLoading;

  const factory EditUserState.error(String errorMessage) = _EditUserStateError;
}
