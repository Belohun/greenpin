import 'package:greenpin/data/common/data_mapper.dart';
import 'package:greenpin/data/register/dto/address_dto.dart';
import 'package:greenpin/data/register/dto/register_dto.dart';
import 'package:greenpin/data/register/mapper/address_data_to_address_dto_mapper.dart';
import 'package:greenpin/presentation/page/register_page/model/register_page_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterPageDataToRegisterDtoMapper
    extends DataMapper<RegisterPageData, RegisterDto> {
  RegisterPageDataToRegisterDtoMapper(this._addressDataToAddressDtoMapper);

  final AddressDataToAddressDtoMapper _addressDataToAddressDtoMapper;

  @override
  RegisterDto call(RegisterPageData data) {
    return RegisterDto(
      phoneNumber: data.secondStepData.phoneNumber,
      addressList: data.secondStepData.addressList
          .map<AddressDto>(_addressDataToAddressDtoMapper)
          .toList(),
      name: data.secondStepData.name,
      surname: data.secondStepData.surName,
      repeatPassword: data.firstStepData.repeatPassword ?? '',
      password: data.firstStepData.password ?? '',
      email: data.firstStepData.email ?? '',
      siteAgreementAccepted: data.firstStepData.siteAgreementAccepted,
    );
  }
}
