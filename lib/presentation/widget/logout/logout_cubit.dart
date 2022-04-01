import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greenpin/domain/auth/use_case/get_logout_stream_use_case.dart';
import 'package:greenpin/presentation/widget/logout/logout_state.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LogoutCubit extends Cubit<LogoutState> {
  final GetLogoutStreamUseCase _getLogoutStreamUseCase;

  StreamSubscription? _logoutEventSubscription;

  LogoutCubit(this._getLogoutStreamUseCase) : super(LogoutState.idle());

  Future<void> init() async {
    _logoutEventSubscription = _getLogoutStreamUseCase().take(1).listen((event) {
      emit(LogoutState.logout());
    });
  }

  @override
  Future<void> close() async {
    await _logoutEventSubscription?.cancel();
    await super.close();
  }
}
