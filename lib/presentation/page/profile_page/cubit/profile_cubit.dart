import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/core/di_config.dart';
import 'package:greenpin/data/user/provider/user_info_provider_impl.dart';
import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'profile_cubit.freezed.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._logoutService) : super(const ProfileState.loading());

  final LogoutService _logoutService;

  late final UserInfoProvider _userInfoProvider;

  Future<void> init() async {
    _userInfoProvider = await getIt.getAsync<UserInfoProvider>();
    emit(ProfileState.idle(_userInfoProvider.userInfo));
    print(_userInfoProvider.userInfo.email);
  }

  void logOut() {
    _logoutService.logout();
  }
}
