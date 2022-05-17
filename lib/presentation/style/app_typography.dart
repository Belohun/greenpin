import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenpin/presentation/style/app_colors.dart';
import 'package:greenpin/presentation/style/app_dimens.dart';

class AppTypography {
  const AppTypography._();



  static TextStyle get smallText1 => GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    color: AppColors.lightGray,

  );

  static TextStyle get bodyText1 => GoogleFonts.lato(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.lightGray,
      );

  static TextStyle get smallerBodyText => bodyText1.copyWith(fontSize: AppDimens.smallerBodyText);

  static TextStyle get headline1 => GoogleFonts.lato(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        color: AppColors.lightGray,
      );

  static TextStyle get headline1Bold =>
      headline1.copyWith(fontWeight: FontWeight.bold);

  static TextStyle get bodyText1Bold =>
      bodyText1.copyWith(fontWeight: FontWeight.bold);
}
