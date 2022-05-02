import 'package:greenpin/exports.dart';

part 'product.freezed.dart';

@freezed
class Product with _$Product {
  factory Product({
    required String name,
    required int id,
    required String imageUrl,
    required String manufacturerName,
    required String description,
    required double price,
    required int quantity,
    required bool isSync,
    required String uuid,
  }) = _Product;
}
