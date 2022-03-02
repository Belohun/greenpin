import 'package:greenpin/exports.dart';

part 'edit_user_password_error.freezed.dart';

@freezed
class EditUserPasswordError with _$EditUserPasswordError {
  factory EditUserPasswordError({
    EditPasswordTextError? passwordError,
    EditPasswordTextError? newPasswordError,
    EditPasswordTextError? newPasswordRepeatError,
  }) = _EditUserPasswordError;
}

enum EditPasswordTextError {
  invalid,
  invalidPassword,
  passwordsDoesNotMatch,
}

extension EditPasswordTextErrorExtension on EditPasswordTextError {
  String get translate {
    switch (this) {
      case EditPasswordTextError.invalid:
        return LocaleKeys.incorrectPassword.tr();
      case EditPasswordTextError.invalidPassword:
        return LocaleKeys.invalidPassword.tr();
      case EditPasswordTextError.passwordsDoesNotMatch:
        return LocaleKeys.passwordsDoesNotMatch.tr();
    }
  }
}

extension EditUserPasswordErrorExtension on EditUserPasswordError {
  bool get isValid =>
      passwordError == null &&
      newPasswordError == null &&
      newPasswordRepeatError == null;
}
