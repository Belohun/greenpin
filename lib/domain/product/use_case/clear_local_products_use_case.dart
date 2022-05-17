import 'package:greenpin/data/database/local_store.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearLocalProductsUseCase {
  ClearLocalProductsUseCase(this._productDataStore);

  final LocalStore<Product> _productDataStore;

  Future<void> call() => _productDataStore.deleteAll();
}
