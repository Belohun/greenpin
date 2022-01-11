import 'package:dio/dio.dart';
import 'package:greenpin/data/networking/error_interceptor.dart';
import 'package:injectable/injectable.dart';

const mainInterceptors = 'main_interceptors';

@module
abstract class NetworkModule {
  @prod
  @Injectable()
  @Named(mainInterceptors)
  List<Interceptor> prodMainInterceptors(
    ErrorInterceptor errorInterceptor,
  ) =>
      [
        errorInterceptor,
      ];

  @dev
  @Injectable()
  @Named(mainInterceptors)
  List<Interceptor> devMainInterceptors(
    ErrorInterceptor errorInterceptor,
  ) =>
      [
        errorInterceptor,
      ];
}
