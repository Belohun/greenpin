import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:greenpin/domain/product/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetPaginatedSubCategoryUseCase {
  GetPaginatedSubCategoryUseCase(this._productRepository);

  final ProductRepository _productRepository;

  Future<SafeResponse<Subcategory>> call({
    required int categoryId,
    required int page,
  }) =>
      fetchSafety(
        () => _productRepository.getPaginatedSubcategory(
          categoryId: categoryId,
          page: page,
        ),
      );
}
