import 'package:greenpin/domain/product/model/product.dart';
import 'package:greenpin/exports.dart';

part 'cart_data.freezed.dart';

@freezed
class CartData with _$CartData {
  factory CartData({
    required List<Product> products,
  }) = _CartData;
}
