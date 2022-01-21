import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/register_page/cubit/register_page_cubit.dart';
import 'package:greenpin/presentation/page/register_page/model/register_page_data.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/button/greenpin_checkbox.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/text/info_widgets.dart';
import 'package:greenpin/presentation/widget/text_field/greenpin_text_field.dart';

class RegisterPageFirstStep extends HookWidget {
  const RegisterPageFirstStep({
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
        cubit: cubit,
        data: stateIdle.data,
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.cubit,
    required this.data,
    Key? key,
  }) : super(key: key);

  final RegisterPageCubit cubit;
  final RegisterPageData data;

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
                    GreenpinHeader(text: LocaleKeys.firstTime.tr()),
                    const SizedBox(height: AppDimens.s),
                    GreenpinSubHeader(
                        text: LocaleKeys.createAccountAndStartBuying.tr()),
                    const SizedBox(height: AppDimens.ml),
                    GreenpinTextField(
                      initText: data.firstStepData.email,
                      labelText: LocaleKeys.email.tr(),
                      onChanged: cubit.emailChange,
                      errorText: data.firstStepData.emailError,
                    ),
                    const SizedBox(height: AppDimens.xm),
                    GreenpinTextField(
                      initText: data.firstStepData.password,
                      isPassword: true,
                      labelText: LocaleKeys.password.tr(),
                      onChanged: cubit.passwordChange,
                      errorText: data.firstStepData.passwordError,
                    ),
                    const SizedBox(height: AppDimens.xm),
                    GreenpinTextField(
                      initText: data.firstStepData.repeatPassword,
                      isPassword: true,
                      labelText: LocaleKeys.repeatPassword.tr(),
                      onChanged: cubit.repeatPasswordChange,
                      errorText:
                          data.firstStepData.repeatPasswordError,
                    ),
                    const SizedBox(height: AppDimens.xl),
                    _CheckBoxRow(
                      data: data,
                      cubit: cubit,
                    ),
                    const SizedBox(height: AppDimens.xxl),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: AppDimens.l),
                child: _NextButton(
                  data: data,
                  cubit: cubit,
                ),
              ),
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

class _NextButton extends StatelessWidget {
  const _NextButton({
    required this.data,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final RegisterPageData data;
  final RegisterPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            child: GreenpinPrimaryButton(
              onPressed: data.isValid ? cubit.nextPage : null,
              text: LocaleKeys.cont.tr(),
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheckBoxRow extends StatelessWidget {
  const _CheckBoxRow({
    required this.data,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final RegisterPageData data;
  final RegisterPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GreenpinCheckbox(
          value: data.firstStepData.siteAgreementAccepted,
          onPressed: cubit.changeSiteAgreement,
        ),
        const SizedBox(width: AppDimens.m),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: AppTypography.bodyText1,
              children: [
                TextSpan(text: LocaleKeys.iReadAndAccept.tr()),
                TextSpan(
                  text: ' ${LocaleKeys.terms.tr()} ',
                  style: AppTypography.bodyText1
                      .copyWith(color: AppColors.primary),
                ),
                TextSpan(text: LocaleKeys.and.tr()),
                TextSpan(
                  text: ' ${LocaleKeys.privacyPolicy.tr()} ',
                  style: AppTypography.bodyText1
                      .copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
