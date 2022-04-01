class SubcategoryContent {
  SubcategoryContent({
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
}
