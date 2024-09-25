import 'package:counter/source/core/routes/app_pages.dart';
import 'package:counter/source/core/services/app_bindings_services.dart';
import 'package:counter/source/core/themes/app_themes.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_settings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      /// Cancel check marker in corner
      debugShowCheckedModeBanner: false,
      navigatorKey: AppSettings.navigatorKey,

      /// App name
      title: AppStrings.appName,

      /// Bindings
      initialBinding: AppBindingsServices(),

      /// Routing
      onGenerateRoute: AppPages.generateRoutes,

      /// Theme
      theme: AppTheme.getAppTheme(),

      /// Locale
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
