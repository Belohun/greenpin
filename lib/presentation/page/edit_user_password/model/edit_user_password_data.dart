import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/edit_user_password/model/edit_user_password_error.dart';

part 'edit_user_password_data.freezed.dart';

@freezed
class EditUserPasswordData with _$EditUserPasswordData {
  factory EditUserPasswordData({
    required String password,
    required String newPassword,
    required String newPasswordRepeat,
    required EditUserPasswordError error,
    required bool isLoading,
  }) = _EditUserPasswordData;

  factory EditUserPasswordData.empty() => _EditUserPasswordData(
        password: '',
        newPassword: '',
        newPasswordRepeat: '',
        error: EditUserPasswordError(),
        isLoading: false,
      );
}

extension EditUserPasswordDataExtension on EditUserPasswordData {
  bool get areRequiredFieldsFilled =>
      password.isNotEmpty &&
      newPassword.isNotEmpty &&
      newPasswordRepeat.isNotEmpty;
}
