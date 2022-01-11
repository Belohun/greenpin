import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:greenpin/core/app_env.dart';
import 'package:injectable/injectable.dart';

@singleton
class GreenpinDio extends DioMixin implements Dio {
  static const _timeouts = Duration(seconds: 15);

  GreenpinDio(AppEnv appEnv) {
    options = BaseOptions(
      baseUrl: appEnv.apiUrl,
      sendTimeout: _timeouts.inMilliseconds,
      receiveTimeout: _timeouts.inMilliseconds,
      connectTimeout: _timeouts.inMilliseconds,
    );
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  @factoryMethod
  factory GreenpinDio.create(AppEnv appEnv) => GreenpinDio(appEnv);
}
