import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/cart_page/cubit/cart_cubit.dart';
import 'package:greenpin/presentation/page/cart_page/cubit/cart_data.dart';
import 'package:greenpin/presentation/page/categories_page/categories_page.dart';
import 'package:greenpin/presentation/page/home_page/model/home_tab_enum.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/button/greenpin_text_button.dart';
import 'package:greenpin/presentation/widget/container/greenpin_card.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/product_manager_row/cubit/product_manager_cubit.dart';

class CartPage extends HookWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<CartCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(() {
      cubit.init();
    }, [cubit]);

    return Scaffold(
      appBar: GreenpinAppbar.green(
        leading: const SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimens.l),
            child: Icon(
              HomeTabEnum.cart.icon,
              size: AppDimens.iconButtonSize,
            ),
          ),
        ],
        title: HomeTabEnum.cart.name,
      ),
      body: state.maybeMap(
        orElse: () => const GreenpinLoader(),
        idle: (idleState) => _Body(
          data: idleState.data,
          cubit: cubit,
        ),
      ),
    );
  }
}

class _Body extends HookWidget {
  const _Body({
    required this.data,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final CartData data;
  final CartCubit cubit;

  @override
  Widget build(BuildContext context) {
    final productManagerCubit = useCubit<ProductManagerCubit>();

    useEffect(() {
      productManagerCubit.init(data.products);
    }, [data.products.length]);

    return Column(
      children: [
        GreenpinCard(
          padding: const EdgeInsets.all(AppDimens.ml),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: RichText(
                  textScaleFactor: MediaQuery.of(context).textScaleFactor,
                  text: TextSpan(
                    style: AppTypography.bodyText1Bold
                        .copyWith(color: AppColors.gray),
                    children: [
                      TextSpan(text: LocaleKeys.cart.tr()),
                      TextSpan(
                        text:
                            ' (${data.productsPriceSum.formattedPriceString()})',
                        style: AppTypography.bodyText1Bold
                            .copyWith(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: GreenpinTextButton(
                  text: LocaleKeys.clear.tr(),
                  style: AppTypography.bodyText1Bold
                      .copyWith(color: AppColors.gray),
                  onPressed: cubit.clearCart,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: data.products.length,
            itemBuilder: (BuildContext context, int index) => AnimatedContainer(
              duration:
                  const Duration(seconds: AppDimens.animDurationInSeconds),
              child: Column(
                children: [
                  CupertinoButton(
                    padding: const EdgeInsets.all(AppDimens.m),
                    onPressed: () => AutoRouter.of(context)
                        .push(ProductPageRoute(product: data.products[index])),
                    child: ProductRowContainer(
                      product: data.products[index],
                      productManagerCubit: productManagerCubit,
                    ),
                  ),
                  const Divider(color: AppColors.gray),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
