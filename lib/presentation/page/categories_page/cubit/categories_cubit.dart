import 'package:bloc/bloc.dart';
import 'package:greenpin/domain/category/use_case/get_subcategories_use_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/categories_page/cubit/categories_data.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'categories_state.dart';

part 'categories_cubit.freezed.dart';

@Singleton()
class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this._getSubcategoriesUseCase)
      : super(const CategoriesState.loading());

  final GetSubcategoriesUseCase _getSubcategoriesUseCase;

  late CategoriesData _data;

  Future<void> init(int categoryId) async {
    final response = await _getSubcategoriesUseCase(categoryId);

    if (response.isSuccessful) {
      _data = CategoriesData(subcategoryList: response.requiredData);
    } else {
      _data = CategoriesData(subcategoryList: []);
    }

    _updateState();
  }

  void _updateState() {
    emit(CategoriesState.idle(_data));
  }
}
