import 'package:dio/dio.dart';
import 'package:greenpin/data/networking/auth_interceptor.dart';
import 'package:greenpin/data/networking/error_interceptor.dart';
import 'package:greenpin/data/networking/refresh_token_interceptor.dart';
import 'package:greenpin/data/networking/response_interceptor.dart';
import 'package:injectable/injectable.dart';

const mainInterceptors = 'main_interceptors';
const authInterceptors = 'auth_interceptors';

@module
abstract class NetworkModule {
  @prod
  @Injectable()
  @Named(mainInterceptors)
  List<Interceptor> prodMainInterceptors(
    ErrorInterceptor errorInterceptor,
    AuthTokenInterceptor authTokenInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
    ResponseInterceptor responseInterceptor,
  ) =>
      [
        authTokenInterceptor,
        refreshTokenInterceptor,
        errorInterceptor,
        responseInterceptor,
      ];

  @dev
  @Injectable()
  @Named(mainInterceptors)
  List<Interceptor> devMainInterceptors(
    ErrorInterceptor errorInterceptor,
    AuthTokenInterceptor authTokenInterceptor,
    RefreshTokenInterceptor refreshTokenInterceptor,
    ResponseInterceptor responseInterceptor,
  ) =>
      [
        authTokenInterceptor,
        refreshTokenInterceptor,
        errorInterceptor,
        responseInterceptor,
      ];

  @prod
  @Injectable()
  @Named(authInterceptors)
  List<Interceptor> prodAuthInterceptors(
    ErrorInterceptor errorInterceptor,
    ResponseInterceptor responseInterceptor,
  ) =>
      [
        errorInterceptor,
        responseInterceptor,
      ];

  @dev
  @Injectable()
  @Named(authInterceptors)
  List<Interceptor> devAuthInterceptors(
    ErrorInterceptor errorInterceptor,
    ResponseInterceptor responseInterceptor,
  ) =>
      [
        errorInterceptor,
        responseInterceptor,
      ];
}
