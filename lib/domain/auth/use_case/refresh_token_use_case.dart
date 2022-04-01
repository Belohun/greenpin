import 'package:greenpin/data/auth/dto/refresh_token_dto.dart';
import 'package:greenpin/data/auth/mapper/user_token_mapper.dart';
import 'package:greenpin/domain/auth/exception/auth_exception.dart';
import 'package:greenpin/domain/auth/repository/auth_repository.dart';
import 'package:greenpin/domain/auth/store/auth_store.dart';
import 'package:injectable/injectable.dart';

@injectable
class RefreshAccessTokenUseCase {
  RefreshAccessTokenUseCase(
    this._authRepository,
    this._authStore,
    this._userTokenMapper,
  );

  final AuthRepository _authRepository;
  final AuthStore _authStore;
  final UserTokenMapper _userTokenMapper;

  Future<void> call() async {
    final token = await _authStore.loadUserToken();

    if (token == null) throw AuthException.notSignedIn();

    final refreshTokenDto = RefreshTokenDto(refreshToken: token.refreshToken);

    final refreshedTokenDto =
        await _authRepository.refreshToken(refreshTokenDto);

    final userToken = _userTokenMapper.from(refreshedTokenDto);

    await _authStore.saveUserToken(userToken);
  }
}
