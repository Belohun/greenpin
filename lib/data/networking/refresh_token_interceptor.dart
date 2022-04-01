import 'dart:io';
import 'package:dio/dio.dart';
import 'package:greenpin/data/networking/interceptor_with_dio.dart';
import 'package:greenpin/domain/auth/exception/auth_exception.dart';
import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:greenpin/domain/auth/use_case/get_token_use_case.dart';
import 'package:greenpin/domain/auth/use_case/refresh_token_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RefreshTokenInterceptor extends InterceptorWithDio {
  RefreshTokenInterceptor(
    this._getUserTokensUseCase,
    this._refreshAccessTokenUseCase,
    this._logoutService,
  );

  final GetUserTokenUseCase _getUserTokensUseCase;
  final RefreshAccessTokenUseCase _refreshAccessTokenUseCase;
  final LogoutService _logoutService;

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response == null) return handler.next(err);

    if (err.response?.statusCode == HttpStatus.unauthorized) {
      try {
        dio.lockAll();

        final userToken = await _getUserTokensUseCase();
        final requestAuthHeader =
            err.requestOptions.headers[HttpHeaders.authorizationHeader];
        final currentAuthHeader = userToken.header;

        if (requestAuthHeader != currentAuthHeader) {
          await _retryRequest(err.requestOptions, handler, currentAuthHeader);
        } else {
          await _refreshAccessTokenAndRetryRequest(err, handler);
        }

        dio.unlockAll();
      } on AuthExceptionUserNotSignedIn catch (e) {
        dio.unlockAll();

        print('Making requests when user is not signed in., ex: $e');
        await _logoutService.logout();
        return handler.next(
          DioError(
              requestOptions: err.requestOptions,
              error: e,
              response: err.response),
        );
      } catch (e, s) {
        dio.unlockAll();

        print('Failed to retry unauthorized request., ex: $e, stacktrace: $s');
        return handler.next(DioError(
            requestOptions: err.requestOptions,
            error: e,
            response: err.response));
      }
    }

    return handler.next(err);
  }

  Future<void> _refreshAccessTokenAndRetryRequest(
      DioError err, ErrorInterceptorHandler handler) async {
    try {
      try {
        await _refreshAccessTokenUseCase();
      } on AuthException {
        print('Refresh token has expired, logging out.');
        await _logoutService.logout();
        handler.reject(err);
      } catch (e, s) {
        print(
            'Refresh token somehow failed, logging out. , ex: $e, stacktrace: $s');
        await _logoutService.logout();
        handler.reject(err);
      }

      final newToken = await _getUserTokensUseCase();
      final newAuthHeader = newToken.header;

      dio.unlockAll();

      await _retryRequest(err.requestOptions, handler, newAuthHeader);
    } catch (e, s) {
      print('Retry request failed, ex: $e, stacktrace: $s');
      handler.next(
        DioError(
          requestOptions: err.requestOptions,
          error: e,
          response: err.response,
        ),
      );
    }
  }

  Future<void> _retryRequest(RequestOptions requestOptions,
      ErrorInterceptorHandler handler, String authHeader) async {
    dio.unlockAll();

    final response = await dio.fetch(requestOptions);

    handler.resolve(response);
  }
}

extension on Dio {
  void lockAll() {
    interceptors.requestLock.lock();
    interceptors.responseLock.lock();
    interceptors.errorLock.lock();
  }

  void unlockAll() {
    interceptors.requestLock.unlock();
    interceptors.responseLock.unlock();
    interceptors.errorLock.unlock();
  }
}
