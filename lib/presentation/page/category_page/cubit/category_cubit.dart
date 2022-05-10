import 'package:bloc/bloc.dart';
import 'package:greenpin/domain/networking/error/inner_error.dart';
import 'package:greenpin/domain/product/use_case/get_paginated_subctegory_use_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/category_page/cubit/category_data.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'category_state.dart';

part 'category_cubit.freezed.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(
    @factoryParam CategoryData? data,
    this._getPaginatedSubCategoryUseCase,
  )   : _data = data!,
        super(CategoryState.idle(data));

  final GetPaginatedSubCategoryUseCase _getPaginatedSubCategoryUseCase;

  late CategoryData _data;

  Future<void> fetchMoreProducts() async {
    final response = await _getPaginatedSubCategoryUseCase(
      page: _data.page + 1,
      categoryId: _data.originalSubcategory.category.id,
    );

    if (response.isSuccessful) {
      final newProductsList = [
        ..._data.productList,
        ...response.requiredData.productResponseList,
      ];
      _data = _data.copyWith(
        productList: newProductsList,
        shouldFetch: _data.shouldFetchMore,
      );
    } else {
      _data = _data.copyWith(shouldFetch: false);

      response.requiredError.handleError(
          orElse: (message) => emit(CategoryState.error(message)),
          innerErrors: (InnerError innerError) =>
              emit(CategoryState.error(LocaleKeys.somethingWentWrong.tr())));
    }
    _updateState();
  }

  void _updateState() {
    emit(CategoryState.idle(_data));
  }
}
