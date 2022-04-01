import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/domain/category/model/product_category.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/page/shoping_page/cubit/shopping_cubit.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/util/snackbar_util.dart';
import 'package:greenpin/presentation/widget/container/flexible_wrap.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/image/greenpin_cached_image.dart';

class ShoppingPage extends HookWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<ShoppingCubit>();
    final state = useCubitBuilder(cubit);

    useCubitListener(cubit, _listener);

    useEffect(() {
      cubit.init();
    }, [cubit]);

    return state.maybeMap(
      orElse: () => const SizedBox.shrink(),
      loading: (_) => const GreenpinLoader(),
      idle: (idleState) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.m),
          child: FlexibleWrap(
            childrenRowCount: 2,
            spacing: AppDimens.m,
            childrenBuilder: (width) => idleState.data.productCategories
                .map(
                  (productCategory) => CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => AutoRouter.of(context).navigate(
                      CategoriesPageRoute(category: productCategory)
                    ),
                    child: _ProductCategoryWidget(
                      productCategory: productCategory,
                      width: width,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  void _listener(
      ShoppingCubit cubit, ShoppingState current, BuildContext context) {
    current.maybeMap(
      orElse: () {},
      error: (errorState) {
        SnackBarUtils.showErrorSnackBar(
          context,
          errorState.errorMessage,
        );
      },
    );
  }
}

class _ProductCategoryWidget extends StatelessWidget {
  const _ProductCategoryWidget({
    required this.productCategory,
    required this.width,
    Key? key,
  }) : super(key: key);

  final ProductCategory productCategory;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GreenpinCachedImage(
          width: width,
          height: width,
          url: productCategory.url,
        ),
        const SizedBox(height: AppDimens.s),
        Text(
          productCategory.name,
          style: AppTypography.bodyText1,
        ),
      ],
    );
  }
}
