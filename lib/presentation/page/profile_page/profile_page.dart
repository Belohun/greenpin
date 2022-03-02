import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/domain/user/model/user_info.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/profile_page/cubit/profile_cubit.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/button/greenpin_text_button.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/text/info_widgets.dart';

class ProfilePage extends HookWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<ProfileCubit>();
    final state = useCubitBuilder(cubit);

    useMemoized(() {
      cubit.init();
    }, [cubit]);

    return GreenpinLoadingContainer(
      isLoading: state is ProfileStateLoading,
      child: state.maybeMap(
        orElse: () => const SizedBox.shrink(),
        idle: (idleState) => SingleChildScrollView(
          child: Column(
            children: [
              _UserDataContainer(
                cubit: cubit,
                userInfo: idleState.userInfo,
              ),
              const Divider(thickness: 1),
              _AccountDataContainer(
                cubit: cubit,
                userInfo: idleState.userInfo,
              ),
              const Divider(thickness: 1),
              _LogoutButton(cubit: cubit),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final ProfileCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.l,
        vertical: AppDimens.xl,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GreenpinTextButton(
            text: LocaleKeys.logOut.tr(),
            onPressed: cubit.logOut,
            style: AppTypography.bodyText1.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}

class _AccountDataContainer extends StatelessWidget {
  const _AccountDataContainer({
    required this.cubit,
    required this.userInfo,
    Key? key,
  }) : super(key: key);

  final ProfileCubit cubit;
  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.l,
        vertical: AppDimens.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GreenpinHeader.small(text: LocaleKeys.accountData.tr() + ':'),
          const SizedBox(height: AppDimens.l),
          _InfoColumn(
            onEditPressed: () => AutoRouter.of(context)
                .navigate(EditUserEmailPageRoute(userEmail: userInfo.email)),
            name: '${LocaleKeys.email.tr()}:',
            info: userInfo.email,
          ),
          const SizedBox(height: AppDimens.m),
          _InfoColumn(
            onEditPressed: () => AutoRouter.of(context)
                .navigate(const EditUserPasswordPageRoute()),
            name: '${LocaleKeys.password.tr()}:',
            info: '*********',
          ),
          const SizedBox(height: AppDimens.m),
        ],
      ),
    );
  }
}

class _UserDataContainer extends StatelessWidget {
  const _UserDataContainer({
    required this.cubit,
    required this.userInfo,
    Key? key,
  }) : super(key: key);

  final ProfileCubit cubit;
  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.l,
        vertical: AppDimens.xl,
      ),
      child: Column(
        children: [
          _UserDataRow(userInfo: userInfo),
          const SizedBox(height: AppDimens.l),
          _InfoRow(
            name: '${LocaleKeys.name.tr()}:',
            info: userInfo.name,
          ),
          const SizedBox(height: AppDimens.m),
          _InfoRow(
            name: '${LocaleKeys.surname.tr()}:',
            info: userInfo.surname,
          ),
          const SizedBox(height: AppDimens.m),
          _InfoRow(
            name: '${LocaleKeys.phoneNumber.tr()}:',
            info: userInfo.phoneNumber,
          ),
          ...userInfo.address.map(
            (address) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimens.m),
                  GreenpinHeader.small(text: address.name),
                  const SizedBox(height: AppDimens.m),
                  _InfoRow(
                    name: '${LocaleKeys.city.tr()}:',
                    info: address.city,
                  ),
                  const SizedBox(height: AppDimens.m),
                  _InfoRow(
                    name: '${LocaleKeys.street.tr()}:',
                    info: address.street,
                  ),
                  const SizedBox(height: AppDimens.m),
                  _InfoRow(
                    name: '${LocaleKeys.buildingNumber.tr()}:',
                    info: address.buildingNumber,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.name,
    required this.info,
    Key? key,
  }) : super(key: key);

  final String name;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            name,
            style: AppTypography.bodyText1Bold,
          ),
        ),
        Expanded(
          child: Text(
            info,
            textAlign: TextAlign.end,
            style: AppTypography.bodyText1,
          ),
        ),
      ],
    );
  }
}

class _InfoColumn extends StatelessWidget {
  const _InfoColumn({
    required this.name,
    required this.info,
    required this.onEditPressed,
    Key? key,
  }) : super(key: key);

  final String name;
  final String info;
  final VoidCallback onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: AppTypography.bodyText1Bold,
              ),
              Text(
                info,
                style: AppTypography.bodyText1,
              ),
            ],
          ),
        ),
        Flexible(
          child: _EditButton(
            onPressed: onEditPressed,
          ),
        ),
      ],
    );
  }
}

class _UserDataRow extends StatelessWidget {
  const _UserDataRow({
    required this.userInfo,
    Key? key,
  }) : super(key: key);

  final UserInfo userInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GreenpinHeader.small(text: LocaleKeys.userData.tr() + ':'),
        _EditButton(
          onPressed: () => AutoRouter.of(context)
              .navigate(EditUserPageRoute(userInfo: userInfo)),
        ),
      ],
    );
  }
}

class _EditButton extends StatelessWidget {
  const _EditButton({
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GreenpinTextButton(
      text: LocaleKeys.edit.tr(),
      onPressed: onPressed,
      style: AppTypography.bodyText1.copyWith(color: AppColors.primary),
    );
  }
}
