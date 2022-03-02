import 'package:greenpin/data/networking/greenpin_dio_error_wrapper.dart';
import 'package:greenpin/domain/networking/error/greenpin_api_error.dart';

enum ResponseStatus { success, failure }

class SafeResponse<T> {
  late final ResponseStatus status;
  late final T? data;
  late final GreenpinApiError? error;

  bool get isSuccessful => status == ResponseStatus.success;

  bool get isFailure => status == ResponseStatus.failure;

  T get requiredData => isSuccessful
      ? data!
      : throw Exception(
          'Cannot access to requiredData because SafeResponse has failure status');

  GreenpinApiError get requiredError => isFailure
      ? error!
      : throw Exception(
          'Cannot access to requiredError because SafeResponse has success status');

  SafeResponse.success(this.data) {
    status = ResponseStatus.success;
    error = null;
  }

  SafeResponse.error(this.error) {
    status = ResponseStatus.failure;
    data = null;
  }

  void throwIfNotSuccessful() {
    if (isFailure) {
      throw error!;
    }
  }

  SafeResponse.unknownError(error) {
    status = ResponseStatus.failure;
    error = GreenpinApiError.unknownError(error);
    data = null;
  }
}

Future<SafeResponse<T>> fetchSafety<T>(
  Future<T> Function() request, {
  Function(dynamic)? onError,
}) async {
  try {
    final data = await request();
    return SafeResponse.success(data);
  } catch (error) {
    if (onError != null) {
      onError(error);
    }
    if (error is GreenpinApiError) {
      return SafeResponse.error(error);
    } else if (error is GreenpinDioErrorWrapper) {
      return SafeResponse.error(error.greenpinApiError);
    }
    return SafeResponse.unknownError(error);
  }
}
