import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/core/app_regexp.dart';
import 'package:greenpin/domain/auth/use_case/login_use_case.dart';
import 'package:greenpin/domain/networking/error/api_errors.dart';
import 'package:greenpin/domain/networking/error/greenpin_api_error.dart';
import 'package:greenpin/domain/networking/error/inner_error.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/login_page/model/login_page_data.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'login_page_cubit.freezed.dart';

part 'login_page_state.dart';

@injectable
class LoginPageCubit extends Cubit<LoginPageState> {
  LoginPageCubit(this._loginUseCase)
      : super(LoginPageState.idle(LoginPageData.init())) {
    _data = LoginPageData.init();
  }

  final LoginUseCase _loginUseCase;

  late LoginPageData _data;

  void emailChange(String newEmail) {
    _data = _data.copyWith(
      email: newEmail,
      emailError: null,
    );

    _updateState();
  }

  void passwordChange(String newPassword) {
    _data = _data.copyWith(password: newPassword);
    _updateState();
  }

  void _updateState() {
    _data = _data.validate(_validator);
    emit(LoginPageState.idle(_data));
  }

  Future<void> logIn() async {
    final canLogin = _isInputValid();
    if (canLogin) {
      _data = _data.copyWith(isLoading: true);
      _updateState();

      final response = await _loginUseCase(_data);
      if (response.isSuccessful) {
        emit(const LoginPageState.loginSuccessful());
      } else {
        response.requiredError.handleError(
          orElse: (errorMessage) => emit(LoginPageState.error(errorMessage)),
          innerErrors: _handleInnerError,
        );
      }
      _data = _data.copyWith(isLoading: false);
    }
    _updateState();
  }

  void _handleInnerError(InnerError innerError) {
    if (innerError.message != null &&
        innerError.message!.contains(ApiErrors.badCredentials)) {
      emit(LoginPageState.error(LocaleKeys.invalidLoginOrPassword.tr()));
    } else {
      emit(LoginPageState.error(LocaleKeys.somethingWentWrong.tr()));
    }
  }

  bool _isInputValid() {
    if (!AppRegexp.email.hasMatch(_data.email ?? '')) {
      _data = _data.copyWith(emailError: LocaleKeys.pleaseInputValidEmail.tr());
      return false;
    }
    return true;
  }

  bool _validator(LoginPageData data) =>
      data.email.isNotEmptyAndNull && data.password.isNotEmptyAndNull;
}
