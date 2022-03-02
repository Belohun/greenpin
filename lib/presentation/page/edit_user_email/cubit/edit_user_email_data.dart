import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_user_email_data.freezed.dart';

@freezed
class EditEmailUserData with _$EditEmailUserData {
  const factory EditEmailUserData({
    required String email,
    required bool isLoading,
    String? emailError,
  }) = _EditEmailUserData;
}

extension EditEmailUserDataExtension on EditEmailUserData {
  bool get canSave => email.isNotEmpty;
}
