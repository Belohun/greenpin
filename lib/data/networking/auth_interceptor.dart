import 'dart:io';

import 'package:dio/dio.dart';
import 'package:greenpin/domain/auth/use_case/get_token_use_case.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class AuthTokenInterceptor extends Interceptor {
  final GetUserTokenUseCase _getUserTokenUseCase;

  AuthTokenInterceptor(this._getUserTokenUseCase);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    try {
      final token = await _getUserTokenUseCase();
      options.headers[HttpHeaders.authorizationHeader] = token.header;
    } catch (e, s) {
      print(
          'Failed adding authorization header to API call. ex: $e, stacktrace: $s');
    }

    super.onRequest(options, handler);
  }
}
