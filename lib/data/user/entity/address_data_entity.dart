import 'package:greenpin/data/database/database_configuration.dart';
import 'package:hive/hive.dart';

part 'address_data_entity.g.dart';

@HiveType(typeId: HiveTypesIds.addressDataEntityType)
class AddressDataEntity extends HiveObject {
  AddressDataEntity({
    required this.name,
    required this.buildingNumber,
    required this.city,
    required this.isDeliveryAddress,
    required this.street,
  });

  @HiveField(0)
  final String name;
  @HiveField(1)
  final String city;
  @HiveField(2)
  final String street;
  @HiveField(3)
  final String buildingNumber;
  @HiveField(4)
  final bool isDeliveryAddress;
}
