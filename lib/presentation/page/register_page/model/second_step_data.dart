import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';

part 'second_step_data.freezed.dart';

@freezed
class SecondStepData with _$SecondStepData {
  const factory SecondStepData({
    required String name,
    required String surName,
    required String phoneNumber,
    required List<AddressData> addressList,
  }) = _SecondStepData;

  factory SecondStepData.empty() => _SecondStepData(
        name: '',
        surName: '',
        phoneNumber: '',
        addressList: [
          AddressData.empty(),
        ],
      );
}
