import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/domain/category/repository/category_repository.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetSubcategoriesUseCase {
  GetSubcategoriesUseCase(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  Future<SafeResponse<List<Subcategory>>> call(int categoryId) => fetchSafety(
        () => _categoryRepository.getSubcategories(categoryId: categoryId),
      );
}
