import 'package:dio/dio.dart';
import 'package:greenpin/domain/networking/error/greenpin_api_error.dart';

class GreenpinDioErrorWrapper extends DioError {
  final GreenpinApiError greenpinApiError;

  GreenpinDioErrorWrapper({
    required this.greenpinApiError,
    required DioError original,
  }) : super(
          requestOptions: original.requestOptions,
          response: original.response,
          error: original.error,
          type: original.type,
        );
}
