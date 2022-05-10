import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:greenpin/exports.dart';

part 'category_data.freezed.dart';

@freezed
class CategoryData with _$CategoryData {
  factory CategoryData(
      {required int page,
      required Subcategory originalSubcategory,
      required List<Product> productList,
      required bool shouldFetch}) = _CategoryData;

  factory CategoryData.fromSubcategory({required Subcategory subcategory}) =>
      _CategoryData(
        page: 1,
        originalSubcategory: subcategory,
        productList: subcategory.productResponseList,
        shouldFetch: subcategory.productResponseList.length <
            subcategory.productListSize,
      );
}

extension CategoryDataExtension on CategoryData {
  bool get shouldFetchMore =>
      productList.length < originalSubcategory.productListSize;
}
