import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:greenpin/exports.dart';

part 'categories_data.freezed.dart';

@freezed
class CategoriesData with _$CategoriesData {
  factory CategoriesData({required List<Subcategory> subcategoryList, required List<Product> allProducts}) = _CategoriesData;
}
