import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

enum ThemeEnum {
  system,
  light,
  dark,
}

class AppTheme {
  /// current os theme
  final darkMode =
      WidgetsBinding.instance.platformDispatcher.platformBrightness;

  /// current app theme
  static ThemeEnum currentTheme = ThemeEnum.system;

  static final String system = ThemeEnum.system.name;
  static final String light = ThemeEnum.light.name;
  static final String dark = ThemeEnum.dark.name;

  static ThemeData getAppTheme() {
    return _lightTheme();
  }

  static String getAppThemeMode() {
    return ThemeEnum.light.name;
  }

  static ThemeData _lightTheme() {
    return _baseTheme().copyWith(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.white01,
      dividerTheme: const DividerThemeData(
        color: AppColors.black01,
      ),
      colorScheme: const ColorScheme.light(
        surface: AppColors.white01,
        error: AppColors.errorLight,
        primary: AppColors.primary,
      ),
      iconTheme: const IconThemeData(
        color: AppColors.darkPrimary,
        size: AppDimensions.iconSize24,
      ),
      checkboxTheme: const CheckboxThemeData(
        side: BorderSide(
          color: AppColors.gray03,
        ),
      ),
    );
  }

  static ThemeData _baseTheme() {
    return ThemeData(
      primaryColor: AppColors.primary,
      primaryColorDark: AppColors.darkPrimary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
