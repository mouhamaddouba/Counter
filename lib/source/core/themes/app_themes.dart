import 'package:counter/source/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemes {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    primaryColorLight: AppColors.primary,
    primaryColorDark: AppColors.darkPrimary,
    disabledColor: AppColors.gray01,
    colorScheme: const ColorScheme.light(
      surface: AppColors.background,
      secondary: AppColors.onPrimary,
      primary: AppColors.primary,
    ),
  );
}
