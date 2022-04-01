import 'package:greenpin/data/category/dto/product_category_dto.dart';
import 'package:greenpin/exports.dart';

part 'categories_response_dto.g.dart';

@JsonSerializable()
class CategoriesResponseDto {
  CategoriesResponseDto(this.categories);

  final List<ProductCategoryDto> categories;

  factory CategoriesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CategoriesResponseDtoToJson(this);
}
