part of 'entry_page_cubit.dart';

@freezed
class EntryPageState with _$EntryPageState {
  @With<BuildState>()
  const factory EntryPageState.idle() = _EntryPageIdle;

  const factory EntryPageState.userLoggedIn() = _EntryPageUserLoggedIn;

  @With<BuildState>()
  const factory EntryPageState.userNotLoggedIn() = _EntryPageUserNotLoggedIn;
}
