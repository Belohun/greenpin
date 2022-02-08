part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  @With<BuildState>()
  const factory HomePageState.idle(HomeTabEnum currentTab) = _HomePageStateIdle;

  const factory HomePageState.error() = _HomePageStateError;

  @With<BuildState>()
  const factory HomePageState.loading() = _HomePageStateLoading;
}
