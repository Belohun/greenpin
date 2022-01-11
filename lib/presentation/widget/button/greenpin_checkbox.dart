import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';

class GreenpinCheckbox extends StatelessWidget {
  const GreenpinCheckbox({
    required this.value,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        FocusScope.of(context).unfocus();
        onPressed();
      },
      child: AnimatedContainer(
        width: AppDimens.checkBoxSize,
        height: AppDimens.checkBoxSize,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                AppDimens.cardRadius,
              ),
            ),
            border: Border.all(color: AppColors.lightGray)),
        duration: const Duration(
          milliseconds: AppDimens.checkBoxDurationInMilliseconds,
        ),
        child: value
            ? const Icon(
                Icons.check,
                color: AppColors.primary,
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
