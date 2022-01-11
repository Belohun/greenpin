part of 'home_page_cubit.dart';

@freezed
class HomePageState with _$HomePageState {
  @With<BuildState>()
  const factory HomePageState.idle() = _HomePageStateIdle;

  @With<BuildState>()
  const factory HomePageState.error() = _HomePageStateError;
}
