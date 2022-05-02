part of 'product_manager_cubit.dart';

@freezed
class ProductManagerState with _$ProductManagerState {
  @With<BuildState>()
  const factory ProductManagerState.idle(ProductManagerData data) =
      _ProductManagerState;

  @With<BuildState>()
  const factory ProductManagerState.loading() = _ProductManagerLoading;
}
