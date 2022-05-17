import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/domain/product/model/product.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/button/greenpin_icon_button.dart';
import 'package:greenpin/presentation/widget/container/greenpin_loading_container.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';
import 'package:greenpin/presentation/widget/product_manager_row/cubit/product_manager_cubit.dart';

class ProductManagerRow extends HookWidget {
  const ProductManagerRow({
    required this.cubit,
    required this.product,
    Key? key,
  }) : super(key: key);

  final ProductManagerCubit cubit;
  final Product product;

  @override
  Widget build(BuildContext context) {
    final state = useCubitBuilder(cubit);
    final _product = useMemoized(
      () => state.maybeMap(
        orElse: () => product,
        idle: (idleState) => idleState.data.products
            .firstWhereOrNull((element) => element.id == product.id),
      ),
      [state],
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GreenpinIconButton(
          size: AppDimens.biggerButtonSize,
          background: AppColors.white,
          iconColor: AppColors.lightGreen,
          onPressed: (_product?.quantity ?? 0) == 0
              ? null
              : () => cubit.decreaseQuantity(_product!),
          shape: BoxShape.circle,
          iconData: Icons.remove,
        ),
        state.maybeMap(
          orElse: () => const SizedBox(),
          idle: (idleState) => Text(
            _product?.quantity.toString() ?? '0',
            style: AppTypography.bodyText1Bold.copyWith(color: AppColors.gray),
          ),
          loading: (_) => const GreenpinLoader(),
        ),
        GreenpinIconButton(
          size: AppDimens.biggerButtonSize,
          background: AppColors.lightGreen,
          onPressed:
              _product != null ? () => cubit.increaseQuantity(_product) : null,
          iconColor: AppColors.white,
          iconData: Icons.add,
          shape: BoxShape.circle,
        ),
      ],
    );
  }
}
