import 'package:json_annotation/json_annotation.dart';

part 'edit_user_email_dto.g.dart';

@JsonSerializable()
class EditUserEmailDto {
  EditUserEmailDto({required this.email});

  final String email;

  factory EditUserEmailDto.fromJson(Map<String, dynamic> json) =>
      _$EditUserEmailDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EditUserEmailDtoToJson(this);
}
