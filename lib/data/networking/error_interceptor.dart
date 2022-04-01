import 'dart:io';

import 'package:dio/dio.dart';
import 'package:greenpin/data/networking/greenpin_dio_error_wrapper.dart';
import 'package:greenpin/domain/networking/error/greenpin_api_error.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final response = err.response;

    if (err.type == DioErrorType.response && response != null) {
      try {
        final rawData = response.data as Map<String, dynamic>;
        final jsonData = rawData['error'] as Map<String, dynamic>;
        final greenpinApiError = GreenpinApiErrorFromResponse.fromJson(jsonData);

        return handler.next(
          GreenpinDioErrorWrapper(
            greenpinApiError: greenpinApiError,
            original: err,
          ),
        );
      } catch (e, s) {
        print(
            'Parsing response error from API failed. ,ex: $e, stacktrace: $s');
        return handler.next(
          GreenpinDioErrorWrapper(
            greenpinApiError: GreenpinApiError.unknownError(err),
            original: err,
          ),
        );
      }
    }

    if (err.error is SocketException) {
      return handler.next(
        GreenpinDioErrorWrapper(
          greenpinApiError: GreenpinApiError.noConnection(),
          original: err,
        ),
      );
    }

    if (_isTimeout(err.type)) {
      return handler.next(
        GreenpinDioErrorWrapper(
          greenpinApiError: GreenpinApiError.timeout(),
          original: err,
        ),
      );
    }

    return handler.next(
      GreenpinDioErrorWrapper(
        greenpinApiError: GreenpinApiError.unknownError(err),
        original: err,
      ),
    );
  }



  bool _isTimeout(DioErrorType type) {
    return type == DioErrorType.receiveTimeout ||
        type == DioErrorType.connectTimeout ||
        type == DioErrorType.sendTimeout;
  }
}
