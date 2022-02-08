import 'package:freezed_annotation/freezed_annotation.dart';

part 'first_step_data.freezed.dart';

@freezed
class FirstStepData with _$FirstStepData {
  const factory FirstStepData({
    required bool siteAgreementAccepted,
    String? email,
    String? password,
    String? repeatPassword,
    String? emailError,
    String? passwordError,
    String? repeatPasswordError,
    String? siteAgreementAcceptedError,
  }) = _FirstStepData;
}

extension FirstStepDataExtension on FirstStepData {
  bool get isValid =>
      siteAgreementAcceptedError == null &&
      emailError == null &&
      passwordError == null &&
      repeatPasswordError == null;
}
