import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/button/greenpin_text_button.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/image/greenpin_cached_image.dart';
import 'package:greenpin/presentation/widget/product_manager_row/cubit/product_manager_cubit.dart';
import 'package:greenpin/presentation/widget/product_manager_row/product_manager_row.dart';

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
              idle: (idleState) =>
                  _Body(
                    cubit: cubit,
                    data: idleState.data,
                    productCategory: category,
                  ),
            ),
            SafeArea(child: Container()),
          ],
        ),
      ),
    );
  }

  void _listener(CategoriesCubit cubit, CategoriesState current,
      BuildContext context) {
    current.maybeMap(
        orElse: () {},
        error: (errorState) =>
            SnackBarUtils.showErrorSnackBar(context, errorState.errorMessage));
  }
}

class _Body extends HookWidget {
  const _Body({
    required this.cubit,
    required this.data,
    required this.productCategory,
    Key? key,
  }) : super(key: key);

  final CategoriesCubit cubit;
  final CategoriesData data;
  final ProductCategory productCategory;

  @override
  Widget build(BuildContext context) {
    final productManagerCubit = useCubit<ProductManagerCubit>();

    useEffect(() {
      productManagerCubit.init(data.allProducts);
    }, [productManagerCubit]);

    return Column(
      children: data.subcategoryList
          .map((subcategory) =>
          Column(
            children: [
              _SubcategoryHeader(
                subcategory: subcategory,
                productCategory: productCategory,
                productManagerCubit: productManagerCubit,
                data: data,
              ),
              _SubcategoryContent(
                productCategory: productCategory,
                subcategory: subcategory,
                productManagerCubit: productManagerCubit,
              ),
            ],
          ))
          .toList(),
    );
  }
}

class _SubcategoryContent extends StatelessWidget {
  const _SubcategoryContent({
    required this.subcategory,
    required this.productManagerCubit,
    required this.productCategory,
    Key? key,
  }) : super(key: key);

  final Subcategory subcategory;
  final ProductManagerCubit productManagerCubit;
  final ProductCategory productCategory;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: AppDimens.l),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: subcategory.productResponseList
                .map(
                  (product) =>
                  ProductContainer(
                    onRefresh:  productManagerCubit.updateProducts,
                    subcategory: subcategory,
                    productCategory: productCategory,
                    productManagerCubit: productManagerCubit,
                    product: product,
                    containerSize: (constraints.maxWidth / 2) -
                        (AppDimens.l + AppDimens.m),

                  ),
            )
                .expand(
                  (element) =>
              [
                element,
                const SizedBox(width: AppDimens.l),
              ],
            )
                .toList(),
          ),
        );
      },
    );
  }
}

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    required this.product,
    required this.containerSize,
    required this.productManagerCubit,
    required this.onRefresh,
    this.subcategory,
    this.productCategory,
    Key? key,
  }) : super(key: key);

  final Product product;
  final double containerSize;
  final ProductManagerCubit productManagerCubit;
  final ProductCategory? productCategory;
  final Subcategory? subcategory;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containerSize,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {
              await AutoRouter.of(context).push(
                  ProductPageRoute(
                    product: product,
                    productCategory: productCategory,
                    subcategory: subcategory,
                  ),
                );
              onRefresh();

            },
            child: GreenpinCachedImage(
              url: product.imageUrl,
              width: containerSize,
              height: containerSize,
            ),
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
          ProductManagerRow(
            product: product,
            cubit: productManagerCubit,
          ),
        ],
      ),
    );
  }
}

class ProductRowContainer extends StatelessWidget {
  const ProductRowContainer({
    required this.product,
    required this.productManagerCubit,
    this.subcategory,
    this.productCategory,
    Key? key,
  }) : super(key: key);

