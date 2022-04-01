import 'package:json_annotation/json_annotation.dart';

part 'address_dto.g.dart';

@JsonSerializable()
class AddressDto {
  const AddressDto({
    required this.city,
    required this.street,
    required this.name,
    required this.deliveryAddress,
    required this.houseNumber,
  });

  final String name;
  final String city;
  final String street;
  final String houseNumber;
  final bool deliveryAddress;

  factory AddressDto.fromJson(Map<String, dynamic> json) => _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);
}
