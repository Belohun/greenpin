import 'package:greenpin/domain/auth/store/auth_store.dart';
import 'package:greenpin/domain/common/clearable.dart';
import 'package:injectable/injectable.dart';

@module
abstract class StorageModule {

  @lazySingleton
  List<Clearable> clearables(
    AuthStore authStore,
  ) =>
      [
        authStore,
      ];
}
