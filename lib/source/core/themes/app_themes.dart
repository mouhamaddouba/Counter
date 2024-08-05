import 'package:flutter/material.dart';
import 'app_colors.dart';

enum ThemeEnum { system, light, dark }

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
    // final String prefsTheme = AppPrefs().appTheme;
    return _lightTheme();
  }

  static bool _isDarkMode() {
    final darkMode =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (darkMode == Brightness.dark) {
      return true;
    } else {
      return false;
    }
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
        size: 24,
      ),
      checkboxTheme: const CheckboxThemeData(
        side: BorderSide(
          color: AppColors.gray03,
        ),
      ),
    );
  }

  static ThemeData _darkTheme() {
    return _baseTheme().copyWith(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.gray03,
      dividerTheme: const DividerThemeData(
        color: AppColors.white01,
      ),
      colorScheme: const ColorScheme.light(
        surface: AppColors.black01,
        error: AppColors.errorLight,
        primary: AppColors.primary,
        onSurface: AppColors.white01,
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
