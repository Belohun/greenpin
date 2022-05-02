part of 'cart_cubit.dart';

@freezed
class CartState with _$CartState {
  @With<BuildState>()
  const factory CartState.idle(CartData data) = CartStateIdle;

  const factory CartState.error(String errorMessage) = CartStateError;

  @With<BuildState>()
  const factory CartState.loading() = CartStateLoading;
}
