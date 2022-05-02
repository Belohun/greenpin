import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/presentation/page/cart_page/cubit/cart_cubit.dart';
import 'package:greenpin/presentation/page/cart_page/cubit/cart_data.dart';
import 'package:greenpin/presentation/page/categories_page/categories_page.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
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

    return state.maybeMap(
      orElse: () => const GreenpinLoader(),
      idle: (idleState) => _Body(
        data: idleState.data,
        cubit: cubit,
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
    }, [productManagerCubit]);

    return SingleChildScrollView(
      child: Column(
        children: data.products
            .map(
              (product) => Padding(
                padding: const EdgeInsets.all(AppDimens.m),
                child: ProductRowContainer(
                  product: product,
                  productManagerCubit: productManagerCubit,
                ),
              ),
            )
            .expand(
              (element) => [
                element,
                const Divider(color: AppColors.gray),
              ],
            )
            .toList(),
      ),
    );
  }
}
