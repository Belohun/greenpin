import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/edit_user_data_page/cubit/edit_user_cubit.dart';
import 'package:greenpin/presentation/page/edit_user_data_page/cubit/edit_user_data.dart';
import 'package:greenpin/presentation/page/register_page/model/address_data.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/util/snackbar_util.dart';
import 'package:greenpin/presentation/widget/button/greenpin_checkbox.dart';
import 'package:greenpin/presentation/widget/button/greenpin_icon_button.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/button/greenpin_text_button.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/text/info_widgets.dart';
import 'package:greenpin/presentation/widget/text_field/greenpin_text_field.dart';

class EditUserPage extends StatelessWidget {
  const EditUserPage({
    required this.userInfo,
    Key? key,
  }) : super(key: key);

  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenpinAppbar.green(),
      body: _EditUserBody(userInfo: userInfo),
    );
  }
}

class _EditUserBody extends HookWidget {
  const _EditUserBody({
    required this.userInfo,
    Key? key,
  }) : super(key: key);

  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    final cubit =
        useCubitWithParam<EditUserCubit>(EditUserData.fromUserInfo(userInfo));
    final state = useCubitBuilder(cubit);

    useCubitListener(cubit, _listener);

    return GreenpinLoadingContainer(
      isLoading: state is EditUserStateLoading,
      child: state.maybeMap(
        orElse: () => const SizedBox.shrink(),
        idle: (stateIdle) => _Body(
          data: stateIdle.data,
          cubit: cubit,
        ),
      ),
    );
  }

  void _listener(
    EditUserCubit cubit,
    EditUserState current,
    BuildContext context,
  ) {
    current.maybeMap(
      orElse: () {},
      error: (errorState) {
        SnackBarUtils.showErrorSnackBar(context, errorState.errorMessage);
      },
      exitFlow: (_) {
        AutoRouter.of(context).pop();
      },
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.data,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final EditUserData data;
  final EditUserCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimens.l),
            child: Column(
              children: [
                GreenpinHeader(text: LocaleKeys.userData.tr()),
                const SizedBox(height: AppDimens.l),
                GreenpinTextField(
                  initText: data.name,
                  onChanged: cubit.nameChange,
                  labelText: LocaleKeys.name.tr(),
                ),
                const SizedBox(height: AppDimens.xm),
                GreenpinTextField(
                  initText: data.surName,
                  onChanged: cubit.surNameChange,
                  labelText: LocaleKeys.surname.tr(),
                ),
                const SizedBox(height: AppDimens.xm),
                GreenpinTextField(
                  initText: data.phoneNumber,
                  textInputType: TextInputType.number,
                  onChanged: cubit.phoneNumberChange,
                  labelText: LocaleKeys.phoneNumber.tr(),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: data.addressList.length,
                  itemBuilder: (context, index) {
                    return HookBuilder(
                      builder: (BuildContext context) {
                        final key = useMemoized(
                          () => UniqueKey(),
                          [data.addressList.length],
                        );

                        return _AddressDataColumn(
                          index: index,
                          address: data.addressList[index],
                          cubit: cubit,
                          key: key,
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: AppDimens.l),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
            text: LocaleKeys.save.tr(),
            onPressed: data.isValid ? cubit.updateUserData : null,
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
    required this.address,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final int index;
  final AddressData address;
  final EditUserCubit cubit;

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
          initText: address.name,
          labelText: LocaleKeys.nameOfAddress.tr(),
          onChanged: (addressName) => cubit.addressNameChange(
            index,
            addressName,
          ),
        ),
        const SizedBox(height: AppDimens.xm),
        GreenpinTextField(
          initText: address.city,
          labelText: LocaleKeys.city.tr(),
          onChanged: (city) => cubit.cityChange(
            index,
            city,
          ),
        ),
        const SizedBox(height: AppDimens.xm),
        GreenpinTextField(
          initText: address.street,
          labelText: LocaleKeys.street.tr(),
          onChanged: (street) => cubit.streetChange(
            index,
            street,
          ),
        ),
        const SizedBox(height: AppDimens.xm),
        GreenpinTextField(
          initText: address.buildingNumber,
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
              value: address.isDeliveryAddress,
              onPressed: () => cubit.isDeliveryAddressChange(
                index,
                !address.isDeliveryAddress,
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
