import 'package:greenpin/data/category/dto/subcategory_content_dto.dart';
import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/domain/category/model/subcategory_content.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubcategoryContentMapper
    extends BidirectionalDataMapper<SubcategoryContentDto, SubcategoryContent> {
  @override
  SubcategoryContent from(SubcategoryContentDto data) => SubcategoryContent(
        id: data.id,
        name: data.name,
        main: data.main,
        parentCategoryId: data.parentCategoryId,
        imageUrl: data.imageUrl,
      );

  @override
  SubcategoryContentDto to(SubcategoryContent data) => SubcategoryContentDto(
        id: data.id,
        name: data.name,
        main: data.main,
        parentCategoryId: data.parentCategoryId,
        imageUrl: data.imageUrl,
      );
}
