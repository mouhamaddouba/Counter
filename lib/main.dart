import 'package:counter/app.dart';
import 'package:counter/source/core/translations/localization/app_translations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  /// Inject widget app
  WidgetsFlutterBinding.ensureInitialized();

  /// Init translation library
  await EasyLocalization.ensureInitialized();

  /// Set screen on horizontal mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  /// Set setup to chrome system
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [],
  );

  /// Make system chrome in dark mode
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(
    /// Translations
    EasyLocalization(
      path: assetPathLocalization,
      supportedLocales: const [englishLocal, arabicLocal],

      /// Response UI
      child: ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return const App();
        },
      ),
    ),
  );
}
