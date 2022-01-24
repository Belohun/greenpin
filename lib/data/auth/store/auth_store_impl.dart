import 'package:greenpin/data/auth/store/auth_secure_database.dart';
import 'package:greenpin/data/auth/store/user_token_entity.dart';
import 'package:greenpin/domain/auth/store/auth_store.dart';
import 'package:greenpin/domain/auth/token/user_token.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthStore)
class AuthStoreImpl implements AuthStore {
  AuthStoreImpl(this._authSecureDatabase, this._userTokenEntityMapper);

  final AuthSecureDatabase _authSecureDatabase;
  final UserTokenEntityMapper _userTokenEntityMapper;

  @override
  Future<UserToken?> loadUserToken() async {
    final entity = await _authSecureDatabase.loadToken();

    if (entity == null) return null;

    return _userTokenEntityMapper.to(entity);
  }

  @override
  Future<void> saveUserToken(UserToken token) async {
    final entity = _userTokenEntityMapper.from(token);
    await _authSecureDatabase.saveToken(entity);
  }

  @override
  Future<void> clear() async {
    await _authSecureDatabase.clear();
  }
}
