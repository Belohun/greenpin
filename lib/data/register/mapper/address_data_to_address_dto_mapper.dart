import 'package:greenpin/data/common/data_mapper.dart';
import 'package:greenpin/data/register/dto/address_dto.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressDataToAddressDtoMapper extends DataMapper<AddressData, AddressDto> {


  @override
  AddressDto call(AddressData data) {
    return AddressDto(
      city: data.city,
      street: data.street,
      name: data.name,
      isDeliveryAddress: data.isDeliveryAddress,
      houseNumber: data.buildingNumber,
    );
  }
}
