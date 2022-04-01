import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:greenpin/domain/category/repository/category_repository.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoriesUseCase {
  GetCategoriesUseCase(this._categoryRepository);

  final CategoryRepository _categoryRepository;

  Future<SafeResponse<List<ProductCategory>>> call() =>
      fetchSafety(_categoryRepository.getCategories);
}
