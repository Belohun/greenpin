import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'inner_error.freezed.dart';

part 'inner_error.g.dart';

@Freezed()
class InnerError with _$InnerError {
  factory InnerError({
    required String message,
    required String code,
  }) = DefaultInnerError;

  factory InnerError.fromJson(Map<String, dynamic> json) =>
      _$InnerErrorFromJson(json);
}
