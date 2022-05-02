import 'package:greenpin/data/database/hive_data_source.dart';
import 'package:greenpin/data/database/local_store.dart';
import 'package:greenpin/data/product/entity/product_entity.dart';
import 'package:greenpin/data/product/mapper/product_entity_mapper.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:greenpin/domain/product/store/product_data_store.dart';
import 'package:injectable/injectable.dart';

@module
abstract class StoreModule {
  @LazySingleton()
  LocalStore<Product> localDataStore(
    HiveDataSource<ProductEntity> ds,
    ProductEntityMapper mapper,
  ) =>
      ProductDataStore(
        ds,
        mapper,
      );
}
