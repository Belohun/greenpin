import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:greenpin/exports.dart';

part 'shopping_data.freezed.dart';

@freezed
class ShoppingData with _$ShoppingData {
  factory ShoppingData(
    List<ProductCategory> productCategories,
  ) = _ShoppingData;
}
