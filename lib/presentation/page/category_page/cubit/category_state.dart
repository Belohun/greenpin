part of 'category_cubit.dart';

@freezed
class CategoryState with _$CategoryState {
  @With<BuildState>()
  const factory CategoryState.idle(CategoryData data) = _CategoryStateIdle;

  const factory CategoryState.error(String errorMessage) = _CategoryStateError;
}
