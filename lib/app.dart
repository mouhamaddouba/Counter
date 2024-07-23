import 'package:counter/source/core/routes/app_pages.dart';
import 'package:counter/source/core/themes/app_themes.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// Cancel check marker in corner
      debugShowCheckedModeBanner: false,

      /// App name
      title: AppStrings.appName.tr(),

      /// Routing
      onGenerateRoute: AppPages.generateRoutes,

      /// Theme
      theme: AppThemes.lightTheme,

      /// Locale
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
