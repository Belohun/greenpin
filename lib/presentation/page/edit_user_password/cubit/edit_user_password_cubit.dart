import 'package:bloc/bloc.dart';
import 'package:greenpin/core/app_regexp.dart';
import 'package:greenpin/domain/networking/error/inner_error.dart';
import 'package:greenpin/domain/user/use_case/edit_user_password_user_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/edit_user_password/model/edit_user_password_data.dart';
import 'package:greenpin/presentation/page/edit_user_password/model/edit_user_password_error.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'edit_user_password_cubit.freezed.dart';

part 'edit_user_password_state.dart';

@injectable
class EditUserPasswordCubit extends Cubit<EditUserPasswordState> {
  EditUserPasswordCubit(this._editUserPasswordUseCase)
      : super(EditUserPasswordState.initIdle()) {
    _data = EditUserPasswordData.empty();
  }

  final EditUserPasswordUseCase _editUserPasswordUseCase;

  late EditUserPasswordData _data;

  void changePassword(String text) {
    _data = _data.copyWith(
      password: text,
      error: _data.error.copyWith(
        passwordError: null,
      ),
    );
    _updateState();
  }

  void changeNewPassword(String text) {
    _data = _data.copyWith(
      newPassword: text,
      error: _data.error.copyWith(
        newPasswordError: null,
      ),
    );
    _updateState();
  }

  void changeNewPasswordRepeat(String text) {
    _data = _data.copyWith(
      newPasswordRepeat: text,
      error: _data.error.copyWith(
        newPasswordRepeatError: null,
      ),
    );
    _updateState();
  }

  Future<void> saveNewPassword() async {
    if (isValid()) {
      _data = _data.copyWith(isLoading: true);
      _updateState();
      final response = await _editUserPasswordUseCase(
        currentPassword: _data.password,
        password: _data.newPassword,
        repeatPassword: _data.newPasswordRepeat,
      );

      if (response.isSuccessful) {
        emit(const EditUserPasswordState.exitFlow());
      } else {
        response.requiredError.handleError(
          orElse: (String translatedErrorMessage) {
            emit(EditUserPasswordState.error(translatedErrorMessage));
          },
          innerErrors: (InnerError innerError) {
            emit(EditUserPasswordState.error(innerError.message?.tr() ??
                LocaleKeys.somethingWentWrong.tr()));
          },
        );
      }
      _data = _data.copyWith(isLoading: false);
    }

    _updateState();
  }

  void _updateState() {
    emit(EditUserPasswordState.idle(_data));
  }

  bool isValid() {
    var newError = EditUserPasswordError();
    if (!AppRegexp.password.hasMatch(_data.newPassword)) {
      newError = newError.copyWith(
        newPasswordError: EditPasswordTextError.invalidPassword,
      );
    }
    if (_data.newPassword != _data.newPasswordRepeat) {
      newError = newError.copyWith(
        newPasswordRepeatError: EditPasswordTextError.passwordsDoesNotMatch,
      );
    }

    _data = _data.copyWith(error: newError);

    return newError.isValid;
  }
}
