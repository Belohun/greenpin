import 'package:greenpin/data/register/dto/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_user_data_dto.g.dart';

@JsonSerializable()
class EditUserDataDto {
  EditUserDataDto({
    required this.name,
    required this.surname,
    required this.phoneNumber,
    required this.addressList,
  });

  final String name;
  final String surname;
  final String phoneNumber;
  final List<AddressDto> addressList;

  factory EditUserDataDto.fromJson(Map<String, dynamic> json) =>
      _$EditUserDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserDataDtoToJson(this);
}
