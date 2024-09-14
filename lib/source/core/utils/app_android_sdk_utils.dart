import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class AppAndroidSdkUtils {
  /// Get Android sdk version
  Future<int> getAndroidSDK() async {
    /// This for check Location permission
    /// if IOS app did not work check this code (permission.locationWhenInUse.status)
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      int androidVersion = androidInfo.version.sdkInt;
      return androidVersion;
    } else {
      return 0;
    }
  }

  /// Check version android sdk
  Future<bool> checkAndroidSDK() async {
    /// This for check Location permission
    /// if IOS app did not work check this code (permission.locationWhenInUse.status)
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      int androidVersion = androidInfo.version.sdkInt;
      if (androidVersion >= 33) {
        return Future<bool>.value(false);
      } else {
        return Future<bool>.value(true);
      }
    } else {
      return Future<bool>.value(true);
    }
  }
}
