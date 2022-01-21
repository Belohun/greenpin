import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/domain/networking/error/inner_error.dart';

part 'greenpin_api_error.freezed.dart';
part 'greenpin_api_error.g.dart';

@Freezed()
class GreenpinApiError with _$GreenpinApiError {
  factory GreenpinApiError.fromResponse({required List<InnerError> innerErrors}) = GreenpinApiErrorFromResponse;

  factory GreenpinApiError.noConnection() = GreenpinApiErrorNoConnection;

  factory GreenpinApiError.timeout() = GreenpinApiErrorTimeout;

  factory GreenpinApiError.unknownError(dynamic error) = GreenpinApiErrorrUnknownError;


  factory GreenpinApiError.fromJson(Map<String, dynamic> json) => _$GreenpinApiErrorFromJson(json);

}
