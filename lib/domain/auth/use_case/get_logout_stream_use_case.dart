import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetLogoutStreamUseCase {
  GetLogoutStreamUseCase(this._logoutService);

  final LogoutService _logoutService;

  Stream<void> call() => _logoutService.logoutEventStream;
}
