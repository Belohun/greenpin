import 'package:greenpin/data/category/dto/subcategory_dto.dart';
import 'package:greenpin/data/category/mapper/subcategory_content_mapper.dart';
import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/data/product/mapper/product_mapper.dart';
import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:injectable/injectable.dart';

@injectable
class SubcategoryMapper
    extends BidirectionalDataMapper<SubcategoryDto, Subcategory> {
  SubcategoryMapper(
    this._subcategoryContentMapper,
    this._productMapper,
  );

  final SubcategoryContentMapper _subcategoryContentMapper;
  final ProductMapper _productMapper;

  @override
  Subcategory from(SubcategoryDto data) => Subcategory(
        category: _subcategoryContentMapper.from(data.category),
        productResponseList:
            data.productResponseList.map(_productMapper.from).toList(),
        productListSize: data.productListSize,
      );

  @override
  SubcategoryDto to(Subcategory data) => SubcategoryDto(
        category: _subcategoryContentMapper.to(data.category),
        productResponseList:
            data.productResponseList.map(_productMapper.to).toList(),
        productListSize: data.productListSize,
      );
}
