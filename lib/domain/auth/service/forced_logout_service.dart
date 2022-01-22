import 'dart:async';

import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:greenpin/domain/common/clearable.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LogoutService)
class ForcedLogoutService implements LogoutService {
  final List<Clearable> _clearables;

  final StreamController _logoutEventStreamController =
      StreamController.broadcast();

  ForcedLogoutService(this._clearables);

  @override
  Stream<void> get logoutEventStream => _logoutEventStreamController.stream;

  @override
  Future<void> logout() async {
    for (final clearable in _clearables) {
      try {
        await clearable.clear();
      } catch (e, s) {
        print('Failed to clear ${clearable.runtimeType}, ex: $e, stacktrace: $s');
      }
    }

    _logoutEventStreamController.sink.add(Object());
  }
}
