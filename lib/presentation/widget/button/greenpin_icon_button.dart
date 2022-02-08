import 'package:flutter/cupertino.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';

class GreenpinIconButton extends StatelessWidget {
  const GreenpinIconButton({
    required this.onPressed,
    required this.iconData,
    this.background = AppColors.primary,
    this.iconColor = AppColors.white,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData iconData;
  final Color background;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: AppDimens.iconButtonSize,
      padding: EdgeInsets.zero,
      onPressed: () {
        FocusScope.of(context).unfocus();
        onPressed();
      },
      child: AnimatedContainer(
        width: AppDimens.iconButtonSize,
        height: AppDimens.iconButtonSize,
        decoration: BoxDecoration(
          color: background,
          borderRadius:
              const BorderRadius.all(Radius.circular(AppDimens.cardRadius)),
        ),
        duration: const Duration(
            milliseconds: AppDimens.checkBoxDurationInMilliseconds),
        child: Icon(
          iconData,
          color: iconColor,
        ),
      ),
    );
  }
}
