import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:greenpin/domain/category/model/subcategory.dart';

abstract class CategoryRepository {
  Future<List<ProductCategory>> getCategories();

  Future<List<Subcategory>> getSubcategories({required int categoryId});
}
