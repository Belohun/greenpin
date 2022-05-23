import 'package:greenpin/data/database/database_configuration.dart';
import 'package:hive/hive.dart';

part 'role.g.dart';

@HiveType(typeId: HiveTypesIds.roleEntityType)
enum Role {
  @HiveField(0)
  client,
  @HiveField(1)
  storeEmployee,
  @HiveField(2)
  storeManager,
  @HiveField(3)
  admin,
}
