import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/home_page/cubit/home_page_cubit.dart';
import 'package:greenpin/presentation/page/home_page/model/home_tab_enum.dart';
import 'package:greenpin/presentation/page/home_page/widget/product_quantity_indicator/product_quantity_indicator_widget.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/container/greenpin_card.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
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
    useEffect(() {
      cubit.init(HomeTabEnum.shopping);
      return;
    }, [cubit]);

    return state.maybeMap(
      orElse: () => const Text('error'),
      idle: (idleState) => AutoTabsRouter(
        routes: const [
          ShoppingTabGroupRouter(),
          OrdersPageRoute(),
          CartTabGroupRouter(),
          ProfileTabGroupRouter(),
        ],
        builder: (context, child, animation) {
          final tabsRouter = AutoTabsRouter.of(context);

          return Column(
            children: [
              Expanded(
                child: FadeTransition(
                  opacity: animation,
                  child: child,
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
                              tabsRouter: tabsRouter,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _BottomBarButton extends HookWidget {
  const _BottomBarButton({
    required this.cubit,
    required this.currentTab,
    required this.tab,
    required this.tabsRouter,
    Key? key,
  }) : super(key: key);

  final HomePageCubit cubit;
  final HomeTabEnum tab;
  final HomeTabEnum currentTab;
  final TabsRouter tabsRouter;

  @override
  Widget build(BuildContext context) {
    final bool isCurrent = useMemoized(() => tab == currentTab, [currentTab]);

    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        cubit.changeTab(tab);
        tabsRouter.setActiveIndex(tab.index);
      },
      child: Column(
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.s,
                  right: AppDimens.s,
                ),
                child: Icon(
                  tab.icon,
                  size: AppDimens.iconButtonSize,
                  color: isCurrent ? AppColors.primary : AppColors.gray,
                ),
              ),
              if (tab == HomeTabEnum.cart)
                const Positioned(
                    top: 0, right: 0, child: ProductQuantityIndicatorWidget()),
            ],
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
