import 'dart:async';
import 'package:greenpin/data/database/hive_data_source.dart';
import 'package:greenpin/data/database/local_store.dart';
import 'package:greenpin/data/product/entity/product_entity.dart';
import 'package:greenpin/data/product/mapper/product_entity_mapper.dart';
import 'package:greenpin/domain/product/model/product.dart';

class ProductDataStore implements LocalStore<Product> {
  ProductDataStore(
    this._productDataSource,
    this._entityMapper,
  );

  final HiveDataSource<ProductEntity> _productDataSource;
  final ProductEntityMapper _entityMapper;

  final StreamController<bool> _productsStreamController =
      StreamController<bool>.broadcast();

  @override
  Future create(Product value) async {
    addToStream(true);

    final dto = _entityMapper.to(value);
    return _productDataSource.create(dto);
  }

  @override
  Future delete(Product value) async {
    addToStream(true);

    return _productDataSource.delete(value.uuid);
  }

  @override
  Future<List<Product>> readAll() async {
    return (await _productDataSource.all()).map(_entityMapper.from).toList();
  }

  @override
  Future update(Product value) async {
    addToStream(true);
    return _productDataSource.update(_entityMapper.to(value));
  }

  @override
  void addToStream(bool event) {
    _productsStreamController.add(event);
  }

  @override
  Stream<bool> get stream =>
      _productsStreamController.stream.asBroadcastStream();

  @override
  Future<void> deleteAll() {
    addToStream(true);
    return _productDataSource.clear();
  }
}
