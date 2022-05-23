import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/core/di_config.dart';
import 'package:greenpin/data/user/provider/user_info_provider_impl.dart';
import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:greenpin/domain/networking/error/greenpin_api_error.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/domain/user/use_case/get_user_info_use_case.dart';
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
    this._getUserInfoUseCase,
  ) : super(const ProfileState.loading()) {
    _userSubscription = _getUserStreamUseCase().listen(_userListener);
  }

  Future<void> _userListener(event) async {
    emit(const ProfileState.loading());
    final userInfoResponse = await _getUserInfoUseCase(updateCurrentUser: true);

    if (userInfoResponse.isSuccessful) {
      _userInfo = userInfoResponse.requiredData;
    } else {
      userInfoResponse.requiredError.handleError(
        orElse: (String translatedErrorMessage) {
          emit(ProfileState.error(translatedErrorMessage));
        },
      );
    }
    _updateState();

  }

  void _updateState() {
    emit(ProfileState.idle(_userInfo));
  }

  late final StreamSubscription _userSubscription;

  final LogoutService _logoutService;
  final GetUserStreamUseCase _getUserStreamUseCase;
  final GetUserInfoUseCase _getUserInfoUseCase;

  late UserInfo _userInfo;

  Future<void> init() async {
    final userInfoProvider = await getIt.getAsync<UserInfoProvider>();
    _userInfo = userInfoProvider.userInfo;
    _updateState();
    print(_userInfo.email);
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
