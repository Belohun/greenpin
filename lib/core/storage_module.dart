import 'package:greenpin/data/database/database_configuration.dart';
import 'package:greenpin/data/product/entity/product_entity.dart';
import 'package:greenpin/data/user/entity/user_info_entity.dart';
import 'package:greenpin/domain/auth/store/auth_store.dart';
import 'package:greenpin/domain/common/clearable.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@module
abstract class StorageModule {
  @lazySingleton
  List<Clearable> clearables(
    AuthStore authStore,
  ) =>
      [authStore];

  @preResolve
  Future<Box<ProductEntity>> registerProductBox() =>
      Hive.openBox<ProductEntity>(DatabaseConfiguration.productBox);

  @preResolve
  Future<Box<UserInfoEntity>> registerUserInfoBox() =>
      Hive.openBox<UserInfoEntity>(DatabaseConfiguration.userInfoBox);
}
