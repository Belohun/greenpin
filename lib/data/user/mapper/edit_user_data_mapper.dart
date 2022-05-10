import 'package:greenpin/data/common/data_mapper.dart';
import 'package:greenpin/data/register/dto/address_dto.dart';
import 'package:greenpin/data/register/mapper/address_data_to_address_dto_mapper.dart';
import 'package:greenpin/data/user/dto/edit_user_data_dto.dart';
import 'package:greenpin/presentation/page/edit_user_data_page/cubit/edit_user_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditUserDataMapper extends DataMapper<EditUserData, EditUserDataDto> {
  EditUserDataMapper(this._addressDataToAddressDtoMapper);

  final AddressDataToAddressDtoMapper _addressDataToAddressDtoMapper;

  @override
  EditUserDataDto call(EditUserData data) {
    return EditUserDataDto(
      name: data.name,
      surname: data.surName,
      phoneNumber: data.phoneNumber,
      addressList: data.addressList
          .map<AddressDto>(_addressDataToAddressDtoMapper)
          .toList(),
    );
  }
}
