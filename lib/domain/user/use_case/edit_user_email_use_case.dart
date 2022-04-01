import 'package:greenpin/core/di_config.dart';
import 'package:greenpin/data/user/provider/user_info_provider_impl.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditUserEmailUseCase {
  const EditUserEmailUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<SafeResponse<void>> call(String email) => fetchSafety(() async {
        await _userRepository.updateUserEmail(email);

        final userInfoProvider = await getIt.getAsync<UserInfoProvider>();
        await userInfoProvider.clear();
        await getIt.getAsync<UserInfoProvider>();
        _userRepository.addToUserStream(true);
      });
}
