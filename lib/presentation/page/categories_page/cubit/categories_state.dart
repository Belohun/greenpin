part of 'categories_cubit.dart';

@freezed
class CategoriesState with _$CategoriesState {
  @With<BuildState>()
  const factory CategoriesState.idle(CategoriesData data) = CategoriesStateIdle;

  const factory CategoriesState.error(String errorMessage) =
      CategoriesStateError;

  @With<BuildState>()
  const factory CategoriesState.loading() = CategoriesStateLoading;
}
