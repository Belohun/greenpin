import 'package:greenpin/data/database/local_store.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProductsStreamUseCase {
  GetProductsStreamUseCase(this._productDataStore);

  final LocalStore<Product> _productDataStore;

  Stream<bool> call() => _productDataStore.stream;
}
