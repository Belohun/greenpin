import 'package:greenpin/core/di_config.dart';
import 'package:greenpin/data/user/provider/user_info_provider_impl.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:greenpin/presentation/page/edit_user_data_page/cubit/edit_user_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateUserInfoUseCase {
  const UpdateUserInfoUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<SafeResponse<void>> call(EditUserData editUserData) =>
      fetchSafety(() async {
        await _userRepository.updateUserInfo(editUserData);
        final userInfoProvider = await getIt.getAsync<UserInfoProvider>();
        await userInfoProvider.clear();
        await getIt.getAsync<UserInfoProvider>();
        _userRepository.addToUserStream(true);
      });
}
