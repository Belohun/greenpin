import 'package:greenpin/data/database/hive_data_source.dart';
import 'package:greenpin/data/database/local_store.dart';
import 'package:greenpin/data/product/entity/product_entity.dart';
import 'package:greenpin/data/product/mapper/product_entity_mapper.dart';
import 'package:greenpin/domain/product/model/product.dart';

class ProductDataStore implements LocalStore<Product> {
  final HiveDataSource<ProductEntity> _productDataSource;
  final ProductEntityMapper _entityMapper;

  ProductDataStore(this._productDataSource, this._entityMapper);

  @override
  Future create(Product value) async {
    final dto = _entityMapper.to(value);
    return _productDataSource.create(dto);
  }

  @override
  Future delete(Product value) async {
    return _productDataSource.delete(value.uuid);
  }

  @override
  Future<List<Product>> readAll() async {
    return (await _productDataSource.all()).map(_entityMapper.from).toList();
  }

  @override
  Future update(Product value) async {
    return _productDataSource.update(_entityMapper.to(value));
  }
}

