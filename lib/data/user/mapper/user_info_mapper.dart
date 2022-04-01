import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/data/user/dto/user_info_dto.dart';
import 'package:greenpin/data/user/mapper/address_mapper.dart';
import 'package:greenpin/data/user/mapper/role_mapper.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserInfoMapper extends BidirectionalDataMapper<UserInfoDto, UserInfo> {
  UserInfoMapper(
    this._addressMapper,
    this._roleMapper,
  );

  final AddressMapper _addressMapper;
  final RoleMapper _roleMapper;

  @override
  UserInfo from(UserInfoDto data) {
    return UserInfo(
      email: data.email,
      name: data.name,
      surname: data.surname,
      phoneNumber: data.phoneNumber,
      address: data.address.map(_addressMapper.from).toList(),
      roles: data.roles.map(_roleMapper.from).toList(),
    );
  }

  @override
  UserInfoDto to(UserInfo data) {
    return UserInfoDto(
      email: data.email,
      name: data.name,
      surname: data.surname,
      phoneNumber: data.phoneNumber,
      address: data.address.map(_addressMapper.to).toList(),
      roles: data.roles.map(_roleMapper.to).toList(),
    );
  }
}
