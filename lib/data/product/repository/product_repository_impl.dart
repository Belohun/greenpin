import 'package:greenpin/data/category/mapper/subcategory_mapper.dart';
import 'package:greenpin/data/networking/dto/pagination.dart';
import 'package:greenpin/data/product/data_source/product_data_source.dart';
import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/domain/product/repository/product_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  ProductRepositoryImpl(
    this._productDataSource,
    this._subcategoryMapper,
  );

  final ProductDataSource _productDataSource;
  final SubcategoryMapper _subcategoryMapper;

  @override
  Future<Subcategory> getPaginatedSubcategory({
    required int categoryId,
    required int page,
  }) async {
    final dto = await _productDataSource.getPaginatedSubCategory(
      categoryId,
      Pagination.standardPage(page),
    );
    return _subcategoryMapper.from(dto);
  }
}
