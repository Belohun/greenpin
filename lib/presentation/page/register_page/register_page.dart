import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/register_page/cubit/register_page_cubit.dart';
import 'package:greenpin/presentation/page/register_page/model/register_page_data.dart';
import 'package:greenpin/presentation/page/register_page/model/register_page_enum.dart';
import 'package:greenpin/presentation/page/register_page/step/register_page_first_step.dart';
import 'package:greenpin/presentation/page/register_page/step/register_page_second_step.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/util/snackbar_util.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';

class RegisterPage extends HookWidget {
  const RegisterPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubitWithParam<RegisterPageCubit>(
        RegisterPageData.initData(RegisterPageEnum.firstStep));
    final state = useCubitBuilder(cubit);
    final pageController = usePageController(initialPage: 0);

    useCubitListenerWithPageController(
      cubit,
      _listener,
      pageController,
    );

    return state.maybeMap(
      orElse: () => const SizedBox.shrink(),
      idle: (idleState) => GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: GreenpinAppbar(
            background: AppColors.white,
            onLeadPressed: cubit.previousPage,
          ),
          body: _Content(
            data: idleState.data,
            pageController: pageController,
            cubit: cubit,
          ),
        ),
      ),
    );
  }

  void _listener(
    RegisterPageCubit cubit,
    RegisterPageState current,
    BuildContext context,
    PageController pageController,
  ) {
    current.maybeMap(
      orElse: () {},
      idle: (state) {
        if (pageController.page?.toInt() != state.data.currentIndex) {
          pageController.animateToPage(
            state.data.currentIndex,
            duration: const Duration(
                milliseconds: AppDimens.checkBoxDurationInMilliseconds),
            curve: Curves.easeIn,
          );
        }
      },
      exitFlow: (_) {
        AutoRouter.of(context).pop();
      },
      successfulRegister: (_) {
        SnackBarUtils.showPositiveMessageSnackbar(
            context, LocaleKeys.registrationSuccessful.tr());
        AutoRouter.of(context).popUntilRoot();
      },
      error: (error) {
        SnackBarUtils.showErrorSnackBarText(context, error.errorMessage);
      },
    );
  }
}

class _Content extends HookWidget {
  const _Content({
    required this.data,
    required this.pageController,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final RegisterPageData data;
  final PageController pageController;
  final RegisterPageCubit cubit;

  @override
  Widget build(BuildContext context) {
    final pages = useMemoized(
      () => data.pages.map(
        (page) => _getPage(
          page,
          cubit,
        ),
      ),
    ).toList();

    return GreenpinLoadingContainer(
      isLoading: data.isLoading,
      child: PageView(
        controller: pageController,
        pageSnapping: false,
        physics: const NeverScrollableScrollPhysics(),
        children: pages,
      ),
    );
  }
}

Widget _getPage(
  RegisterPageEnum page,
  RegisterPageCubit cubit,
) {
  switch (page) {
    case RegisterPageEnum.firstStep:
      return RegisterPageFirstStep(cubit: cubit);
    case RegisterPageEnum.secondStep:
      return RegisterPageSecondStep(cubit: cubit);
  }
}
