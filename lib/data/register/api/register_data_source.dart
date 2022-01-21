import 'package:dio/dio.dart';
import 'package:greenpin/data/networking/greenpin_dio.dart';
import 'package:greenpin/data/test/dto/register_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'register_data_source.g.dart';

@RestApi()
@singleton
abstract class RegisterDataSource {
  @factoryMethod
  factory RegisterDataSource(GreenpinDio dio) = _RegisterDataSource;

  @POST('/user/register')
  Future<void> register(@Body() RegisterDto registerDto);
}
