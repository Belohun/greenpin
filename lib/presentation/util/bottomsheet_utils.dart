import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';

class BottomSheetUtil {
  static Future<T?> showMyModalBottomSheet<T>({
    required BuildContext context,
    required Widget content,
    required String title,
    double? percentageOfScreenSize,
    Color? background,
    bool isDissmisible = true,
  }) async {
    final cost = await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: isDissmisible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.ss),
      ),
      context: context,
      builder: (context) {
        final modalBottomsheetHeight =
            MediaQuery.of(context).size.height * (percentageOfScreenSize ?? AppDimens.bottomsheetsHeight);
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: modalBottomsheetHeight,
            child: Column(
              children: [
                _Header(title: title),
                content,
              ],
            ),
          ),
        );
      },
    );
    return cost as T?;
  }

  static Future<T?> showMyModalFlexibleBottomSheet<T>({
    required BuildContext context,
    required Widget content,
    required String title,
    Color? background,
    bool isDissmisible = true,
  }) async {
    final cost = await showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: isDissmisible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.ss),
      ),
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Wrap(
            children: [
              _Header(title: title),
              content,
            ],
          ),
        );
      },
    );
    return cost as T?;
  }

  static void showModalBottomSheetWithoutHeader({
    required BuildContext context,
    required Widget content,
    bool isDissmisible = true,
  }) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: isDissmisible,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.ss),
      ),
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Wrap(children: [content]),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimens.ss),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimens.ss)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.m),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: AppDimens.xl),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.indicator,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  height: AppDimens.xxs,
                  width: AppDimens.xl,
                ),
                const SizedBox(height: AppDimens.ms),
                Text(
                  title,
                  style: AppTypography.bodyText1.copyWith(color: AppColors.white),
                ),
              ],
            ),
            CupertinoButton(
              padding: EdgeInsets.zero,
              minSize: AppDimens.zero,
              color: Colors.transparent,
              onPressed: () {
                AutoRouter.of(context).pop();
              },
              child: const Icon(
                Icons.clear,
                size: AppDimens.closeBottomsheetButton,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
