import 'package:dio/dio.dart';
import 'package:greenpin/data/auth/dto/refresh_token_dto.dart';
import 'package:greenpin/data/auth/dto/user_token_dto.dart';
import 'package:greenpin/data/networking/greenpin_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'refresh_token_data_source.g.dart';

@Singleton()
@RestApi()
abstract class RefreshTokenDataSource {
  @factoryMethod
  factory RefreshTokenDataSource(AuthDio dio) = _RefreshTokenDataSource;

  @POST('/refreshToken')
  Future<UserTokenDto> refreshToken(@Body() RefreshTokenDto refreshTokenDto);
}
