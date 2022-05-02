import 'package:greenpin/data/database/database_configuration.dart';
import 'package:greenpin/data/database/hive_entity.dart';
import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: HiveTypesIds.productEntityType)
class ProductEntity extends HiveObject implements HiveEntity<ProductEntity> {
  ProductEntity({
    required this.name,
    required this.id,
    required this.imageUrl,
    required this.price,
    required this.description,
    required this.manufacturerName,
    required this.quantity,
    required this.isSync,
    required this.uuid,
  });

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String imageUrl;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String manufacturerName;

  @HiveField(5)
  final String description;

  @HiveField(6)
  final int quantity;

  @HiveField(7)
  final bool isSync;

  @override
  @HiveField(8)
  final String uuid;
}
