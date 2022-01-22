import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/domain/auth/service/logout_service.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'home_page_cubit.freezed.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._logoutService) : super(const HomePageState.idle());

  final LogoutService _logoutService;

  Future<void> init() async {}

  void logout() {
    _logoutService.logout();
  }
}
