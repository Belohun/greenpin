import 'package:greenpin/data/user/api/user_data_source.dart';
import 'package:greenpin/data/user/mapper/user_info_mapper.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(
    this._userDataSource,
    this._userInfoMapper,
  );

  final UserDataSource _userDataSource;
  final UserInfoMapper _userInfoMapper;

  @override
  Future<UserInfo> getUserInfo() async {
    final dto = await _userDataSource.getUserInfo();
    return _userInfoMapper.from(dto);
  }
}
