import 'package:greenpin/data/common/bidirectional_data_mapper.dart';
import 'package:greenpin/data/user/entity/address_data_entity.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddressDataEntityMapper
    extends BidirectionalDataMapper<AddressDataEntity, AddressData> {
  @override
  AddressData from(AddressDataEntity data) => AddressData(
        name: data.name,
        city: data.city,
        street: data.street,
        buildingNumber: data.buildingNumber,
        isDeliveryAddress: data.isDeliveryAddress,
      );

  @override
  AddressDataEntity to(AddressData data) => AddressDataEntity(
        name: data.name,
        city: data.city,
        street: data.street,
        buildingNumber: data.buildingNumber,
        isDeliveryAddress: data.isDeliveryAddress,
      );
}
