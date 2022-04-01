import 'package:greenpin/data/auth/dto/user_token_dto.dart';
import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/domain/auth/token/user_token.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UserTokenMapper extends BidirectionalDataMapper<UserTokenDto, UserToken> {
  @override
  UserToken from(UserTokenDto data) {
    return UserToken(
      refreshToken: data.refreshToken,
      token: data.token,
    );
  }

  @override
  UserTokenDto to(UserToken data) {
    return UserTokenDto(
      data.token,
      data.refreshToken,
    );
  }
}
