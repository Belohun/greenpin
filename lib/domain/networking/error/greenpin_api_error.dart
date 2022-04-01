import 'package:greenpin/domain/networking/error/inner_error.dart';
import 'package:greenpin/exports.dart';

part 'greenpin_api_error.freezed.dart';

part 'greenpin_api_error.g.dart';

@Freezed()
class GreenpinApiError with _$GreenpinApiError {
  factory GreenpinApiError.fromResponse(
      {required List<InnerError> innerErrors}) = GreenpinApiErrorFromResponse;

  factory GreenpinApiError.noConnection() = GreenpinApiErrorNoConnection;

  factory GreenpinApiError.timeout() = GreenpinApiErrorTimeout;

  factory GreenpinApiError.unknownError(dynamic error) =
      GreenpinApiErrorrUnknownError;

  factory GreenpinApiError.fromJson(Map<String, dynamic> json) =>
      _$GreenpinApiErrorFromJson(json);
}

extension GreenApiErrorExtension on GreenpinApiError {
  void handleError({
    required Function(String translatedErrorMessage) orElse,
    required Function(InnerError innerError) innerErrors,
  }) {
    maybeMap(
      orElse: () => orElse(LocaleKeys.somethingWentWrong.tr()),
      timeout: (_) => orElse(LocaleKeys.connectionTimeOut.tr()),
      unknownError: (_) => orElse(LocaleKeys.somethingWentWrong.tr()),
      fromResponse: (fromResponse) =>
          fromResponse.innerErrors.forEach(innerErrors),
    );
  }
}
