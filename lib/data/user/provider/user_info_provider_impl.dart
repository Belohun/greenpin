import 'package:greenpin/core/di_config.dart';
import 'package:greenpin/domain/auth/exception/auth_exception.dart';
import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:greenpin/domain/common/clearable.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/domain/user/use_case/get_user_info_use_case.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UserInfoProvider implements Clearable {
  UserInfoProvider(this.userInfo);

  final UserInfo userInfo;

  @factoryMethod
  static Future<UserInfoProvider> create(
    GetUserInfoUseCase getUserInfoUseCase,
    LogoutService logoutService,
  ) async {
    final userInfo = await getUserInfoUseCase();
    if (userInfo.isSuccessful) {
      return UserInfoProvider(userInfo.requiredData);
    } else {
      await logoutService.logout();
      throw AuthException.notSignedIn();
    }
  }

  @override
  Future<void> clear() async {
    await getIt.resetLazySingleton<UserInfoProvider>();
  }
}
