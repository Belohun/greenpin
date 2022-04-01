import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/edit_user_password/cubit/edit_user_password_cubit.dart';
import 'package:greenpin/presentation/page/edit_user_password/model/edit_user_password_data.dart';
import 'package:greenpin/presentation/page/edit_user_password/model/edit_user_password_error.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/util/snackbar_util.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/text/info_widgets.dart';
import 'package:greenpin/presentation/widget/text_field/greenpin_text_field.dart';

class EditUserPasswordPage extends HookWidget {
  const EditUserPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GreenpinAppbar.green(),
      body: const _Body(),
    );
  }
}

class _Body extends HookWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<EditUserPasswordCubit>();
    final state = useCubitBuilder(cubit);

    useCubitListener(cubit, _listener);

    return state.maybeMap(
      orElse: () => const SizedBox.shrink(),
      idle: (idleState) => GreenpinLoadingContainer(
        isLoading: idleState.data.isLoading,
        child: _Content(
          data: idleState.data,
          cubit: cubit,
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.data,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final EditUserPasswordData data;
  final EditUserPasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(AppDimens.l),
                child: Column(
                  children: [
                    GreenpinHeader(text: LocaleKeys.setNewPassword.tr()),
                    const SizedBox(height: AppDimens.l),
                    Text(
                      LocaleKeys.invalidPassword.tr(),
                      textAlign: TextAlign.center,
                      style: AppTypography.bodyText1,
                    ),
                    const SizedBox(height: AppDimens.l),
                    GreenpinTextField(
                      isPassword: true,
                      initText: data.password,
                      onChanged: cubit.changePassword,
                      errorText: data.error.passwordError?.translate,
                      labelText: LocaleKeys.oldPassword.tr(),
                    ),
                    const SizedBox(height: AppDimens.xm),
                    GreenpinTextField(
                      isPassword: true,
                      initText: data.newPassword,
                      onChanged: cubit.changeNewPassword,
                      errorText: data.error.newPasswordError?.translate,
                      labelText: LocaleKeys.newPassword.tr(),
                    ),
                    const SizedBox(height: AppDimens.xm),
                    GreenpinTextField(
                      isPassword: true,
                      initText: data.newPasswordRepeat,
                      onChanged: cubit.changeNewPasswordRepeat,
                      errorText: data.error.newPasswordRepeatError?.translate,
                      labelText: LocaleKeys.repeatPassword.tr(),
                    ),
                    const SizedBox(height: AppDimens.ml),
                    GreenpinPrimaryButton(
                      padding: EdgeInsets.zero,
                      text: LocaleKeys.save.tr(),
                      onPressed: data.areRequiredFieldsFilled
                          ? cubit.saveNewPassword
                          : null,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              const Image(
                fit: BoxFit.fitWidth,
                image: AssetImage('assets/img/vegtables_register_page.jpeg'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void _listener(
  EditUserPasswordCubit cubit,
  EditUserPasswordState current,
  BuildContext context,
) {
  current.maybeMap(
    orElse: () {},
    exitFlow: (_) {
      AutoRouter.of(context).pop();
    },
    error: (errorState) {
      SnackBarUtils.showErrorSnackBar(context, errorState.errorMessage);
    },
  );
}
