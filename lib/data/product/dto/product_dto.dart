import 'package:greenpin/exports.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  ProductDto({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.manufacturerName,
  });

  final int id;
  final String name;
  final String? imageUrl;
  final double price;
  final String? manufacturerName;
  final String description;

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);
}
