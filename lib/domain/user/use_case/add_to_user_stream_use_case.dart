import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToUserStreamUseCase {
  AddToUserStreamUseCase(this._userRepository);

  final UserRepository _userRepository;

  void call(bool event) => _userRepository.addToUserStream(event);
}
