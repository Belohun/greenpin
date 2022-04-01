import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/core/extension/iterable_extensions.dart';
import 'package:greenpin/core/extension/string_extensions.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';

part 'edit_user_data.freezed.dart';

@freezed
class EditUserData with _$EditUserData {
  const factory EditUserData({
    required String name,
    required String surName,
    required String phoneNumber,
    required List<AddressData> addressList,
  }) = _EditUserData;

  factory EditUserData.fromUserInfo(UserInfo userInfo) => _EditUserData(
        name: userInfo.name,
        surName: userInfo.surname,
        phoneNumber: userInfo.phoneNumber,
        addressList: userInfo.address,
      );
}

extension EditUserDataExtension on EditUserData {
  bool get isDeliveryAddressSelected =>
      addressList.containsWhere((element) => element.isDeliveryAddress);

  bool get isMoreThatOneDeliveryAddressSelected =>
      addressList.where((element) => element.isDeliveryAddress).length > 1;

  bool get isUserDataValid => name.isNotEmpty && surName.isNotEmpty;

  bool get areAddressesValid {
    var isAddressDataValid = true;

    for (final addressData in addressList) {
      isAddressDataValid = addressData.name.isNotEmptyAndNull &&
          addressData.street.isNotEmptyAndNull &&
          addressData.city.isNotEmptyAndNull &&
          addressData.buildingNumber.isNotEmptyAndNull &&
          isAddressDataValid;
      if (!isAddressDataValid) {
        break;
      }
    }
    return isAddressDataValid;
  }

  bool get isValid => isUserDataValid && areAddressesValid;
}
