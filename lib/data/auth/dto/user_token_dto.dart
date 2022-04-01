import 'package:json_annotation/json_annotation.dart';

part 'user_token_dto.g.dart';

@JsonSerializable()
class UserTokenDto {
  UserTokenDto(this.token, this.refreshToken);

  final String token;
  final String refreshToken;

  Map<String, dynamic> toJson() => _$UserTokenDtoToJson(this);

  factory UserTokenDto.fromJson(Map<String, dynamic> json) =>
      _$UserTokenDtoFromJson(json);
}
