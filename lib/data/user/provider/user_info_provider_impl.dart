import 'package:greenpin/core/di_config.dart';
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
      GetUserInfoUseCase getUserInfoUseCase) async {
    final userInfo = await getUserInfoUseCase();
    return UserInfoProvider(userInfo);
  }

  @override
  Future<void> clear() async {
    await getIt.resetLazySingleton<UserInfoProvider>();
  }
}
