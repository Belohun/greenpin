import 'package:dio/dio.dart';
import 'package:greenpin/data/networking/greenpin_dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'test_api_data_source.g.dart';

@RestApi()
@singleton
abstract class TestApiDataSource {

  @factoryMethod
  factory TestApiDataSource(GreenpinDio dio) = _TestApiDataSource;

  @GET('/greenpin/info/health')
  Future test();

}