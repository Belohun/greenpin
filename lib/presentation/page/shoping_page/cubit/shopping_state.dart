part of 'shopping_cubit.dart';

@freezed
class ShoppingState with _$ShoppingState {
  @With<BuildState>()
  const factory ShoppingState.idle(ShoppingData data) = ShoppingStateIdle;

  const factory ShoppingState.error(String errorMessage) = ShoppingStateError;

  @With<BuildState>()
  const factory ShoppingState.loading() = ShoppingStateLoading;
}
