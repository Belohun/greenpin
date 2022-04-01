import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';

part 'logout_state.freezed.dart';

@freezed
class LogoutState with _$LogoutState {
  @With<BuildState>()
  factory LogoutState.idle() = LogoutStateIdle;

  factory LogoutState.logout() = LogoutStateLogout;
}
