import 'package:flutter/material.dart';
import 'package:greenpin/exports.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';
import 'package:greenpin/presentation/style/app_typography.dart';
import 'package:greenpin/presentation/widget/container/greenpin_message_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum SnackBarGravity { top, bottom }

class SnackBarUtils {
  static OverlayEntry? _topSnackBarOverlay;
  static bool isSnackBarVisible = false;

  static void showErrorSnackBar(
    BuildContext context,
    String error, {
    SnackBarGravity gravity = SnackBarGravity.top,
  }) {
    showErrorSnackBarText(
      context,
      error,
      gravity: gravity,
    );
  }

  static void showErrorSnackBarText(
    BuildContext context,
    String text, {
    SnackBarGravity gravity = SnackBarGravity.top,
    Color? color,
    bool shouldReplace = true,
  }) {
    if (shouldReplace) {
      _removeSnackBar(context);
    }
    if (gravity == SnackBarGravity.top) {
      _showSnackBarTop(context, text, Icons.warning_amber_rounded);
    } else {
      _showSnackBarBottom(context, text, Icons.warning_amber_rounded,
          color: color, shouldReplace: shouldReplace);
    }
  }

  static void showPositiveMessageSnackbar(
    BuildContext context,
    String text, {
    SnackBarGravity gravity = SnackBarGravity.top,
    Color? color,
    bool? okButton,
    bool shouldReplace = true,
  }) {
    if (shouldReplace) {
      _removeSnackBar(context);
    }
    if (gravity == SnackBarGravity.bottom) {
      _showSnackBarBottom(
        context,
        text,
        Icons.check,
        color: AppColors.lightGreen,
        snackBarWithOkOption: okButton,
      );
    } else {
      _showSnackBarTop(
        context,
        text,
        Icons.check,
        color: AppColors.lightGreen,
      );
    }
  }

  static void _showSnackBarTop(
    BuildContext context,
    String text,
    IconData icon, {
    Color color = AppColors.red,
    Color? iconColor,
    TextStyle? textStyle,
  }) {
    _showTopSnackBar(
        context,
        GreenpinMessageContainer(
          text: text,
          icon: icon,
          iconColor: iconColor,
          textStyle: textStyle,
          backgroundColor: color,
        ),
        additionalTopPadding: kToolbarHeight);
  }

  static Future _showTopSnackBar(
    BuildContext context,
    Widget child, {
    Duration showOutAnimationDuration =
        const Duration(seconds: AppDimens.snackbarShowOutDuration),
    Duration hideOutAnimationDuration =
        const Duration(milliseconds: AppDimens.snackbarHideDurationMs),
    Duration displayDuration =
        const Duration(seconds: AppDimens.snackbarDisplayDuration),
    double additionalTopPadding = AppDimens.m,
    VoidCallback? onTap,
    OverlayState? overlayState,
  }) async {
    overlayState ??= Overlay.of(context);
    late final OverlayEntry currentSnackBarOverlay;
    currentSnackBarOverlay = OverlayEntry(
      builder: (context) {
        return TopSnackBar(
          onDismissed: () {
            if (_topSnackBarOverlay == currentSnackBarOverlay) {
              _topSnackBarOverlay?.remove();
              _topSnackBarOverlay = null;
            }
          },
          showOutAnimationDuration: showOutAnimationDuration,
          hideOutAnimationDuration: hideOutAnimationDuration,
          displayDuration: displayDuration,
          additionalTopPadding: additionalTopPadding,
          onTap: onTap,
          child: child,
        );
      },
    );

    _topSnackBarOverlay = currentSnackBarOverlay;
    overlayState?.insert(currentSnackBarOverlay);
  }

  static void _showSnackBarBottom(
    BuildContext context,
    String text,
    IconData icon, {
    bool shouldReplace = true,
    Color? color,
    bool? snackBarWithOkOption,
    Color? iconColor,
  }) {
    final snackBar = SnackBar(
      elevation: AppDimens.zero,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: AppDimens.snackbarDisplayDuration),
      content: snackBarWithOkOption != null && snackBarWithOkOption
          ? _getSnackBarContentWithOkButtons(text, icon, context)
          : GreenpinMessageContainer(
              text: text,
              icon: icon,
              iconColor: iconColor,
              backgroundColor: color ?? AppColors.red,
            ),
    );
    if (shouldReplace) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      if (!isSnackBarVisible) {
        ScaffoldMessenger.of(context)
            .showSnackBar(snackBar)
            .closed
            .then((value) {
          isSnackBarVisible = false;
        });
      }
      isSnackBarVisible = true;
    }
  }

  static Widget _getSnackBarContentWithOkButtons(
          String text, IconData icon, BuildContext context) =>
      Row(
        children: [
          Icon(
            icon,
            size: AppDimens.ss,
            color: AppColors.white,
          ),
          const SizedBox(width: AppDimens.ml),
          Expanded(
            child: Wrap(
              children: [
                DefaultTextStyle(
                  style: AppTypography.bodyText1.copyWith(
                    color: AppColors.white,
                  ),
                  child: Text(text),
                ),
              ],
            ),
          ),
          GestureDetector(
              onTap: () => _removeSnackBar(context),
              child: Text(LocaleKeys.ok.tr()))
        ],
      );

  static void _removeSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    _topSnackBarOverlay?.remove();
    _topSnackBarOverlay = null;
  }
}
