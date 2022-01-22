import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/domain/auth/token/user_token.dart';
import 'package:injectable/injectable.dart';

part 'user_token_entity.g.dart';

@JsonSerializable()
class UserTokenEntity {
  final String token;
  final String refreshToken;

  UserTokenEntity({
    required this.token,
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() => _$UserTokenEntityToJson(this);

  factory UserTokenEntity.fromJson(Map<String, dynamic> json) =>
      _$UserTokenEntityFromJson(json);
}

@Injectable()
class UserTokenEntityMapper
    implements BidirectionalDataMapper<UserToken, UserTokenEntity> {
  @override
  UserTokenEntity from(UserToken data) {
    return UserTokenEntity(
      token: data.token,
      refreshToken: data.refreshToken,
    );
  }

  @override
  UserToken to(UserTokenEntity data) {
    return UserToken(
      token: data.token,
      refreshToken: data.refreshToken,
    );
  }
}
