import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:greenpin/domain/category/model/subcategory.dart';
import 'package:greenpin/presentation/page/categories_page/categories_page.dart';
import 'package:greenpin/presentation/page/category_page/cubit/category_cubit.dart';
import 'package:greenpin/presentation/page/category_page/cubit/category_data.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/util/snackbar_util.dart';
import 'package:greenpin/presentation/widget/button/greenpin_primary_button.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/greenppin_appbar.dart';
import 'package:greenpin/presentation/widget/product_manager_row/cubit/product_manager_cubit.dart';
import 'package:greenpin/presentation/widget/scroll_view/greenpin_lazy_loader_scroll_view.dart';

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
    final cubit = useCubitWithParam<CategoryCubit>(
        CategoryData.fromSubcategory(subcategory: subcategory));

    final state = useCubitBuilder(cubit);

    final productsManagerCubit = useCubit<ProductManagerCubit>();

    useCubitListener(cubit, _listener);

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
      body: state.maybeMap(
        orElse: () => const SizedBox.shrink(),
        idle: (idleState) => _Body(
          cubit: cubit,
          data: idleState.data,
          productCategory: productCategory,
          productsManagerCubit: productsManagerCubit,
        ),
      ),
    );
  }

  void _listener(
      CategoryCubit cubit, CategoryState current, BuildContext context) {
    current.maybeMap(
      orElse: () {},
      error: (errorState) =>
          SnackBarUtils.showErrorSnackBar(context, errorState.errorMessage),
    );
  }
}

class _Body extends HookWidget {
  const _Body({
    required this.data,
    required this.productsManagerCubit,
    required this.productCategory,
    required this.cubit,
    Key? key,
  }) : super(key: key);

  final ProductCategory productCategory;
  final CategoryData data;
  final ProductManagerCubit productsManagerCubit;
  final CategoryCubit cubit;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      productsManagerCubit.init(data.productList);
    }, [data]);

    return LayoutBuilder(
      builder: (context, constraints) => GreenpinLazyLoaderScrollView(
        topWidget: _TopContent(data: data),
        mainItemBuilder: (
          BuildContext context,
          int index,
        ) {
          return _ProductsRow(
            productsManagerCubit: productsManagerCubit,
            data: data,
            productCategory: productCategory,
            index: index,
            constraints: constraints,
          );
        },
        itemCount: (data.productList.length / 2).ceilToDouble().toInt(),
        onPageEnd: cubit.fetchMoreProducts,
        shouldLoadMore: data.shouldFetch,
      ),
    );
  }
}

class _ProductsRow extends HookWidget {
  const _ProductsRow({
    required this.productsManagerCubit,
    required this.data,
    required this.productCategory,
    required this.constraints,
    required this.index,
    Key? key,
  }) : super(key: key);

  final ProductManagerCubit productsManagerCubit;
  final CategoryData data;
  final ProductCategory productCategory;
  final BoxConstraints constraints;
  final int index;

  @override
  Widget build(BuildContext context) {
    final width = useMemoized(
      () => (constraints.maxWidth - (AppDimens.l + AppDimens.m * 2)) / 2,
      [constraints],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.l),
      child: Row(
        children: [
          const SizedBox(width: AppDimens.m),
          ProductContainer(
            onRefresh: productsManagerCubit.updateProducts,
            subcategory: data.originalSubcategory,
            productCategory: productCategory,
            product: data.productList[2 * index],
            containerSize: width,
            productManagerCubit: productsManagerCubit,
          ),
          const SizedBox(width: AppDimens.l),
          if (2 * index + 1 >= data.productList.length)
            SizedBox(width: width)
          else
            ProductContainer(
              onRefresh: productsManagerCubit.updateProducts,
              subcategory: data.originalSubcategory,
              productCategory: productCategory,
              product: data.productList[2 * index + 1],
              containerSize: width,
              productManagerCubit: productsManagerCubit,
            ),
          const SizedBox(width: AppDimens.m),
        ],
      ),
    );
  }
}

class _TopContent extends StatelessWidget {
  const _TopContent({
    required this.data,
    Key? key,
  }) : super(key: key);

  final CategoryData data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppDimens.s),
        _NavigationRow(
          category: data.originalSubcategory,
          parentCategoryName: data.originalSubcategory.category.name,
        ),
        const Divider(color: AppColors.gray),
        const SizedBox(height: AppDimens.m),
        Text(
          data.originalSubcategory.category.name,
          style: AppTypography.bodyText1Bold.copyWith(color: AppColors.gray),
        ),
        const SizedBox(height: AppDimens.m),
        SafeArea(child: Container()),
      ],
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
