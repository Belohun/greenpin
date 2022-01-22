import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:greenpin/core/app_env.dart';
import 'package:greenpin/core/network_module.dart';
import 'package:greenpin/data/networking/interceptor_with_dio.dart';
import 'package:injectable/injectable.dart';

@singleton
class GreenpinDio extends DioMixin implements Dio {
  static const _timeouts = Duration(seconds: 15);

  GreenpinDio(
    AppEnv appEnv,
    List<Interceptor> interceptors,
  ) {
    options = BaseOptions(
      baseUrl: appEnv.apiUrl,
      sendTimeout: _timeouts.inMilliseconds,
      receiveTimeout: _timeouts.inMilliseconds,
      connectTimeout: _timeouts.inMilliseconds,
    );
    httpClientAdapter = DefaultHttpClientAdapter();
    _setupInterceptors(interceptors);
  }

  @factoryMethod
  factory GreenpinDio.create(
    AppEnv appEnv,
    @Named(mainInterceptors) List<Interceptor> interceptors,
  ) =>
      GreenpinDio(appEnv, interceptors);

  void _setupInterceptors(List<Interceptor> interceptorList) {
    interceptorList
        .whereType<InterceptorWithDio>()
        .forEach((element) => element.set(this));
    interceptors.addAll(interceptorList);
  }
}

@LazySingleton()
class AuthDio extends GreenpinDio {
  AuthDio(
    AppEnv appEnv,
    @Named(authInterceptors) List<Interceptor> interceptors,
  ) : super(
          appEnv,
          interceptors,
        );
}
