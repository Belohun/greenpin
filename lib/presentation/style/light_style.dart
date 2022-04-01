import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:greenpin/presentation/style/app_colors.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  textTheme: GoogleFonts.latoTextTheme(),
  fontFamily: 'Lato',
  backgroundColor: AppColors.white,
  scaffoldBackgroundColor: AppColors.white,
  primaryColor: AppColors.primary,
  appBarTheme: const AppBarTheme(
    color: AppColors.white,
    elevation: 0,
  ),
  disabledColor: AppColors.lightGray,
);