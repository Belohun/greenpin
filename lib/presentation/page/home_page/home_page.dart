import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/home_page/cubit/home_page_cubit.dart';
import 'package:greenpin/presentation/widget/button/greenpin_text_button.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/logout/logout_widget.dart';

class HomePage extends HookWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LogoutWidget(child: _Body()),
    );
  }
}

class _Body extends HookWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<HomePageCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(() {
      cubit.init();
      return;
    }, [cubit]);

    return Center(
      child: state.maybeMap(
        orElse: () => const Text('error'),
        idle: (_) => GreenpinTextButton(
          text: LocaleKeys.logOut.tr(),
          onPressed: cubit.logout,
        ),
      ),
    );
  }
}
