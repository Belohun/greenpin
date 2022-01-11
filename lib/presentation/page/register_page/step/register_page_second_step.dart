import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/register_page/cubit/register_page_cubit.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';
import 'package:greenpin/presentation/page/register_page/model/register_page_data.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/button/greenpin_checkbox.dart';
import 'package:greenpin/presentation/widget/button/greenpin_icon_button.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/button/greenpin_text_button.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/text/info_widgets.dart';
import 'package:greenpin/presentation/widget/text_field/greenpin_text_field.dart';

class RegisterPageSecondStep extends HookWidget {
  const RegisterPageSecondStep({
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final RegisterPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    final state = useCubitBuilder(cubit);

    return state.maybeMap(
      orElse: () => const SizedBox.shrink(),
      idle: (stateIdle) => _Body(
        data: stateIdle.data,
        cubit: cubit,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.data,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final RegisterPageData data;
  final RegisterPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
            child: Column(
              children: [
                GreenpinHeader(text: LocaleKeys.fillYourData.tr()),
                const SizedBox(height: AppDimens.s),
                GreenpinSubHeader(text: LocaleKeys.dataRequiredToDelivery.tr()),
                const SizedBox(height: AppDimens.ml),
                GreenpinTextField(
                  initText: data.secondStepData.name,
                  onChanged: cubit.nameChange,
                  labelText: LocaleKeys.name.tr(),
                ),
                const SizedBox(height: AppDimens.xm),
                GreenpinTextField(
                  initText: data.secondStepData.surName,
                  onChanged: cubit.surNameChange,
                  labelText: LocaleKeys.surname.tr(),
                ),
                const SizedBox(height: AppDimens.xm),
                GreenpinTextField(
                  initText: data.secondStepData.phoneNumber,
                  onChanged: cubit.phoneNumberChange,
                  labelText: LocaleKeys.phoneNumber.tr(),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: data.secondStepData.addressList.length,
                  itemBuilder: (context, index) {
                    return HookBuilder(
                      builder: (BuildContext context) {
                        final key = useMemoized(
                          () => UniqueKey(),
                          [data.secondStepData.addressList.length],
                        );

                        return _AddressDataColumn(
                          index: index,
                          addressData: data.secondStepData.addressList[index],
                          cubit: cubit,
                          key: key,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppDimens.l),
                Row(
                  children: [
                    GreenpinIconButton(
                      onPressed: cubit.createNewAddress,
                      iconData: Icons.add,
                    ),
                    const SizedBox(width: AppDimens.ml),
                    GreenpinSubHeader(text: LocaleKeys.addAddress.tr()),
                  ],
                ),
                const SizedBox(height: AppDimens.xxl),
              ],
            ),
          ),
          GreenpinPrimaryButton(
            text: LocaleKeys.register.tr(),
            onPressed: data.isValid ? cubit.register : null,
          ),
          const Image(
            fit: BoxFit.fitWidth,
            image: AssetImage('assets/img/vegtables_register_page.jpeg'),
          ),
        ],
      ),
    );
  }
}

class _AddressDataColumn extends StatelessWidget {
  const _AddressDataColumn({
    required this.index,
    required this.addressData,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final int index;
  final AddressData addressData;
  final RegisterPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimens.xxl),
        GreenpinHeader(
          text: index > 0
              ? LocaleKeys.additionalAddress.tr()
              : LocaleKeys.addressData.tr(),
        ),
        const SizedBox(height: AppDimens.l),
        GreenpinTextField(
          initText: addressData.name,
          labelText: LocaleKeys.nameOfAddress.tr(),
          onChanged: (addressName) => cubit.addressNameChange(
            index,
            addressName,
          ),
        ),
        const SizedBox(height: AppDimens.xm),
        GreenpinTextField(
          initText: addressData.city,
          labelText: LocaleKeys.city.tr(),
          onChanged: (city) => cubit.cityChange(
            index,
            city,
          ),
        ),
        const SizedBox(height: AppDimens.xm),
        GreenpinTextField(
          initText: addressData.street,
          labelText: LocaleKeys.street.tr(),
          onChanged: (street) => cubit.streetChange(
            index,
            street,
          ),
        ),
        const SizedBox(height: AppDimens.xm),
        GreenpinTextField(
          initText: addressData.buildingNumber,
          labelText: LocaleKeys.buildingNumber.tr(),
          onChanged: (buildingNumber) => cubit.buildingNumberChange(
            index,
            buildingNumber,
          ),
        ),
        const SizedBox(height: AppDimens.ml),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GreenpinCheckbox(
              value: addressData.isDeliveryAddress,
              onPressed: () => cubit.isDeliveryAddressChange(
                index,
                !addressData.isDeliveryAddress,
              ),
            ),
            const SizedBox(width: AppDimens.m),
            GreenpinSubHeader(text: LocaleKeys.deliveryData.tr()),
            if (index > 0) ...[
              const Spacer(),
              GreenpinTextButton(
                text: LocaleKeys.deleteAddress.tr(),
                onPressed: () => cubit.deleteAddressAtIndex(index),
                style: AppTypography.bodyText1.copyWith(color: AppColors.red),
              ),
            ]
          ],
        ),
      ],
    );
  }
}
