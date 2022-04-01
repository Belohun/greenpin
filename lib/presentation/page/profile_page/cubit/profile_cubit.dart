import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/core/di_config.dart';
import 'package:greenpin/data/user/provider/user_info_provider_impl.dart';
import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/domain/user/use_case/get_user_stream_use_case.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'profile_cubit.freezed.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(
    this._logoutService,
    this._getUserStreamUseCase,
  ) : super(const ProfileState.loading()) {
    _userSubscription = _getUserStreamUseCase().listen((event) async {
      _userInfoProvider = await getIt.getAsync<UserInfoProvider>();
      emit(ProfileState.idle(_userInfoProvider.userInfo));
    });
  }

  late final StreamSubscription _userSubscription;

  final LogoutService _logoutService;
  final GetUserStreamUseCase _getUserStreamUseCase;

  late UserInfoProvider _userInfoProvider;

  Future<void> init() async {
    _userInfoProvider = await getIt.getAsync<UserInfoProvider>();
    emit(ProfileState.idle(_userInfoProvider.userInfo));
    print(_userInfoProvider.userInfo.email);
  }

  void logOut() {
    _logoutService.logout();
  }

  @override
  Future<void> close() async {
    await _userSubscription.cancel();
    await super.close();
  }
}
