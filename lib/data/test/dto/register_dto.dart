import 'package:greenpin/data/test/dto/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable()
class RegisterDto {
  RegisterDto({
    required this.phoneNumber,
    required this.addressList,
    required this.surname,
    required this.repeatPassword,
    required this.password,
    required this.email,
    required this.name,
    required this.siteAgreementAccepted,
  });

  final String email;
  final String password;
  final String repeatPassword;
  final String name;
  final String surname;
  final String phoneNumber;
  final bool siteAgreementAccepted;
  final List<AddressDto> addressList;

  factory RegisterDto.fromJson(Map<String, dynamic> json) =>
      _$RegisterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);
}
