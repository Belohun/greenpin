import 'package:greenpin/data/register/dto/address_dto.dart';
import 'package:greenpin/data/user/dto/role_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_info_dto.g.dart';

@JsonSerializable()
class UserInfoDto {
  const UserInfoDto({
    required this.email,
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.address,
    required this.roles,
  });

  final String email;
  final String name;
  final String surname;
  final String phoneNumber;
  final List<RoleDto> roles;
  final List<AddressDto> address;

  factory UserInfoDto.fromJson(Map<String, dynamic> json) =>
      _$UserInfoDtoFromJson(json);

  Map<String, dynamic> toJson() => _$UserInfoDtoToJson(this);
}
