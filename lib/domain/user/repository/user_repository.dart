import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/presentation/page/edit_user_data_page/cubit/edit_user_data.dart';

abstract class UserRepository {
  Future<UserInfo> getUserInfo();

  Future<void> updateUserInfo(EditUserData editUserData);

  Future<void> updateUserEmail(String email);

  Future<void> updateUserPassword({
    required String currentPassword,
    required String password,
    required String repeatPassword,
  });

  void addToUserStream(bool event);

  Stream<bool> get userStream;
}
