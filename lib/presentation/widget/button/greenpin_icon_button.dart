import 'package:flutter/cupertino.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';

class GreenpinIconButton extends StatelessWidget {
  const GreenpinIconButton({
    required this.onPressed,
    required this.iconData,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        FocusScope.of(context).unfocus();
        onPressed();
      },
      child: AnimatedContainer(
        width: AppDimens.iconButtonSize,
        height: AppDimens.iconButtonSize,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(AppDimens.cardRadius)),
        ),
        duration: const Duration(
            milliseconds: AppDimens.checkBoxDurationInMilliseconds),
        child: Icon(
          iconData,
          color: AppColors.white,
        ),
      ),
    );
  }
}
