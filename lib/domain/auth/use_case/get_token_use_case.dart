import 'package:greenpin/domain/auth/exception/auth_exception.dart';
import 'package:greenpin/domain/auth/store/auth_store.dart';
import 'package:greenpin/domain/auth/token/user_token.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetUserTokenUseCase {
  GetUserTokenUseCase(this._authStore);

  final AuthStore _authStore;

  Future<UserToken> call() async {
    final token = await _authStore.loadUserToken();

    if (token == null) throw AuthException.notSignedIn();

    return token;
  }
}
