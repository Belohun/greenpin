import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserInfoUseCase {
  GetUserInfoUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<UserInfo> call() => _userRepository.getUserInfo();
}
