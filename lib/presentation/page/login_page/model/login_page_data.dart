import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_page_data.freezed.dart';

@freezed
class LoginPageData with _$LoginPageData {
  factory LoginPageData({
    required bool isLoading,
    required bool isValid,
    String? email,
    String? emailError,
    String? password,
    String? passwordError,
  }) = _LoginPageData;

  factory LoginPageData.init() => _LoginPageData(
        isLoading: false,
        isValid: false,
      );
}

extension LoginPageDataExtension on LoginPageData {
  LoginPageData validate(bool Function(LoginPageData data) validator) =>
      copyWith(isValid: validator(this));
}
