import 'package:greenpin/data/auth/dto/login_dto.dart';
import 'package:greenpin/data/auth/dto/refresh_token_dto.dart';
import 'package:greenpin/data/auth/dto/user_token_dto.dart';

abstract class AuthRepository {
  Future<UserTokenDto> login(LoginDto dto);

  Future<UserTokenDto> refreshToken(RefreshTokenDto dto);
}
