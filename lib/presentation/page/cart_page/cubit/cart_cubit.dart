import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:greenpin/domain/product/use_case/clear_local_products_use_case.dart';
import 'package:greenpin/domain/product/use_case/get_all_local_products_use_case.dart';
import 'package:greenpin/domain/product/use_case/get_products_stream_use_case.dart';
import 'package:greenpin/domain/product/use_case/update_product_quantity_use_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/cart_page/cubit/cart_data.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'cart_state.dart';

part 'cart_cubit.freezed.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  CartCubit(
    this._getAllLocalProductsUseCase,
    this._getProductsStreamUseCase,
    this._clearLocalProductsUseCase,
    this._updateProductQuantityUseCase,
  ) : super(const CartState.loading()) {
    _data = CartData.emptyData();
    _productSubscription =
        _getProductsStreamUseCase().listen(_productsListener);
  }

  void _productsListener(event) {
    _updateProducts();
  }

  final GetAllLocalProductsUseCase _getAllLocalProductsUseCase;
  final GetProductsStreamUseCase _getProductsStreamUseCase;
  final ClearLocalProductsUseCase _clearLocalProductsUseCase;
  final UpdateProductQuantityUseCase _updateProductQuantityUseCase;

  late final StreamSubscription _productSubscription;

  late CartData _data;

  Future<void> init() async {
    await _updateProducts();
  }

  Future<void> _updateProducts() async {
    final products = await _getAllLocalProductsUseCase();
    if (_data.products.length != products.length) {
      _data = CartData(products: products);
    }
    emit(CartState.idle(_data));
  }

  Future<void> clearCart() => _clearLocalProductsUseCase();

  Future<void> deleteProduct(Product product) => _updateProductQuantityUseCase(
        oldQuantity: product.quantity,
        newQuantity: 0,
        product: product,
      );

  @override
  Future<void> close() async {
    await super.close();
    await _productSubscription.cancel();
  }
}
