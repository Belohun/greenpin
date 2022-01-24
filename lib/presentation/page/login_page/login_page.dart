import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/login_page/cubit/login_page_cubit.dart';
import 'package:greenpin/presentation/page/login_page/model/login_page_data.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/util/snackbar_util.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/text/info_widgets.dart';
import 'package:greenpin/presentation/widget/text_field/greenpin_text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: GreenpinAppbar.empty(),
        body: const _Body(),
      );
}

class _Body extends HookWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<LoginPageCubit>();
    final state = useCubitBuilder(cubit);

    useCubitListener(cubit, _listener);

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

  void _listener(
      LoginPageCubit cubit, LoginPageState current, BuildContext context) {
    current.maybeMap(
        orElse: () {},
        error: (errorState) {
          SnackBarUtils.showErrorSnackBar(context, errorState.errorMessage);
        },
        loginSuccessful: (_) {
          AutoRouter.of(context).replace(const HomePageRoute());
        });
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.data,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final LoginPageCubit cubit;
  final LoginPageData data;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
                child: Column(
                  children: [
                    GreenpinHeader(text: LocaleKeys.logIn.tr()),
                    const SizedBox(height: AppDimens.ml),
                    GreenpinTextField(
                      initText: data.email,
                      labelText: LocaleKeys.email.tr(),
                      onChanged: cubit.emailChange,
                      errorText: data.emailError,
                    ),
                    const SizedBox(height: AppDimens.xm),
                    GreenpinTextField(
                      initText: data.password,
                      isPassword: true,
                      labelText: LocaleKeys.password.tr(),
                      onChanged: cubit.passwordChange,
                      errorText: data.passwordError,
                    ),
                    const SizedBox(height: AppDimens.ml),
                    GreenpinPrimaryButton(
                      text: LocaleKeys.logIn.tr(),
                      padding: EdgeInsets.zero,
                      onPressed: data.isValid ? cubit.logIn : null,
                    ),
                    const SizedBox(height: AppDimens.xxl),
                    GreenpinSubHeader(text: LocaleKeys.canNotLogIn.tr()),
                    const SizedBox(
                      height: AppDimens.s,
                    ),
                    RichText(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor,
                      text: TextSpan(
                        style: AppTypography.bodyText1,
                        children: [
                          TextSpan(text: LocaleKeys.doesNotHaveAccount.tr()),
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => AutoRouter.of(context).navigate(
                                    const RegisterPageRoute(),
                                  ),
                            text: ' ${LocaleKeys.registerYourself.tr()} ',
                            style: AppTypography.bodyText1
                                .copyWith(color: AppColors.primary),
                          ),
                        ],
                      ),
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
