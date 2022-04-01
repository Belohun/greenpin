import 'package:greenpin/domain/auth/store/auth_store.dart';
import 'package:injectable/injectable.dart';

@injectable
class IsUserLoggedInUseCase {
  IsUserLoggedInUseCase(this._authStore);

  final AuthStore _authStore;

  Future<bool> call() async {
    final userToken = await _authStore.loadUserToken();
    return userToken != null;
  }

  
}
