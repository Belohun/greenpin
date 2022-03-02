import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/edit_user_email/cubit/edit_user_email_cubit.dart';
import 'package:greenpin/presentation/page/edit_user_email/cubit/edit_user_email_data.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/util/snackbar_util.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/text/info_widgets.dart';
import 'package:greenpin/presentation/widget/text_field/greenpin_text_field.dart';

class EditUserEmailPage extends HookWidget {
  const EditUserEmailPage({
    required this.userEmail,
    Key? key,
  }) : super(key: key);

  final String userEmail;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubitWithParam<EditUserEmailCubit>(
      EditEmailUserData(
        email: userEmail,
        isLoading: false,
      ),
    );

    final state = useCubitBuilder(cubit);

    useCubitListener(cubit, _listener);

    return Scaffold(
      appBar: GreenpinAppbar.green(),
      body: _Body(
        state: state,
        cubit: cubit,
      ),
    );
  }
}

void _listener(
  EditUserEmailCubit cubit,
  EditUserEmailState current,
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

class _Body extends StatelessWidget {
  const _Body({
    required this.cubit,
    required this.state,
    Key? key,
  }) : super(key: key);

  final EditUserEmailCubit cubit;
  final EditUserEmailState state;

  @override
  Widget build(BuildContext context) {
    return state.maybeMap(
      orElse: () => const SizedBox.shrink(),
      idle: (idleState) => GreenpinLoadingContainer(
        isLoading: idleState.data.isLoading,
        child: _Content(
          cubit: cubit,
          data: idleState.data,
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.cubit,
    required this.data,
    Key? key,
  }) : super(key: key);

  final EditUserEmailCubit cubit;
  final EditEmailUserData data;

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
                    GreenpinHeader(text: LocaleKeys.editEmail.tr()),
                    const SizedBox(height: AppDimens.l),
                    Text(
                      LocaleKeys.typeYourCurrentEmail.tr(),
                      style: AppTypography.bodyText1,
                    ),
                    const SizedBox(height: AppDimens.l),
                    GreenpinTextField(
                      initText: data.email,
                      onChanged: cubit.changeEmail,
                      errorText: data.emailError,
                      labelText: LocaleKeys.email.tr(),
                    ),
                    const SizedBox(height: AppDimens.ml),
                    GreenpinPrimaryButton(
                      padding: EdgeInsets.zero,
                      text: LocaleKeys.save.tr(),
                      onPressed: cubit.saveEmail,
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
