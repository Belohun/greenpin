import 'package:greenpin/domain/auth/token/user_token.dart';
import 'package:greenpin/domain/common/clearable.dart';

abstract class AuthStore implements Clearable {
  Future<void> saveUserToken(UserToken token);

  Future<UserToken?> loadUserToken();
}