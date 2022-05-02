import 'package:greenpin/data/database/local_store.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllLocalProductsUseCase {
  GetAllLocalProductsUseCase(this._productDataStore);

  final LocalStore<Product> _productDataStore;

  Future<List<Product>> call() => _productDataStore.readAll();
}
