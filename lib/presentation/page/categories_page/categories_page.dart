import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/categories_page/cubit/categories_cubit.dart';
import 'package:greenpin/presentation/page/categories_page/cubit/categories_data.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/util/snackbar_util.dart';
import 'package:greenpin/presentation/widget/button/greenpin_icon_button.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/button/greenpin_text_button.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/image/greenpin_cached_image.dart';

class CategoriesPage extends HookWidget {
  const CategoriesPage({
    required this.category,
    Key? key,
  }) : super(key: key);

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<CategoriesCubit>();
    final state = useCubitBuilder(cubit);

    useCubitListener(cubit, _listener);

    useEffect(() {
      cubit.init(category.id);
    }, [cubit]);

    return Scaffold(
      appBar: GreenpinAppbar.green(
        title: category.name,
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
            _NavigationRow(category: category),
            const Divider(
              color: AppColors.gray,
            ),
            state.maybeMap(
              loading: (_) => const GreenpinLoader(),
              orElse: () => const SizedBox(),
              idle: (idleState) => _Body(
                cubit: cubit,
                data: idleState.data,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _listener(
      CategoriesCubit cubit, CategoriesState current, BuildContext context) {
    current.maybeMap(
        orElse: () {},
        error: (errorState) =>
            SnackBarUtils.showErrorSnackBar(context, errorState.errorMessage));
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.cubit,
    required this.data,
    Key? key,
  }) : super(key: key);

  final CategoriesCubit cubit;
  final CategoriesData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.subcategoryList
          .map((subcategory) => Column(
                children: [
                  _SubcategoryHeader(subcategory: subcategory),
                  _SubcategoryContent(subcategory: subcategory),
                ],
              ))
          .toList(),
    );
  }
}

class _SubcategoryContent extends StatelessWidget {
  const _SubcategoryContent({
    required this.subcategory,
    Key? key,
  }) : super(key: key);

  final Subcategory subcategory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: AppDimens.m),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: subcategory.productResponseList
            .map(
              (product) => SizedBox(
                width: AppDimens.productContainerSize,
                child: ProductContainer(product: product),
              ),
            )
            .expand(
              (element) => [
                element,
                const SizedBox(width: AppDimens.xl),
              ],
            )
            .toList(),
      ),
    );
  }
}

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    required this.product,
    Key? key,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GreenpinCachedImage(
          url: product.imageUrl,
          width: AppDimens.bigImage,
          height: AppDimens.bigImage,
        ),
        const SizedBox(height: AppDimens.s),
        Text(
          product.price.formattedPriceString(),
          style: AppTypography.bodyText1Bold.copyWith(color: AppColors.gray),
        ),
        const SizedBox(height: AppDimens.s),
        Text(
          product.name,
          style: AppTypography.smallText1,
        ),
        const SizedBox(height: AppDimens.s),
        Text(
          product.manufacturerName,
          style: AppTypography.smallText1,
        ),
        const SizedBox(height: AppDimens.s),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GreenpinIconButton(
              background: AppColors.white,
              iconColor: AppColors.lightGreen,
              onPressed: () {},
              shape: BoxShape.circle,
              iconData: Icons.remove,
            ),
            Text(
              '1', //TODO
              style:
                  AppTypography.bodyText1Bold.copyWith(color: AppColors.gray),
            ),
            GreenpinIconButton(
              background: AppColors.white,
              onPressed: () {},
              iconColor: AppColors.lightGreen,
              iconData: Icons.add,
              shape: BoxShape.circle,
            ),
          ],
        ),
      ],
    );
  }
}

class _SubcategoryHeader extends StatelessWidget {
  const _SubcategoryHeader({
    required this.subcategory,
    Key? key,
  }) : super(key: key);
  final Subcategory subcategory;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppDimens.m),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              subcategory.category.name,
              overflow: TextOverflow.ellipsis,
              style:
                  AppTypography.bodyText1Bold.copyWith(color: AppColors.gray),
            ),
          ),
          GreenpinTextButton(
            text: LocaleKeys.all
                .tr(args: [subcategory.productListSize.toString()]),
            onPressed: () {}, //TODO
            style:
                AppTypography.bodyText1.copyWith(color: AppColors.lightGreen),
          ),
        ],
      ),
    );
  }
}

class _NavigationRow extends StatelessWidget {
  const _NavigationRow({
    required this.category,
    Key? key,
  }) : super(key: key);

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: AutoRouter.of(context)
          .stack
          .map(
            (e) => GreenpinPrimaryButton.outlined(
              padding: const EdgeInsets.only(left: AppDimens.m),
              insidePadding: const EdgeInsets.symmetric(
                vertical: AppDimens.s,
                horizontal: AppDimens.xm,
              ),
              text: mapPageNameToShortcut(e.name, category.name, ''),
              isSelected: e.name == CategoriesPageRoute.name,
              onPressed: () =>
                  AutoRouter.of(context).popUntilRouteWithName(e.name ?? ''),
            ),
          )
          .toList(),
    );
  }
}

String mapPageNameToShortcut(
  String? pageName,
  String category,
  String product,
) {
  switch (pageName) {
    case HomePageRoute.name:
      return LocaleKeys.shopping.tr();
    case CategoriesPageRoute.name:
      return category;
    default:
      return product;
  }
}
