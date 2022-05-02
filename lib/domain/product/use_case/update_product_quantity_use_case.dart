import 'package:greenpin/data/database/local_store.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateProductQuantityUseCase {
  const UpdateProductQuantityUseCase(this._productDataStore);

  final LocalStore<Product> _productDataStore;

  Future<void> call({
    required oldQuantity,
    required newQuantity,
    required Product product,
  }) async {
    if (oldQuantity == 0) {
      await _productDataStore.create(product);
    } else if (newQuantity == 0){
      await _productDataStore.delete(product);
    } else {
      await _productDataStore.update(product);
    }
  }
}
