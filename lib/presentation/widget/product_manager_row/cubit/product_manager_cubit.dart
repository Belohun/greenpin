import 'package:bloc/bloc.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:greenpin/domain/product/use_case/update_fetched_products_with_local_use_case.dart';
import 'package:greenpin/domain/product/use_case/update_product_quantity_use_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/product_manager_row/model/product_manager_data.dart';
import 'package:injectable/injectable.dart';

part 'product_manager_state.dart';

part 'product_manager_cubit.freezed.dart';

@injectable
class ProductManagerCubit extends Cubit<ProductManagerState> {
  ProductManagerCubit(
    this._updateFetchedProductsWithLocalUseCase,
    this._updateProductQuantityUseCase,
  ) : super(const ProductManagerState.loading());

  final UpdateFetchedProductsWithLocalUseCase
      _updateFetchedProductsWithLocalUseCase;
  final UpdateProductQuantityUseCase _updateProductQuantityUseCase;

  late ProductManagerData _data;

  Future<void> init(List<Product> products) async {
    _data = ProductManagerData(products: products);
    await updateProducts();
  }

  Future<void> updateProducts() async {
    final updatedProducts =
        await _updateFetchedProductsWithLocalUseCase(_data.products);
    _data = _data.copyWith(products: updatedProducts);
    _updateState();
  }

  void _updateState() {
    emit(ProductManagerState.idle(_data));
  }

  void changeProductQuantity(int quantity, Product product) {
    final newProduct = product.copyWith(quantity: quantity);
    final index =
        _data.products.indexWhere((element) => element.uuid == product.uuid);
    final newList = List<Product>.from(_data.products);
    newList[index] = newProduct;
    _data = _data.copyWith(products: newList);
    _updateProductQuantityUseCase(
      product: newProduct,
      newQuantity: quantity,
      oldQuantity: product.quantity,
    );
    _updateState();
  }

  void increaseQuantity(Product product) {
    changeProductQuantity(
      product.quantity + 1,
      product,
    );
  }

  void decreaseQuantity(Product product) {
    changeProductQuantity(
      product.quantity - 1,
      product,
    );
  }
}
