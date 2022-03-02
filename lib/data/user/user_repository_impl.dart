import 'dart:async';

import 'package:greenpin/data/user/api/user_data_source.dart';
import 'package:greenpin/data/user/dto/edit_user_email_dto.dart';
import 'package:greenpin/data/user/dto/edit_user_password_dto.dart';
import 'package:greenpin/data/user/mapper/edit_user_data_mapper.dart';
import 'package:greenpin/data/user/mapper/user_info_mapper.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:greenpin/presentation/page/edit_user_data_page/cubit/edit_user_data.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
    this._userDataSource,
    this._userInfoMapper,
    this._editUserDataMapper,
  );

  final UserDataSource _userDataSource;
  final UserInfoMapper _userInfoMapper;
  final EditUserDataMapper _editUserDataMapper;

  final StreamController<bool> userStreamController =
      StreamController.broadcast();

  @override
  Future<UserInfo> getUserInfo() async {
    final dto = await _userDataSource.getUserInfo();
    return _userInfoMapper.from(dto);
  }

  @override
  Future<void> updateUserInfo(EditUserData editUserData) {
    final dto = _editUserDataMapper(editUserData);
    return _userDataSource.updateUser(dto);
  }

  @override
  void addToUserStream(bool event) => userStreamController.add(event);

  @override
  Stream<bool> get userStream => userStreamController.stream;

  @override
  Future<void> updateUserEmail(String email) {
    final dto = EditUserEmailDto(email: email);
    return _userDataSource.updateUserEmail(dto);
  }

  @override
  Future<void> updateUserPassword({
    required String currentPassword,
    required String password,
    required String repeatPassword,
  }) {
    final dto = EditUserPasswordDto(
      currentPassword: currentPassword,
      password: password,
      repeatPassword: repeatPassword,
    );

    return _userDataSource.updateUserPassword(dto);
  }
}
