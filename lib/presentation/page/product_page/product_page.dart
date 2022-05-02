import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/categories_page/categories_page.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/product_manager_row/cubit/product_manager_cubit.dart';

class ProductPage extends HookWidget {
  const ProductPage({
    required this.product,
    this.productCategory,
    this.subcategory,
    Key? key,
  }) : super(key: key);

  final Product product;
  final ProductCategory? productCategory;
  final Subcategory? subcategory;

  @override
  Widget build(BuildContext context) {
    final productManagerCubit = useCubit<ProductManagerCubit>();

    useEffect(() {
      productManagerCubit.init([product]);
    }, [productManagerCubit]);

    return Scaffold(
      appBar: GreenpinAppbar.green(
        title: product.name,
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppDimens.l),
            child: Icon(
              Icons.store,
              size: AppDimens.iconButtonSize,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimens.s),
            _NavigationRow(
              product: product,
              productCategory: productCategory,
              subcategory: subcategory,
            ),
            const Divider(color: AppColors.gray),
            Padding(
              padding: const EdgeInsets.all(AppDimens.m),
              child: ProductRowContainerReserved(
                  product: product, productManagerCubit: productManagerCubit),
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.m),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.productDescription.tr(),
                    style: AppTypography.bodyText1Bold
                        .copyWith(color: AppColors.gray),
                  ),
                  const SizedBox(height: AppDimens.s),
                  Text(
                    product.description,
                    style: AppTypography.bodyText1,
                  ),
                  const SizedBox(height: AppDimens.l),

                  Text(
                    LocaleKeys.nutritions.tr(),
                    style: AppTypography.bodyText1Bold
                        .copyWith(color: AppColors.gray),
                  ),
                  const SizedBox(height: AppDimens.s),
                  Text(
                    '', //TODO when nutrition provided
                    style: AppTypography.bodyText1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationRow extends StatelessWidget {
  const _NavigationRow({
    required this.product,
    this.productCategory,
    this.subcategory,
    Key? key,
  }) : super(key: key);

  final Product product;
  final ProductCategory? productCategory;
  final Subcategory? subcategory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.m),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: AutoRouter.of(context)
            .stack
            .map(
              (e) => GreenpinPrimaryButton.outlined(
                padding: const EdgeInsets.only(left: AppDimens.m),
                insidePadding: const EdgeInsets.symmetric(
                  vertical: AppDimens.s,
                  horizontal: AppDimens.xm,
                ),
                text: mapPageNameToShortcut(
                  e.name,
                  productCategory?.name ?? '',
                  product.name,
                  subcategory?.category.name ?? '',
                ),
                isSelected: e.name == ProductPageRoute.name,
                onPressed: () =>
                    AutoRouter.of(context).popUntilRouteWithName(e.name ?? ''),
              ),
            )
            .toList(),
      ),
    );
  }
}
