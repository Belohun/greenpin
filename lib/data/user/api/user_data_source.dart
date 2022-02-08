import 'package:dio/dio.dart';
import 'package:greenpin/data/networking/greenpin_dio.dart';
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
}
