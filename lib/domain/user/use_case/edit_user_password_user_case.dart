import 'package:greenpin/domain/networking/safe_response/safe_response.dart';
import 'package:greenpin/domain/user/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditUserPasswordUseCase {
  EditUserPasswordUseCase(this._userRepository);

  final UserRepository _userRepository;

  Future<SafeResponse<void>> call({
    required String currentPassword,
    required String password,
    required String repeatPassword,
  }) =>
      fetchSafety(
        () => _userRepository.updateUserPassword(
          password: password,
          repeatPassword: repeatPassword,
          currentPassword: currentPassword,
        ),
      );
}
