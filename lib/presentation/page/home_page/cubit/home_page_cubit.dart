import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:greenpin/presentation/page/home_page/model/home_tab_enum.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'home_page_cubit.freezed.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._logoutService) : super(const HomePageState.loading());

  final LogoutService _logoutService;

  late HomeTabEnum currentTab;

  Future<void> init(HomeTabEnum initTab) async {
    currentTab = initTab;
    _updateState();
  }

  void _updateState() {
    emit(HomePageState.idle(currentTab));
  }

  void logout() {
    _logoutService.logout();
  }

  void changeTab(HomeTabEnum newTab) {
    currentTab = newTab;
    _updateState();
  }
}
