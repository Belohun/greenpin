import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/presentation/page/home_page/widget/product_quantity_indicator/cubit/product_quantity_indicator_cubit.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/cubit_hooks.dart';

class ProductQuantityIndicatorWidget extends HookWidget {
  const ProductQuantityIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit<ProductQuantityIndicatorCubit>();
    final state = useCubitBuilder(cubit);

    useEffect(
      () {
        cubit.init();
      },
      [cubit],
    );

    return state.maybeMap(
      orElse: () => const SizedBox.shrink(),
      idle: (idleState) {
        return AnimatedContainer(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          duration: const Duration(seconds: AppDimens.animDurationInSeconds),
          child: Padding(
            padding: const EdgeInsets.all(AppDimens.xs),
            child: Text(
              idleState.productQuantity.toString(),
              textAlign: TextAlign.center,
              style: AppTypography.smallText1.copyWith(
                color: AppColors.white,
                fontSize: AppDimens.xm,
                height: 1,
              ),
            ),
          ),
        );
      },
    );
  }
}
