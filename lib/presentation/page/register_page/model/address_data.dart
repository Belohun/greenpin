import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_data.freezed.dart';

@freezed
class AddressData with _$AddressData {
  const factory AddressData({
    required String name,
    required String city,
    required String street,
    required String buildingNumber,
    required bool isDeliveryAddress,
  }) = _AddressData;

  factory AddressData.empty() => const _AddressData(
        name: '',
        city: '',
        street: '',
        buildingNumber: '',
        isDeliveryAddress: false,
      );
}
