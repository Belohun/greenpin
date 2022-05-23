import 'package:greenpin/data/database/hive_data_source.dart';
import 'package:greenpin/data/product/entity/product_entity.dart';
import 'package:greenpin/data/user/entity/user_info_entity.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataSourceModule {
  @lazySingleton
  HiveDataSource<ProductEntity> getProductDataSource(
    Box<ProductEntity> box,
  ) =>
      HiveDataSource<ProductEntity>(box);

  @lazySingleton
  HiveDataSource<UserInfoEntity> getUserInfoDataSource(
    Box<UserInfoEntity> box,
  ) =>
      HiveDataSource<UserInfoEntity>(box);
}
