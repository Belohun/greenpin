import 'package:greenpin/data/database/local_store.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateFetchedProductsWithLocalUseCase {
  const UpdateFetchedProductsWithLocalUseCase(this._productDataStore);

  final LocalStore<Product> _productDataStore;

  Future<List<Product>> call(List<Product> fetchedProducts) async {
    final newProducts = _newList(fetchedProducts);
    final localProducts = await _productDataStore.readAll();

    for (final product in localProducts) {
      try {
        final productToUpdate = fetchedProducts
            .firstWhere((element) => element.uuid.contains(product.uuid));
        final productIndex = fetchedProducts.indexOf(productToUpdate);
        newProducts[productIndex] = product;
      } catch (_) {}
    }

    return newProducts;
  }

  List<Product> _newList(List<Product> fetchedProducts) {
    final list = List<Product>.from(fetchedProducts);
    for (final product in list) {
      final index = list.indexOf(product);
      final newProduct = product.copyWith(quantity: 0);
      list[index] = newProduct;
    }
    return list;
  }
}
