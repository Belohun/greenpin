import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/data/register/dto/address_dto.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressMapper extends BidirectionalDataMapper<AddressDto, AddressData> {
  @override
  AddressData from(AddressDto data) {
    return AddressData(
      city: data.city,
      street: data.street,
      name: data.name,
      isDeliveryAddress: data.deliveryAddress,
      buildingNumber: data.houseNumber,
    );
  }

  @override
  AddressDto to(AddressData data) {
    return AddressDto(
      city: data.city,
      street: data.street,
      name: data.name,
      deliveryAddress: data.isDeliveryAddress,
      houseNumber: data.buildingNumber,
    );
  }
}
