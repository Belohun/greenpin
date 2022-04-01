import 'package:greenpin/data/category/api/category_data_source.dart';
import 'package:greenpin/data/category/mapper/product_category_mapper.dart';
import 'package:greenpin/data/category/mapper/subcategory_mapper.dart';
import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/domain/category/repository/category_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CategoryRepository)
class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(
    this._categoryDataSource,
    this._productCategoryMapper,
    this._subcategoryMapper,
  );

  final CategoryDataSource _categoryDataSource;
  final ProductCategoryMapper _productCategoryMapper;
  final SubcategoryMapper _subcategoryMapper;

  @override
  Future<List<ProductCategory>> getCategories() async {
    final response = await _categoryDataSource.getCategories();

    return response.categories
        .map<ProductCategory>(_productCategoryMapper.from)
        .toList();
  }

  @override
  Future<List<Subcategory>> getSubcategories({
    required int categoryId,
  }) async {
    final response = await _categoryDataSource.getSubCategories(categoryId);
    return response.map(_subcategoryMapper.from).toList();
  }
}
