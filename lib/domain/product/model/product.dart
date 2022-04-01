class Product {
  Product({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.manufacturerName,
    required this.description,
    required this.price,
  });

  final int id;
  final String name;
  final String imageUrl;
  final double price;
  final String manufacturerName;
  final String description;
}
