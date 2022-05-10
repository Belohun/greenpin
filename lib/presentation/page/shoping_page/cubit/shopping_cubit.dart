import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:greenpin/domain/category/use_case/get_categories_use_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/shoping_page/cubit/shopping_data.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'shopping_cubit.freezed.dart';

part 'shopping_state.dart';

@singleton
class ShoppingCubit extends Cubit<ShoppingState> {
  ShoppingCubit(this._getCategoriesUseCase)
      : super(const ShoppingState.loading());

  final GetCategoriesUseCase _getCategoriesUseCase;

  ShoppingData _data = ShoppingData([]);

  Future<void> init() async {
    final response = await _getCategoriesUseCase();
    if (response.isSuccessful) {
      _data = _data.copyWith(productCategories: response.requiredData);
    } else {
      response.requiredError.handleError(orElse: (errorMessage) {
        emit(ShoppingState.error(errorMessage));
      }, innerErrors: (innerErrors) {
        emit(ShoppingState.error(
            innerErrors.message?.tr() ?? LocaleKeys.somethingWentWrong.tr()));
      });
    }
    _updateState();
  }

  void _updateState() {
    emit(ShoppingState.idle(_data));
  }
}
