import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/core/app_regexp.dart';
import 'package:greenpin/domain/networking/error/greenpin_api_error.dart';
import 'package:greenpin/domain/networking/error/inner_error.dart';
import 'package:greenpin/domain/user/use_case/edit_user_email_use_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/edit_user_email/cubit/edit_user_email_data.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'edit_user_email_cubit.freezed.dart';

part 'edit_user_email_state.dart';

@injectable
class EditUserEmailCubit extends Cubit<EditUserEmailState> {
  EditUserEmailCubit(
    @factoryParam EditEmailUserData data,
    this._editUserEmailUseCase,
  ) : super(EditUserEmailState.idle(data)) {
    _data = data;
  }

  final EditUserEmailUseCase _editUserEmailUseCase;

  late EditEmailUserData _data;

  void changeEmail(String email) {
    _data = _data.copyWith(
      email: email,
      emailError: null,
    );

    _updateState();
  }

  Future<void> saveEmail() async {
    final canRegister = validateData();

    if (canRegister) {
      _data = _data.copyWith(isLoading: true);
      _updateState();

      final response = await _editUserEmailUseCase(_data.email);
      if (response.isSuccessful) {
        emit(const EditUserEmailState.exitFlow());
      } else {
        response.requiredError.handleError(
          orElse: (_) {
            emit(EditUserEmailState.error(LocaleKeys.somethingWentWrong.tr()));
          },
          innerErrors: _handleInnerError,
        );
      }
    }
    _data = _data.copyWith(isLoading: false);
    _updateState();
  }

  bool validateData() {
    if (!AppRegexp.email.hasMatch(_data.email)) {
      _data = _data.copyWith(emailError: LocaleKeys.pleaseInputValidEmail.tr());
      return false;
    }
    return true;
  }

  void _updateState() {
    emit(EditUserEmailState.idle(_data));
  }

  void _handleInnerError(InnerError error) {
    if (error.code.contains('email')) {
      _data = _data.copyWith(emailError: error.message?.tr());
    } else {
      emit(EditUserEmailState.error(
          error.message?.tr() ?? LocaleKeys.somethingWentWrong.tr()));
    }
  }
}