  final Product product;
  final ProductManagerCubit productManagerCubit;
  final ProductCategory? productCategory;
  final Subcategory? subcategory;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProductImage(
                product: product,
                productCategory: productCategory,
                subcategory: subcategory,
                constraints: constraints,
              ),
              const SizedBox(width: AppDimens.m),
              _ProductColumnManager(
                  product: product, productManagerCubit: productManagerCubit)
            ],
          ),
    );
  }
}

class ProductRowContainerReserved extends StatelessWidget {
  const ProductRowContainerReserved({
    required this.product,
    required this.productManagerCubit,
    this.subcategory,
    this.productCategory,
    Key? key,
  }) : super(key: key);

  final Product product;
  final ProductManagerCubit productManagerCubit;
  final ProductCategory? productCategory;
  final Subcategory? subcategory;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProductColumnManager(
                  product: product, productManagerCubit: productManagerCubit),
              const SizedBox(width: AppDimens.m),
              _ProductImage(
                product: product,
                productCategory: productCategory,
                subcategory: subcategory,
                constraints: constraints,
              ),
            ],
          ),
    );
  }
}


class _ProductImage extends StatelessWidget {
  const _ProductImage({
    required this.product,
    required this.productCategory,
    required this.subcategory,
    required this.constraints,
    Key? key,
  }) : super(key: key);

  final Product product;
  final ProductCategory? productCategory;
  final Subcategory? subcategory;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return GreenpinCachedImage(
      url: product.imageUrl,
      width: (constraints.maxWidth - AppDimens.m) / 2,
      height: (constraints.maxWidth - AppDimens.m) / 2,
    );
  }
}

class _ProductColumnManager extends StatelessWidget {
  const _ProductColumnManager({
    required this.product,
    required this.productManagerCubit,
    Key? key,
  }) : super(key: key);

  final Product product;
  final ProductManagerCubit productManagerCubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              product.price.formattedPriceString(),
              style: AppTypography.bodyText1Bold.copyWith(color: AppColors.gray),
            ),
            const SizedBox(height: AppDimens.s),
            Text(
              product.name,
              style: AppTypography.smallText1,
            ),
            const Spacer(),
            ProductManagerRow(
              product: product,
              cubit: productManagerCubit,
            ),
          ],
        ),
      ),
    );
  }
}

class _SubcategoryHeader extends StatelessWidget {
  const _SubcategoryHeader({
    required this.subcategory,
    required this.productCategory,
    required this.productManagerCubit,
    required this.data,
    Key? key,
  }) : super(key: key);

  final Subcategory subcategory;
  final ProductCategory productCategory;
  final ProductManagerCubit productManagerCubit;
  final CategoriesData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimens.m)
          .copyWith(bottom: AppDimens.m, top: AppDimens.l),
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
            onPressed: () async {
              await AutoRouter.of(context).push(
                CategoryPageRoute(
                  subcategory: subcategory,
                  productCategory: productCategory,
                ),
              );
              await productManagerCubit.init(data.allProducts);
            },
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
      children: AutoRouter
          .of(context)
          .stack
          .map(
            (e) =>
            GreenpinPrimaryButton.outlined(
              padding: const EdgeInsets.only(left: AppDimens.m),
              insidePadding: const EdgeInsets.symmetric(
                vertical: AppDimens.s,
                horizontal: AppDimens.xm,
              ),
              text: mapPageNameToShortcut(e.name, category.name, '', ''),
              isSelected: e.name == CategoriesPageRoute.name,
              onPressed: () =>
                  AutoRouter.of(context).popUntilRouteWithName(e.name ?? ''),
            ),
      )
          .toList(),
    );
  }
}

String mapPageNameToShortcut(String? pageName,
    String category,
    String product,
    String subCategory,) {
  switch (pageName) {
    case HomePageRoute.name:
      return LocaleKeys.shopping.tr();
    case CategoriesPageRoute.name:
      return category;
    case CategoryPageRoute.name:
      return subCategory;
    default:
      return product;
  }
}
