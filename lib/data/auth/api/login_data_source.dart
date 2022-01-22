import 'package:dio/dio.dart';
import 'package:greenpin/data/auth/dto/login_dto.dart';
import 'package:greenpin/data/auth/dto/user_token_dto.dart';
import 'package:greenpin/data/networking/greenpin_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'login_data_source.g.dart';

@RestApi()
@singleton
abstract class LoginDataSource {

  @factoryMethod
  factory LoginDataSource(AuthDio dio) = _LoginDataSource;

  @POST('/token')
  Future<UserTokenDto> login(@Body() LoginDto loginDto);
}
