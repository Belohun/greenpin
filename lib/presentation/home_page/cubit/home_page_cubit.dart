import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/domain/test/use_case/test_use_case.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'home_page_cubit.freezed.dart';

part 'home_page_state.dart';

@injectable
class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(this._testUseCase) : super(const HomePageState.idle());

  final TestUseCase _testUseCase;

  Future<void> init() async {
    try {
      await _testUseCase();
    } catch (_) {
      emit(const HomePageState.error());
    }
  }
}
