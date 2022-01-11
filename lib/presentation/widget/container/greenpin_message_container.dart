import 'package:flutter/material.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';

class GreenpinMessageContainer extends StatelessWidget {
  const GreenpinMessageContainer({
    required this.text,
    required this.icon,
    this.backgroundColor = AppColors.lightGreen,
    this.iconColor,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final Color backgroundColor;
  final Color? iconColor;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return _Body(
      backgroundColor: backgroundColor,
      icon: icon,
      iconColor: iconColor,
      child: DefaultTextStyle(
        style: textStyle ??
            AppTypography.bodyText1.copyWith(
              color: AppColors.white,
            ),
        child: Text(text),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Color backgroundColor;
  final IconData icon;
  final Color? iconColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimens.m,
        horizontal: AppDimens.ss,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(AppDimens.cardRadius)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: iconColor ?? AppColors.white,
          ),
          const SizedBox(width: AppDimens.m),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

