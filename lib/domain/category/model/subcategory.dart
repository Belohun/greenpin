import 'package:greenpin/domain/category/model/subcategory_content.dart';
import 'package:greenpin/domain/product/model/product.dart';

class Subcategory {
  Subcategory({
    required this.category,
    required this.productResponseList,
    required this.productListSize,
  });

  final SubcategoryContent category;
  final List<Product> productResponseList;
  final int productListSize;
}
