import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/core/app_regexp.dart';
import 'package:greenpin/domain/networking/error/greenpin_api_error.dart';
import 'package:greenpin/domain/networking/error/inner_error.dart';
import 'package:greenpin/domain/register/use_case/register_user_use_case.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';
import 'package:greenpin/presentation/page/register_page/model/first_step_data.dart';
import 'package:greenpin/presentation/page/register_page/model/register_page_data.dart';
import 'package:greenpin/presentation/page/register_page/model/register_page_enum.dart';
import 'package:greenpin/presentation/page/register_page/model/second_step_data.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'register_page_cubit.freezed.dart';

part 'register_page_state.dart';

@injectable
class RegisterPageCubit extends Cubit<RegisterPageState> {
  RegisterPageCubit(
    @factoryParam RegisterPageData? data,
    this._registerUserUseCase,
  )   : assert(
          data != null,
          'RegisterPageCubit factory param must be not null!',
        ),
        super(RegisterPageState.idle(data!)) {
    _data = data;
  }

  final RegisterUserUseCase _registerUserUseCase;

  late RegisterPageData _data;

  void passwordChange(String newPassword) {
    _data = _data.copyWith(
      firstStepData: _data.firstStepData.copyWith(
        password: newPassword,
        passwordError: null,
      ),
    );
    _updateState();
  }

  void repeatPasswordChange(String newRepeatPassword) {
    _data = _data.copyWith(
      firstStepData: _data.firstStepData.copyWith(
        repeatPassword: newRepeatPassword,
        repeatPasswordError: null,
      ),
    );
    _updateState();
  }

  void emailChange(String newEmail) {
    _data = _data.copyWith(
      firstStepData: _data.firstStepData.copyWith(
        email: newEmail,
        emailError: null,
      ),
    );
    _updateState();
  }

  void changeSiteAgreement() {
    _data = _data.copyWith(
      firstStepData: _data.firstStepData.copyWith(
        siteAgreementAccepted: !_data.firstStepData.siteAgreementAccepted,
        siteAgreementAcceptedError: null,
      ),
    );
    _updateState();
  }

  void _updateState() {
    _data = _data.validate(_validator);
    emit(RegisterPageState.idle(_data));
  }

  void nextPage() {
    if (_data.isOnFirstPage && _iFirstPageInputsValid(_data.firstStepData)) {
      _data = _data.copyWith(currentPage: RegisterPageEnum.secondStep);
    }
    _updateState();
  }

  void previousPage() {
    if (_data.isOnFirstPage) {
      emit(const RegisterPageState.exitFlow());
    } else {
      _data = _data.copyWith(currentPage: RegisterPageEnum.firstStep);
      _updateState();
    }
  }

  void nameChange(String newName) {
    final secondStepData = _data.secondStepData.copyWith(name: newName);
    _data = _data.copyWith(secondStepData: secondStepData);
  }

  void surNameChange(String newName) {
    final secondStepData = _data.secondStepData.copyWith(surName: newName);
    _data = _data.copyWith(secondStepData: secondStepData);
  }

  void phoneNumberChange(String phoneNumber) {
    final secondStepData = _data.secondStepData.copyWith(
      phoneNumber: phoneNumber,
      phoneNumberError: null,
    );
    _data = _data.copyWith(secondStepData: secondStepData);
    _updateState();
  }

  void cityChange(int index, String city) {
    var addressData = _data.secondStepData.addressList[index];
    addressData = addressData.copyWith(city: city);
    _updateAddressDataAtIndex(index, addressData);
  }

  void streetChange(int index, String street) {
    var addressData = _data.secondStepData.addressList[index];
    addressData = addressData.copyWith(street: street);
    _updateAddressDataAtIndex(index, addressData);
  }

  void buildingNumberChange(int index, String buildingNumber) {
    var addressData = _data.secondStepData.addressList[index];
    addressData = addressData.copyWith(buildingNumber: buildingNumber);
    _updateAddressDataAtIndex(index, addressData);
  }

  void isDeliveryAddressChange(int index, bool isDeliveryAddress) {
    var addressData = _data.secondStepData.addressList[index];
    addressData = addressData.copyWith(isDeliveryAddress: isDeliveryAddress);
    _updateAddressDataAtIndex(index, addressData);
  }

  void addressNameChange(int index, String addressName) {
    var addressData = _data.secondStepData.addressList[index];
    addressData = addressData.copyWith(name: addressName);
    _updateAddressDataAtIndex(index, addressData);
  }

  void _updateAddressDataAtIndex(int index, AddressData addressData) {
    final addressList = List.of(_data.secondStepData.addressList);
    addressList[index] = addressData;
    final secondStepData =
        _data.secondStepData.copyWith(addressList: addressList);
    _data = _data.copyWith(secondStepData: secondStepData);
    _updateState();
  }

