import 'package:greenpin/domain/user/model/user_info.dart';

abstract class UserRepository {
  Future<UserInfo> getUserInfo();
}
