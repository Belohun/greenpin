import 'package:greenpin/exports.dart';

part 'product_category_dto.g.dart';

@JsonSerializable()
class ProductCategoryDto {
  ProductCategoryDto(
    this.name,
    this.url,
    this.id,
  );

  final String name;
  final String? url;
  final int id;

  factory ProductCategoryDto.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryDtoToJson(this);
}
