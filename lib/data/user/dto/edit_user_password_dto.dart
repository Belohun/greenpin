import 'package:json_annotation/json_annotation.dart';

part 'edit_user_password_dto.g.dart';

@JsonSerializable()
class EditUserPasswordDto {
  EditUserPasswordDto({
    required this.password,
    required this.repeatPassword,
    required this.currentPassword,
  });

  final String currentPassword;
  final String password;
  final String repeatPassword;

  factory EditUserPasswordDto.fromJson(Map<String, dynamic> json) =>
      _$EditUserPasswordDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserPasswordDtoToJson(this);
}
