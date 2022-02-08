import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';

class GreenpinCheckbox extends StatelessWidget {
  const GreenpinCheckbox({
    required this.value,
    required this.onPressed,
    this.hasError = false,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool value;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: AppDimens.iconButtonSize,
      //: AppDimens.checkBoxSize,
      onPressed: () {
        FocusScope.of(context).unfocus();
        onPressed();
      },
      child: AnimatedContainer(
        width: AppDimens.iconButtonSize,
        height: AppDimens.iconButtonSize,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(
              AppDimens.cardRadius,
            ),
          ),
          border:
              Border.all(color: hasError ? AppColors.red : AppColors.lightGray),
        ),
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

class GreenpinCheckboxRow extends StatelessWidget {
  const GreenpinCheckboxRow({
    required this.value,
    required this.onPressed,
    required this.children,
    this.errorText,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPressed;
  final bool value;
  final List<Widget> children;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GreenpinCheckbox(
              hasError: errorText != null,
              value: value,
              onPressed: onPressed,
            ),
            ...children,
          ],
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.s),
            child: Text(
              errorText!,
              style: AppTypography.smallText1.copyWith(color: AppColors.red),
            ),
          ),
      ],
    );
  }
}
