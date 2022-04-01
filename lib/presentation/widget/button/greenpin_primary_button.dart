import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';

class GreenpinPrimaryButton extends StatelessWidget {
  const GreenpinPrimaryButton({
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.borderColor = AppColors.primary,
    this.borderRadius,
    this.backgroundColor = AppColors.primary,
    this.padding = const EdgeInsets.symmetric(horizontal: AppDimens.l),
    this.insidePadding = const EdgeInsets.symmetric(vertical: AppDimens.m),
    this.textColor = AppColors.white,
    this.isSmallText = false,
    Key? key,
  }) : super(key: key);

  const GreenpinPrimaryButton.outlined({
    required this.text,
    this.onPressed,
    this.width,
    this.height,
    this.borderRadius,
    this.padding,
    this.insidePadding,
    Key? key,
    bool isSelected = false,
  })  : backgroundColor = AppColors.white,
        borderColor = isSelected ? AppColors.lightGreen : AppColors.gray,
        textColor = isSelected ? AppColors.lightGreen : AppColors.gray,
        isSmallText = true,
        super(key: key);

  final VoidCallback? onPressed;
  final String text;
  final double? width;
  final double? height;
  final Color borderColor;
  final Radius? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? insidePadding;
  final Color? textColor;
  final bool isSmallText;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed == null ? 0.5 : 1,
      child: CupertinoButton(
        padding: padding,
        onPressed: () {
          FocusScope.of(context).unfocus();
          onPressed?.call();
        },
        child: AnimatedContainer(
          width: width,
          height: height,
          padding: insidePadding,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.transparent,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.all(
              borderRadius ?? const Radius.circular(AppDimens.cardRadius),
            ),
          ),
          duration: const Duration(seconds: AppDimens.animDurationInSeconds),
          child: Center(
            child: Text(
              text,
              style: isSmallText
                  ? AppTypography.smallText1.copyWith(color: textColor)
                  : AppTypography.bodyText1Bold.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
