import 'package:dio/dio.dart';
import 'package:greenpin/data/category/dto/subcategory_dto.dart';
import 'package:greenpin/data/networking/dto/pagination.dart';
import 'package:greenpin/data/networking/greenpin_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'product_data_source.g.dart';

@RestApi()
@singleton
abstract class ProductDataSource {
  @factoryMethod
  factory ProductDataSource(GreenpinDio dio) = _ProductDataSource;

  @GET('/product/1/{categoryId}/list') //TODO change in v2 (1 is a store)
  Future<SubcategoryDto> getPaginatedSubCategory(
    @Path('categoryId') int categoryId,
    @Query('pagination') Pagination pagination,
  );
}
