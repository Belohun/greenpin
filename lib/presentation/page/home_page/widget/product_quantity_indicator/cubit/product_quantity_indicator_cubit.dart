import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greenpin/domain/product/use_case/get_all_local_products_use_case.dart';
import 'package:greenpin/domain/product/use_case/get_products_stream_use_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'product_quantity_indicator_state.dart';

part 'product_quantity_indicator_cubit.freezed.dart';

@singleton
class ProductQuantityIndicatorCubit
    extends Cubit<ProductQuantityIndicatorState> {
  ProductQuantityIndicatorCubit(
    this._getAllLocalProductsUseCase,
    this._getProductsStreamUseCase,
  ) : super(const ProductQuantityIndicatorState.zeroProducts()) {
    _productSubscription = _getProductsStreamUseCase().listen(_productListener);
  }

  final GetAllLocalProductsUseCase _getAllLocalProductsUseCase;
  final GetProductsStreamUseCase _getProductsStreamUseCase;

  late final StreamSubscription _productSubscription;

  var quantity = 0;

  Future<void> init() => _updateProducts();

  void _productListener(event) {
    _updateProducts();
  }

  Future<void> _updateProducts() async {
    final products = await _getAllLocalProductsUseCase();
    quantity = products.length;

    _updateState();
  }

  void _updateState() {
    if (quantity == 0) {
      emit(const ProductQuantityIndicatorState.zeroProducts());
    } else {
      emit(ProductQuantityIndicatorState.idle(quantity));
    }
  }

  @override
  Future<void> close() async {
    await super.close();
    await _productSubscription.cancel();
  }
}
