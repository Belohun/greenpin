import 'package:greenpin/domain/category/model/subcategory.dart';

abstract class ProductRepository {
  Future<Subcategory> getPaginatedSubcategory({
    required int categoryId,
    required int page,
  });
}
