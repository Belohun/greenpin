import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';

class GreenpinIconButton extends StatelessWidget {
  const GreenpinIconButton({
    required this.onPressed,
    required this.iconData,
    this.background = AppColors.primary,
    this.iconColor = AppColors.white,
    this.shape,
    this.size = AppDimens.iconButtonSize,
    this.borderColor = AppColors.lightGreen,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onPressed;
  final IconData iconData;
  final Color background;
  final Color iconColor;
  final BoxShape? shape;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onPressed != null ? 1 : 0.5,
      child: CupertinoButton(
        minSize: size,
        padding: EdgeInsets.zero,
        onPressed: onPressed != null
            ? () {
                FocusScope.of(context).unfocus();
                onPressed?.call();
              }
            : null,
        child: AnimatedContainer(
          width: size,
          height: size,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            color: background,
            shape: shape ?? BoxShape.rectangle,
            borderRadius: shape != null
                ? null
                : const BorderRadius.all(Radius.circular(AppDimens.cardRadius)),
          ),
          duration: const Duration(
              milliseconds: AppDimens.checkBoxDurationInMilliseconds),
          child: Icon(
            iconData,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
