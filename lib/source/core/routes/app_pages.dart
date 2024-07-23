import 'package:counter/source/core/routes/app_routes.dart';
import 'package:counter/source/views/connect/connect_page.dart';
import 'package:counter/source/views/home/home_page.dart';
import 'package:counter/source/views/settings/settings_page.dart';
import 'package:counter/source/views/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPages {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.connect:
        {
          return MaterialPageRoute(
            builder: (_) => const ConnectPage(),
          );
        }
      case AppRoutes.home:
        {
          return MaterialPageRoute(
            builder: (_) => const HomePage(),
          );
        }
      case AppRoutes.settings:
        {
          return MaterialPageRoute(
            builder: (_) => const SettingsPage(),
          );
        }
      default:
        return CupertinoPageRoute(
          builder: (_) => const SplashPage(),
          settings: settings,
        );
    }
  }
}
