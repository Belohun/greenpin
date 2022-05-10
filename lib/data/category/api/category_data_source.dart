import 'package:dio/dio.dart';
import 'package:greenpin/data/category/dto/categories_response_dto.dart';
import 'package:greenpin/data/category/dto/product_category_dto.dart';
import 'package:greenpin/data/category/dto/subcategory_dto.dart';
import 'package:greenpin/data/networking/greenpin_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'category_data_source.g.dart';

@RestApi()
@singleton
abstract class CategoryDataSource {
  @factoryMethod
  factory CategoryDataSource(GreenpinDio dio) = _CategoryDataSource;

  @GET('/category')
  Future<CategoriesResponseDto> getCategories();

  @POST('/category')
  Future<void> addCategory(@Body() ProductCategoryDto addCategory);

  @GET('/product/1/{categoryId}') //TODO change in v2 (1 is a store)
  Future<List<SubcategoryDto>> getSubCategories(@Path('categoryId') int categoryId);
}
