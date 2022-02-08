part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  @With<BuildState>()
  const factory ProfileState.idle(UserInfo userInfo) = ProfileStateIdle;

  const factory ProfileState.error() = ProfileStateError;

  @With<BuildState>()
  const factory ProfileState.loading() = ProfileStateLoading;
}
