import 'package:greenpin/data/auth/api/login_data_source.dart';
import 'package:greenpin/data/auth/api/refresh_token_data_source.dart';
import 'package:greenpin/data/auth/dto/login_dto.dart';
import 'package:greenpin/data/auth/dto/refresh_token_dto.dart';
import 'package:greenpin/data/auth/dto/user_token_dto.dart';
import 'package:greenpin/domain/auth/repository/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthRepository)
class LoginRepositoryImpl implements AuthRepository {
  LoginRepositoryImpl(
    this._loginDataSource,
    this._refreshTokenDataSource,
  );

  final LoginDataSource _loginDataSource;
  final RefreshTokenDataSource _refreshTokenDataSource;

  @override
  Future<UserTokenDto> login(LoginDto dto) => _loginDataSource.login(dto);

  @override
  Future<UserTokenDto> refreshToken(RefreshTokenDto dto) =>
      _refreshTokenDataSource.refreshToken(dto);
}
