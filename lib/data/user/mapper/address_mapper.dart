import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/data/register/dto/address_dto.dart';
import 'package:greenpin/domain/user/model/address.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressMapper extends BidirectionalDataMapper<AddressDto, Address> {
  @override
  Address from(AddressDto data) {
    return Address(
      city: data.city,
      street: data.street,
      name: data.name,
      isDeliveryAddress: data.deliveryAddress,
      houseNumber: data.houseNumber,
    );
  }

  @override
  AddressDto to(Address data) {
    return AddressDto(
      city: data.city,
      street: data.street,
      name: data.name,
      deliveryAddress: data.isDeliveryAddress,
      houseNumber: data.houseNumber,
    );
  }
}
