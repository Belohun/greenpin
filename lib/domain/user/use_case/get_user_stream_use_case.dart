import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserStreamUseCase {
  GetUserStreamUseCase(this._userRepository);

  final UserRepository _userRepository;

  Stream<bool> call() => _userRepository.userStream;
}
