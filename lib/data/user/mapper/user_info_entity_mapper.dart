import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/data/user/entity/user_info_entity.dart';
import 'package:greenpin/data/user/mapper/address_data_entity_mapper.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserInfoEntityMapper
    extends BidirectionalDataMapper<UserInfo, UserInfoEntity> {
  UserInfoEntityMapper(this._addressDataEntityMapper);

  final AddressDataEntityMapper _addressDataEntityMapper;

  @override
  UserInfoEntity from(UserInfo data) => UserInfoEntity(
        phoneNumber: data.phoneNumber,
        name: data.name,
        email: data.email,
        address: data.address.map(_addressDataEntityMapper.to).toList(),
        roles: data.roles,
        surname: data.surname,
      );

  @override
  UserInfo to(UserInfoEntity data) => UserInfo(
        phoneNumber: data.phoneNumber,
        name: data.name,
        email: data.email,
        address: data.address.map(_addressDataEntityMapper.from).toList(),
        roles: data.roles,
        surname: data.surname,
      );
}
