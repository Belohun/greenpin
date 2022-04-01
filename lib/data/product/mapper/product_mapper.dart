import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/data/product/dto/product_dto.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductMapper extends BidirectionalDataMapper<ProductDto, Product> {
  @override
  Product from(ProductDto data) => Product(
        name: data.name,
        id: data.id,
        imageUrl: data.imageUrl ?? '',
        description: data.description,
        manufacturerName: data.manufacturerName ?? '',
        price: data.price,
      );

  @override
  ProductDto to(Product data) => ProductDto(
        name: data.name,
        id: data.id,
        imageUrl: data.imageUrl,
        description: data.description,
        manufacturerName: data.manufacturerName,
        price: data.price,
      );
}
