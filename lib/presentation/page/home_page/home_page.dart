import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/presentation/page/home_page/cubit/home_page_cubit.dart';
import 'package:greenpin/presentation/page/home_page/model/home_tab_enum.dart';
import 'package:greenpin/presentation/page/profile_page/profile_page.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/container/greenpin_card.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/logout/logout_widget.dart';

class HomePage extends HookWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<HomePageCubit>();
    final state = useCubitBuilder(cubit);

    return Scaffold(
      appBar: GreenpinAppbar.green(
        leading: const SizedBox.shrink(),
        actions: [
          state.maybeMap(
            orElse: () => const SizedBox.shrink(),
            idle: (idleState) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
              child: Icon(
                idleState.currentTab.icon,
                size: AppDimens.iconButtonSize,
              ),
            ),
          ),
        ],
        title: state.maybeMap(
          orElse: () => '',
          idle: (idleState) => idleState.currentTab.name,
        ),
      ),
      body: LogoutWidget(
        child: _Body(
          cubit: cubit,
          state: state,
        ),
      ),
    );
  }
}

class _Body extends HookWidget {
  const _Body({
    required this.cubit,
    required this.state,
    Key? key,
  }) : super(key: key);

  final HomePageCubit cubit;
  final HomePageState state;

  @override
  Widget build(BuildContext context) {
    final tabController =
        useTabController(initialLength: HomeTabEnum.values.length);
    useEffect(() {
      cubit.init(HomeTabEnum.shopping);
      return;
    }, [cubit]);

    useCubitListener(
      cubit,
      (
        HomePageCubit cubit,
        HomePageState state,
        BuildContext context,
      ) =>
          _listener(
        cubit,
        state,
        context,
        tabController,
      ),
    );

    return state.maybeMap(
      orElse: () => const Text('error'),
      idle: (idleState) => Column(
        children: [
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children:
                  HomeTabEnum.values.map((tab) => _Tab(tab: tab)).toList(),
            ),
          ),
          GreenpinCard(
            borderRadius: BorderRadius.zero,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppDimens.ss),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: HomeTabEnum.values
                      .map(
                        (tab) => _BottomBarButton(
                          cubit: cubit,
                          tab: tab,
                          currentTab: idleState.currentTab,
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _listener(
    HomePageCubit cubit,
    HomePageState current,
    BuildContext context,
    TabController controller,
  ) {
    current.maybeMap(
      orElse: () {},
      idle: (idleState) {
        if (controller.index != idleState.currentTab.index) {
          controller.animateTo(idleState.currentTab.index);
        }
      },
    );
  }
}

class _Tab extends StatelessWidget {
  const _Tab({
    required this.tab,
    Key? key,
  }) : super(key: key);

  final HomeTabEnum tab;

  @override
  Widget build(BuildContext context) {
    switch (tab) {
      case HomeTabEnum.shopping:
        return const Text('shopping');

      case HomeTabEnum.orders:
        return const Text('orders');

      case HomeTabEnum.cart:
        return const Text('cart');
      case HomeTabEnum.profile:
        return const ProfilePage();
    }
  }
}

class _BottomBarButton extends HookWidget {
  const _BottomBarButton({
    required this.cubit,
    required this.currentTab,
    required this.tab,
    Key? key,
  }) : super(key: key);

  final HomePageCubit cubit;
  final HomeTabEnum tab;
  final HomeTabEnum currentTab;

  @override
  Widget build(BuildContext context) {
    final bool isCurrent = useMemoized(() => tab == currentTab, [currentTab]);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () => cubit.changeTab(tab),
      child: Column(
        children: [
          Icon(
            tab.icon,
            size: AppDimens.iconButtonSize,
            color: isCurrent ? AppColors.primary : AppColors.gray,
          ),
          Text(
            tab.name,
            style: AppTypography.smallText1.copyWith(
              color: isCurrent ? AppColors.primary : AppColors.gray,
            ),
          ),
        ],
      ),
    );
  }
}
