import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserInfoUseCase {
  GetUserInfoUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<SafeResponse<UserInfo>> call() =>
      fetchSafety(() => _userRepository.getUserInfo());
  //TODO add user info to db, fetch it from there to improve
}
