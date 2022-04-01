import 'package:greenpin/exports.dart';

part 'subcategory_content_dto.g.dart';

@JsonSerializable()
class SubcategoryContentDto {
  SubcategoryContentDto({
    required this.id,
    required this.name,
    required this.main,
    required this.parentCategoryId,
    required this.imageUrl,
  });

  final int id;
  final String name;
  final int? parentCategoryId;
  final bool main;
  final String? imageUrl;

  factory SubcategoryContentDto.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryContentDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryContentDtoToJson(this);
}
