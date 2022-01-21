import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/domain/auth/use_case/is_user_logged_in_use_case.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'entry_page_cubit.freezed.dart';

part 'entry_page_state.dart';

@injectable
class EntryPageCubit extends Cubit<EntryPageState> {
  EntryPageCubit(this._isUserLoggedInUseCase)
      : super(const EntryPageState.idle());

  final IsUserLoggedInUseCase _isUserLoggedInUseCase;

  void init() {
    if (_isUserLoggedInUseCase()) {
      emit(const EntryPageState.userLoggedIn());
    } else {
      emit(const EntryPageState.userNotLoggedIn());
    }
  }
}
