import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';

class GreenpinTextField extends HookWidget {
  const GreenpinTextField({
    Key? key,
    this.errorText,
    this.hintText,
    this.maxLines = 1,
    this.disabled = false,
    this.textEditingController,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
    this.labelText,
    this.initText,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: AppDimens.l,
      vertical: AppDimens.m,
    ),
    this.floatingLabel = true,
    this.suffix,
    this.textInputType,
    this.autofocus = false,
    this.textAlign = TextAlign.left,
    this.isPassword = false,
    this.onSubmitted,
  }) : super(key: key);

  final String? hintText;
  final bool disabled;
  final TextEditingController? textEditingController;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final Function(String text)? onChanged;
  final String? labelText;
  final bool autofocus;
  final bool floatingLabel;
  final Widget? suffix;
  final TextInputType? textInputType;
  final EdgeInsetsGeometry contentPadding;
  final String? errorText;
  final int? maxLines;
  final String? initText;
  final TextAlign textAlign;
  final bool isPassword;
  final Function(String text)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final _controller = useMemoized<TextEditingController?>(() {
      if (textEditingController == null && initText != null) {
        return TextEditingController(text: initText);
      } else if (textEditingController != null && initText != null) {
        textEditingController!.text = initText!;
      }
      return textEditingController;
    }, [textEditingController, key]);

    return TextField(
      obscureText: isPassword,
      enableSuggestions: !isPassword,
      autocorrect: !isPassword,
      textAlign: textAlign,
      maxLines: maxLines,
      autofocus: autofocus,
      onTap: onTap,
      //textInputAction: TextInputAction.next,
      onSubmitted: onSubmitted,
      controller: _controller,
      enableInteractiveSelection: !disabled,
      // focusNode: disabled ? AlwaysDisabledFocusNode() : null,
      cursorColor: AppColors.lightGray,
      keyboardType: textInputType,
      style: AppTypography.bodyText1,
      decoration: InputDecoration(
        errorMaxLines: 2,
        floatingLabelBehavior: floatingLabel
            ? FloatingLabelBehavior.auto
            : FloatingLabelBehavior.never,
        contentPadding: contentPadding,
        alignLabelWithHint: false,
        labelText: labelText,
        labelStyle: AppTypography.bodyText1,
        hintText: hintText,
        //  hintStyle: AppTypography.medium.copyWith(color: AppColors.gray2),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        suffixIcon: suffix != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [suffix!],
              )
            : null,
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.cardRadius),
          ),
          borderSide: BorderSide(
            color: AppColors.lightGray,
            width: AppDimens.borderWidth,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.cardRadius),
          ),
          borderSide: BorderSide(
            color: AppColors.lightGray,
            width: AppDimens.borderWidth,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.cardRadius),
          ),
          borderSide: BorderSide(
            color: AppColors.red,
            width: AppDimens.borderWidth,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimens.cardRadius),
          ),
          borderSide: BorderSide(
            color: AppColors.red,
            width: AppDimens.borderWidth,
          ),
        ),
        errorText: errorText,
        //  errorStyle: AppTypography.medium.copyWith(color: AppColors.red), //TODO
      ),
      onChanged: onChanged,
    );
  }
}
