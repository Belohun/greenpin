import 'package:collection/collection.dart';
import 'package:greenpin/data/database/hive_data_source.dart';
import 'package:greenpin/data/database/local_single_store.dart';
import 'package:greenpin/data/user/entity/user_info_entity.dart';
import 'package:greenpin/data/user/mapper/user_info_entity_mapper.dart';
import 'package:greenpin/domain/user/model/user_info.dart';

class UserInfoDataStore implements LocalSingleStore<UserInfo> {
  UserInfoDataStore(
    this._userInfoDataSource,
    this._userInfoEntityMapper,
  );

  final HiveDataSource<UserInfoEntity> _userInfoDataSource;
  final UserInfoEntityMapper _userInfoEntityMapper;

  @override
  Future create(UserInfo value) {
    final userInfoEntity = _userInfoEntityMapper.from(value);
    return _userInfoDataSource.create(userInfoEntity);
  }

  @override
  Future delete(UserInfo value) => _userInfoDataSource.delete(value.email);

  @override
  Future<UserInfo?> read() async {
    final userInfoList = await _userInfoDataSource.all();
    final userInfo = userInfoList.firstOrNull;
    if (userInfo != null) {
      return _userInfoEntityMapper.to(userInfo);
    } else {
      return null;
    }
  }

  @override
  Future update(UserInfo value) {
    final userInfoEntity = _userInfoEntityMapper.from(value);
    return _userInfoDataSource.update(userInfoEntity);
  }

  @override
  Future clear() => _userInfoDataSource.clear();
}