  void createNewAddress() {
    final addressList = List.of(_data.secondStepData.addressList);
    addressList.add(AddressData.empty());
    final secondStepData =
        _data.secondStepData.copyWith(addressList: addressList);
    _data = _data.copyWith(secondStepData: secondStepData);
    _updateState();
  }

  void deleteAddressAtIndex(int index) {
    final addressList = List.of(_data.secondStepData.addressList);
    addressList.removeAt(index);
    final secondStepData =
        _data.secondStepData.copyWith(addressList: addressList);
    _data = _data.copyWith(secondStepData: secondStepData);
    _updateState();
  }

  bool _validator(RegisterPageData data) {
    switch (data.currentPage) {
      case RegisterPageEnum.firstStep:
        return _firstStepValidator(data.firstStepData);
      case RegisterPageEnum.secondStep:
        return _secondStepValidator(data.secondStepData);
    }
  }

  bool _firstStepValidator(FirstStepData data) =>
      data.email.isNotEmptyAndNull &&
      data.password.isNotEmptyAndNull &&
      data.repeatPassword.isNotEmptyAndNull;

  bool _secondStepValidator(SecondStepData data) {
    final validUserData = data.name.isNotEmptyAndNull &&
        data.surName.isNotEmptyAndNull &&
        data.phoneNumber.isNotEmptyAndNull;
    if (!validUserData) return false;

    final isAddressDataValid = _isAddressDataValid(data);

    return isAddressDataValid;
  }

  bool _isAddressDataValid(SecondStepData data) {
    var isAddressDataValid = true;

    for (final addressData in data.addressList) {
      isAddressDataValid = addressData.name.isNotEmptyAndNull &&
          addressData.street.isNotEmptyAndNull &&
          addressData.city.isNotEmptyAndNull &&
          addressData.buildingNumber.isNotEmptyAndNull &&
          isAddressDataValid;
      if (!isAddressDataValid) {
        break;
      }
    }
    return isAddressDataValid;
  }

  bool _iFirstPageInputsValid(FirstStepData data) {
    var _firstPageData = data;
    if (!AppRegexp.email.hasMatch(data.email ?? '')) {
      _firstPageData = _firstPageData.copyWith(
          emailError: LocaleKeys.pleaseInputValidEmail.tr());
    }
    if (!AppRegexp.password.hasMatch(data.password ?? '')) {
      _firstPageData = _firstPageData.copyWith(
          passwordError: LocaleKeys.invalidPassword.tr());
    }
    if (data.repeatPassword != data.password) {
      _firstPageData = _firstPageData.copyWith(
          repeatPasswordError: LocaleKeys.passwordsDoesNotMatch.tr());
    }
    if (!data.siteAgreementAccepted) {
      _firstPageData = _firstPageData.copyWith(
          siteAgreementAcceptedError: LocaleKeys.acceptTerms.tr());
    }

    _data = _data.copyWith(firstStepData: _firstPageData);

    return _firstPageData.isValid;
  }

  Future<void> register() async {
    if (_data.secondStepData.phoneNumber.length < 9) {
      final secondStepData = _data.secondStepData
          .copyWith(phoneNumberError: LocaleKeys.phoneNumberRequirement.tr());
      _data = _data.copyWith(secondStepData: secondStepData);
      emit(const RegisterPageState.scrollToStart());
    } else if (!_data.secondStepData.isDeliveryAddressSelected) {
      emit(RegisterPageState.error(
          LocaleKeys.deliveryAddressMustBeSelected.tr()));
    } else {
      if (_data.secondStepData.isMoreThatOneDeliveryAddressSelected) {
        emit(RegisterPageState.error(LocaleKeys.onlyOneAddressCanBe.tr()));
      } else {
        _data = _data.copyWith(isLoading: true);
        _updateState();

        final response = await _registerUserUseCase(_data);
        if (response.isSuccessful) {
          emit(const RegisterPageState.successfulRegister());
        } else {
          response.requiredError.handleError(
            innerErrors: _handleInnerError,
            orElse: (translatedErrorMessage) {
              emit(RegisterPageState.error(LocaleKeys.somethingWentWrong.tr()));
            },
          );
        }

        _data = _data.copyWith(isLoading: false);

      }
    }
    _updateState();
  }

  void _handleInnerError(InnerError error) {
    if (error.code.contains('email')) {
      final firstStepData =
          _data.firstStepData.copyWith(emailError: error.code.tr());
      _data = _data.copyWith(
        firstStepData: firstStepData,
        currentPage: RegisterPageEnum.firstStep,
      );
    } else {
      emit(RegisterPageState.error(
          error.message?.tr() ?? LocaleKeys.somethingWentWrong.tr()));
    }
  }
}
