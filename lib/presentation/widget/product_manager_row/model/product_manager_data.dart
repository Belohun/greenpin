import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/domain/product/model/product.dart';

part 'product_manager_data.freezed.dart';

@freezed
class ProductManagerData with _$ProductManagerData {
  factory ProductManagerData({required List<Product> products}) = _ProductManagerData;
}
