import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class AppAndroidSdkUtils {
  /// Get Android sdk version
  Future<int> getAndroidSDK(BuildContext context) async {
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
  Future<bool> checkAndroidSDK(BuildContext ctx) async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      int androidVersion = androidInfo.version.sdkInt;
      if (androidVersion == 33) {
        return Future<bool>.value(false);
      } else {
        return Future<bool>.value(true);
      }
    } else {
      return Future<bool>.value(true);
    }
  }
}
