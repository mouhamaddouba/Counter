import 'package:counter/source/core/services/bluetooth/app_connect_services.dart';
import 'package:counter/source/view_model/connect/connect_view_model.dart';
import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:counter/source/view_model/settings/settings_view_model.dart';
import 'package:counter/source/view_model/splash/splash_view_model.dart';
import 'package:get/get.dart';

class AppBindingsServices extends Bindings {
  @override
  void dependencies() {
    /// Splash
    Get.lazyPut(
      () => SplashViewModel(),
    );

    /// Connect
    Get.lazyPut(
      () => ConnectViewModel(),
    );

    /// Home
    Get.lazyPut(
      () => HomeViewModel(),
    );

    /// Settings
    Get.lazyPut(
      () => SettingsViewModel(),
    );

    /// Connection BLE
    Get.put(
      AppConnectServices(),
    );
  }
}
