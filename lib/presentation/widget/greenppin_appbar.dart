import 'package:flutter/material.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';

class GreenpinAppbar extends StatelessWidget implements PreferredSizeWidget {
  const GreenpinAppbar({
    Key? key,
    this.title,
    this.actions,
    this.leading,
    this.background,
    this.centerTitle,
    this.onLeadPressed,
    this.onActionPressed,
    this.leadingColor,
    this.textColor,
  }) : super(key: key);

  factory GreenpinAppbar.empty() =>
      const GreenpinAppbar(leading: SizedBox.shrink());

  factory GreenpinAppbar.green({
    String? title,
    List<Widget>? actions,
    Color? leadingColor,
    Widget? leading,
    bool? centerTitle,
    VoidCallback? onLeadPressed,
    VoidCallback? onActionPressed,
    Color? textColor = AppColors.white,
    Color? background = AppColors.primary,
  }) =>
      GreenpinAppbar(
        title: title,
        actions: actions,
        leading: leading,
        leadingColor: leadingColor ?? AppColors.white,
        centerTitle: centerTitle,
        onActionPressed: onActionPressed,
        onLeadPressed: onLeadPressed,
        background: background,
        textColor: textColor,
      );

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
  final String? title;
  final List<Widget>? actions;
  final Color? leadingColor;
  final Widget? leading;
  final bool? centerTitle;
  final VoidCallback? onLeadPressed;
  final VoidCallback? onActionPressed;
  final Color? background;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle,
      backgroundColor: background ?? AppColors.white,
      title: Text(
        title ?? '',
        overflow: TextOverflow.ellipsis,
        style: AppTypography.bodyText1.copyWith(color: textColor),
      ),
      elevation: AppDimens.zero,
      actions: actions ?? const [SizedBox.shrink()],
      leading: leading ??
          CustomIconButton(
            color: leadingColor ?? AppColors.lightGreen,
            onPressed: onLeadPressed ?? () => Navigator.maybePop(context),
          ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final Color color;
  final Icon? icon;
  final VoidCallback onPressed;

  const CustomIconButton({
    required this.onPressed,
    this.color = Colors.white,
    Key? key,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: icon ?? const Icon(Icons.arrow_back_ios),
      color: color,
      onPressed: onPressed,
    );
  }
}
