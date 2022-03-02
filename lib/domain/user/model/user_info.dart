import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/domain/user/model/role.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';

part 'user_info.freezed.dart';

@freezed
class UserInfo with _$UserInfo {
  factory UserInfo({
    required String email,
    required String name,
    required String surname,
    required String phoneNumber,
    required List<AddressData> address,
    required List<Role> roles,
  }) = _UserInfo;
}
