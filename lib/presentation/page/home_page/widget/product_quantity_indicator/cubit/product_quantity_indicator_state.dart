part of 'product_quantity_indicator_cubit.dart';

@freezed
class ProductQuantityIndicatorState with _$ProductQuantityIndicatorState {
  @With<BuildState>()
  const factory ProductQuantityIndicatorState.idle(int productQuantity) = _ProductQuantityIndicatorStateIdle;


  @With<BuildState>()
  const factory ProductQuantityIndicatorState.zeroProducts() = _ProductQuantityIndicatorStateZeroProducts;
}
