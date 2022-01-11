import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/entry_page/cubit/entry_page_cubit.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/button/greenpin_text_button.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';

class EntryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Scaffold(
        body: _Body(),
      );
}

class _Body extends HookWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<EntryPageCubit>();
    final state = useCubitBuilder(cubit);

    useCubitListener(
      cubit,
      _listener,
    );

    useEffect(
      () {
        cubit.init();
      },
      [cubit],
    );

    return Container(
      width: double.infinity,
      child: state.maybeMap(
        orElse: () => const SizedBox.shrink(),
        userNotLoggedIn: (_) => const _NotLoggedUserButtons(),
      ),
    );
  }
}

void _listener(
  EntryPageCubit cubit,
  EntryPageState current,
  BuildContext context,
) {
  current.maybeMap(
      orElse: () {},
      userLoggedIn: (_) =>
          AutoRouter.of(context).replace(const HomePageRoute()));
}

class _NotLoggedUserButtons extends StatelessWidget {
  const _NotLoggedUserButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GreenpinPrimaryButton(
            onPressed: () =>
                AutoRouter.of(context).navigate(const LoginPageRoute()),
            text: LocaleKeys.logIn.tr(),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppDimens.l),
              //TODO change when dimens provided
              child: GreenpinTextButton(
                onPressed: () =>
                    AutoRouter.of(context).navigate(const RegisterPageRoute()),
                text: LocaleKeys.register.tr(),
              ),
            ),
          ),
        ],
      );
}
