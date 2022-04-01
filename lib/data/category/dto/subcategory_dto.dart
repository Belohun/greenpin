import 'package:greenpin/data/category/dto/subcategory_content_dto.dart';
import 'package:greenpin/data/product/dto/product_dto.dart';
import 'package:greenpin/exports.dart';

part 'subcategory_dto.g.dart';

@JsonSerializable()
class SubcategoryDto {
  SubcategoryDto({
    required this.category,
    required this.productResponseList,
    required this.productListSize,
  });

  final SubcategoryContentDto category;
  final List<ProductDto> productResponseList;
  final int productListSize;

  factory SubcategoryDto.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryDtoToJson(this);
}
