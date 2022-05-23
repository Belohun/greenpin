import 'package:greenpin/data/database/local_single_store.dart';
import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserInfoUseCase {
  GetUserInfoUseCase(
    this._userRepository,
    this._userInfoDataStore,
  );

  final UserRepository _userRepository;
  final LocalSingleStore<UserInfo> _userInfoDataStore;

  Future<SafeResponse<UserInfo>> call({bool? updateCurrentUser}) => fetchSafety(
        () async {
          final localUserInfo = await _userInfoDataStore.read();

          if (localUserInfo != null && (updateCurrentUser == true)) {
            return localUserInfo;
          }

          final userInfo = await _userRepository.getUserInfo();

          await _userInfoDataStore.create(userInfo);

          return userInfo;
        },
      );
}
