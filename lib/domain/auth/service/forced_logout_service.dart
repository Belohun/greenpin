import 'dart:async';

import 'package:greenpin/core/di_config.dart';
import 'package:greenpin/data/database/local_single_store.dart';
import 'package:greenpin/data/user/provider/user_info_provider_impl.dart';
import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:greenpin/domain/common/clearable.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LogoutService)
class ForcedLogoutService implements LogoutService {
  ForcedLogoutService(
    this._clearables,
    this._userInfoStore,
  );

  final List<Clearable> _clearables;

  final StreamController _logoutEventStreamController =
      StreamController.broadcast();

  final LocalSingleStore<UserInfo> _userInfoStore;

  @override
  Stream<void> get logoutEventStream => _logoutEventStreamController.stream;

  @override
  Future<void> logout() async {
    for (final clearable in _clearables) {
      try {
        await clearable.clear();
      } catch (e, s) {
        print(
            'Failed to clear ${clearable.runtimeType}, ex: $e, stacktrace: $s');
      }
    }
    await _userInfoStore.clear();

    _logoutEventStreamController.sink.add(Object());

    try {
      final userInfoProvider = await getIt.getAsync<UserInfoProvider>();
      await userInfoProvider.clear();
    } catch (e, s) {
      print('Failed to clear userInfoProvider, ex: $e, stacktrace: $s');
    }
  }
}
