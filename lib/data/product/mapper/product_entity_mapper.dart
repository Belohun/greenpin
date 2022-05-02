import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/data/product/entity/product_entity.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductEntityMapper
    implements BidirectionalDataMapper<ProductEntity, Product> {
  @override
  Product from(ProductEntity data) {
    return Product(
      name: data.name,
      id: data.id,
      imageUrl: data.imageUrl,
      manufacturerName: data.manufacturerName,
      description: data.description,
      price: data.price,
      quantity: data.quantity,
      isSync: data.isSync,
      uuid: data.uuid,
    );
  }

  @override
  ProductEntity to(Product data) {
    return ProductEntity(
      name: data.name,
      id: data.id,
      imageUrl: data.imageUrl,
      manufacturerName: data.manufacturerName,
      description: data.description,
      price: data.price,
      quantity: data.quantity,
      isSync: data.isSync,
      uuid: data.uuid,
    );
  }
}
