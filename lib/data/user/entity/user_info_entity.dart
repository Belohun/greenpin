import 'package:greenpin/data/database/database_configuration.dart';
import 'package:greenpin/data/database/hive_entity.dart';
import 'package:greenpin/data/user/entity/address_data_entity.dart';
import 'package:greenpin/domain/user/model/role.dart';
import 'package:hive/hive.dart';

part 'user_info_entity.g.dart';

@HiveType(typeId: HiveTypesIds.userInfoEntityType)
class UserInfoEntity extends HiveObject implements HiveEntity<UserInfoEntity> {
  UserInfoEntity({
    required this.phoneNumber,
    required this.name,
    required this.email,
    required this.address,
    required this.roles,
    required this.surname,
  });

  @HiveField(0)
  final String email;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String surname;
  @HiveField(3)
  final String phoneNumber;
  @HiveField(4)
  final List<AddressDataEntity> address;
  @HiveField(5)
  final List<Role> roles;

  @HiveField(6)
  @override
  String get uuid => email;
}
