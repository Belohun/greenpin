import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/data/user/dto/role_dto.dart';
import 'package:greenpin/domain/user/model/role.dart';
import 'package:injectable/injectable.dart';

@injectable
class RoleMapper extends BidirectionalDataMapper<RoleDto, Role> {
  @override
  Role from(RoleDto data) {
    switch (data) {
      case RoleDto.CLIENT:
        return Role.client;

      case RoleDto.STORE_EMPLOYEE:
        return Role.storeEmployee;

      case RoleDto.STORE_MANAGER:
        return Role.storeManager;

      case RoleDto.ADMIN:
        return Role.admin;
    }
  }

  @override
  RoleDto to(Role data) {
    switch (data) {
      case Role.client:
        return RoleDto.CLIENT;

      case Role.storeEmployee:
        return RoleDto.STORE_EMPLOYEE;

      case Role.storeManager:
        return RoleDto.STORE_MANAGER;

      case Role.admin:
        return RoleDto.ADMIN;
    }
  }
}
