import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/domain/auth/use_case/update_user_info_use_case.dart';
import 'package:greenpin/domain/networking/error/greenpin_api_error.dart';
import 'package:greenpin/domain/networking/error/inner_error.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/edit_user_data_page/cubit/edit_user_data.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:injectable/injectable.dart';

part 'edit_user_cubit.freezed.dart';

part 'edit_user_state.dart';

@injectable
class EditUserCubit extends Cubit<EditUserState> {
  EditUserCubit(
    @factoryParam EditUserData? data,
    this._updateUserInfoUseCase,
  )   : assert(data != null),
        super(EditUserState.idle(data!)) {
    _data = data;
  }

  final UpdateUserInfoUseCase _updateUserInfoUseCase;

  late EditUserData _data;

  Future<void> updateUserData() async {
    if (_data.isDeliveryAddressSelected) {
      if (_data.isMoreThatOneDeliveryAddressSelected) {
        emit(EditUserState.error(LocaleKeys.onlyOneAddressCanBe.tr()));
      } else {
        emit(const EditUserState.loading());
        final response = await _updateUserInfoUseCase(_data);
        if (response.isSuccessful) {
          emit(const EditUserState.exitFlow());
        } else {
          response.requiredError.handleError(
            innerErrors: (InnerError innerError) {
              emit(EditUserState.error(LocaleKeys.somethingWentWrong.tr()));
            },
            orElse: (error) {
              emit(EditUserState.error(error));
            },
          );
        }
        emit(EditUserState.idle(_data));
      }
    } else {
      emit(EditUserState.error(LocaleKeys.deliveryAddressMustBeSelected.tr()));
    }
  }

  void nameChange(String text) {
    _data = _data.copyWith(name: text);
    _updateState();
  }

  void surNameChange(String text) {
    _data = _data.copyWith(surName: text);
    _updateState();
  }

  void _updateState() {
    emit(EditUserState.idle(_data));
  }

  void phoneNumberChange(String text) {
    _data = _data.copyWith(phoneNumber: text);
    _updateState();
  }

  void addressNameChange(int index, String addressName) {
    var addressData = _data.addressList[index];
    addressData = addressData.copyWith(name: addressName);
    _updateAddressDataAtIndex(index, addressData);
  }

  void _updateAddressDataAtIndex(int index, AddressData addressData) {
    final addressList = List.of(_data.addressList);
    addressList[index] = addressData;
    _data = _data.copyWith(addressList: addressList);
    _updateState();
  }

  void cityChange(int index, String city) {
    var addressData = _data.addressList[index];
    addressData = addressData.copyWith(city: city);
    _updateAddressDataAtIndex(index, addressData);
  }

  void streetChange(int index, String street) {
    var addressData = _data.addressList[index];
    addressData = addressData.copyWith(street: street);
    _updateAddressDataAtIndex(index, addressData);
  }

  void buildingNumberChange(int index, String buildingNumber) {
    var addressData = _data.addressList[index];
    addressData = addressData.copyWith(buildingNumber: buildingNumber);
    _updateAddressDataAtIndex(index, addressData);
  }

  void isDeliveryAddressChange(int index, bool isDeliveryAddress) {
    var addressData = _data.addressList[index];
    addressData = addressData.copyWith(isDeliveryAddress: isDeliveryAddress);
    _updateAddressDataAtIndex(index, addressData);
  }

  void deleteAddressAtIndex(int index) {
    final addressList = List.of(_data.addressList);
    addressList.removeAt(index);
    _data = _data.copyWith(addressList: addressList);
    _updateState();
  }

  void createNewAddress() {
    final addressList = List.of(_data.addressList);
    addressList.add(AddressData.empty());
    _data = _data.copyWith(addressList: addressList);
    _updateState();
  }
}
