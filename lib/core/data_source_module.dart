import 'package:greenpin/data/database/hive_data_source.dart';
import 'package:greenpin/data/product/entity/product_entity.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataSourceModule {
  @lazySingleton
  HiveDataSource<ProductEntity> getHiveDataSource(
    Box<ProductEntity> box,
  ) =>
      HiveDataSource<ProductEntity>(box);
}
