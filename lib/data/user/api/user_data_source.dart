import 'package:dio/dio.dart';
import 'package:greenpin/data/networking/greenpin_dio.dart';
import 'package:greenpin/data/user/dto/edit_user_data_dto.dart';
import 'package:greenpin/data/user/dto/edit_user_email_dto.dart';
import 'package:greenpin/data/user/dto/edit_user_password_dto.dart';
import 'package:greenpin/data/user/dto/user_info_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'user_data_source.g.dart';

@RestApi()
@singleton
abstract class UserDataSource {
  @factoryMethod
  factory UserDataSource(GreenpinDio dio) = _UserDataSource;

  @GET('/user/info')
  Future<UserInfoDto> getUserInfo();

  @POST('/user')
  Future<void> updateUser(@Body() EditUserDataDto editUserDataDto);

  @POST('/user')
  Future<void> updateUserEmail(@Body() EditUserEmailDto editUserEmailDto);

  @PUT('/user')
  Future<void> updateUserPassword(
      @Body() EditUserPasswordDto editUserPasswordDto);
}
