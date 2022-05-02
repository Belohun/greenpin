import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/presentation/page/categories_page/categories_page.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/container/flexible_wrap.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/product_manager_row/cubit/product_manager_cubit.dart';

class CategoryPage extends HookWidget {
  const CategoryPage({
    required this.subcategory,
    required this.productCategory,
    Key? key,
  }) : super(key: key);

  final ProductCategory productCategory;
  final Subcategory subcategory;

  @override
  Widget build(BuildContext context) {
    final productsManagerCubit = useCubit<ProductManagerCubit>();
    useEffect(
      () {
        productsManagerCubit.init(subcategory.productResponseList);
      },
      [],
    );

    return Scaffold(
      appBar: GreenpinAppbar.green(
        title: subcategory.category.name,
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
          children: [
            const SizedBox(height: AppDimens.s),
            _NavigationRow(
              category: subcategory,
              parentCategoryName: productCategory.name,
            ),
            const Divider(color: AppColors.gray),
            const SizedBox(height: AppDimens.m),
            Text(
              subcategory.category.name,
              style:
                  AppTypography.bodyText1Bold.copyWith(color: AppColors.gray),
            ),
            const SizedBox(height: AppDimens.m),
            FlexibleWrap(
              childrenBuilder: (width) => subcategory.productResponseList
                  .map((product) => ProductContainer(
                        onRefresh: productsManagerCubit.updateProducts,
                        subcategory: subcategory,
                        productCategory: productCategory,
                        product: product,
                        containerSize: width - (AppDimens.l),
                        productManagerCubit: productsManagerCubit,
                      ))
                  .toList(),
              childrenRowCount: 2,
              spacing: AppDimens.l,
            ),
            SafeArea(child: Container()),
            //TODO add pagination
          ],
        ),
      ),
    );
  }
}

class _NavigationRow extends StatelessWidget {
  const _NavigationRow({
    required this.category,
    required this.parentCategoryName,
    Key? key,
  }) : super(key: key);

  final Subcategory category;
  final String parentCategoryName;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
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
                  parentCategoryName,
                  '',
                  category.category.name,
                ),
                isSelected: e == AutoRouter.of(context).stack.last,
                onPressed: () =>
                    AutoRouter.of(context).popUntilRouteWithName(e.name ?? ''),
              ),
            )
            .toList(),
      ),
    );
  }
}
