import 'package:greenpin/data/category/dto/product_category_dto.dart';
import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductCategoryMapper
    extends BidirectionalDataMapper<ProductCategoryDto, ProductCategory> {
  @override
  ProductCategory from(ProductCategoryDto data) {
    return ProductCategory(
      name: data.name,
      url: data.url ?? 'https://picsum.photos/200/300?random=3',
      id: data.id,
    );
  }

  @override
  ProductCategoryDto to(ProductCategory data) {
    return ProductCategoryDto(
      data.name,
      data.url,
      data.id,
    );
  }
}
