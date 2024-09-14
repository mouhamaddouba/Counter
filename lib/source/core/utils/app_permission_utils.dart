// ignore_for_file: context
import 'dart:io';
import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/utils/app_alert_utils.dart';
import 'package:counter/source/core/utils/app_android_sdk_utils.dart';
import 'package:counter/source/core/utils/app_bluetooth_utils.dart';
import 'package:counter/source/core/utils/app_location_utils.dart';
import 'package:counter/source/core/values/constant/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionUtils {
  /// This for check permission External
  Future<bool> checkPermissionExternal() async {
    /// This for check Location permission
    /// if IOS app did not work check this code (permission.locationWhenInUse.status)
    if (Platform.isWindows) {
      return Future<bool>.value(true);
    }

    if (Platform.isAndroid) {
      bool check = await AppAndroidSdkUtils().checkAndroidSDK();
      if (!check) {
        return Future<bool>.value(true);
      }
    }

    if (await Permission.storage.request().isGranted) {
      return Future<bool>.value(true);
    } else {
      var status = await Permission.storage.status;

      if (AppSettings.navigatorKey.currentContext!.mounted) {
        if (status.isDenied ||
            status.isPermanentlyDenied ||
            status.isRestricted) {
          showDialog(
            context: AppSettings.navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(
                  AppStrings.storagePermission.t(),
                ),
                content: Text(
                  AppStrings.thisAppNeedsStorageAccessForSaveData.t(),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      AppStrings.deny.t(),
                      style: const TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      AppStrings.settings.t(),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      openAppSettings();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
      if (status.isGranted) {
        return Future<bool>.value(true);
      }
    }

    return Future<bool>.value(false);
  }

  /// Check location for all app
  Future<bool> checkAll(Function retry) async {
    bool check = false;
    check = await AppLocationUtils().checkLocationPermission();
    if (!check) {
      retry();
      return Future<bool>.value(false);
    }

    check = await checkCameraPermission();
    if (!check) {
      retry();
      return Future<bool>.value(false);
    }

    if (!Platform.isIOS) {
      check = await AppBluetoothUtils().checkPermissionBluetooth();
      if (!check) {
        retry();
        return Future<bool>.value(false);
      }
    }

    check = await AppLocationUtils().locationIsEnable();
    if (!check) {
      AppAlertUtils().showAlertDialog(
        AppStrings.locationIsNotEnable.t(),
        retry,
        AppSettings.navigatorKey.currentContext!,
      );
      return Future<bool>.value(false);
    }

    check = await AppBluetoothUtils().bluetoothIsEnable();
    if (!check) {
      AppAlertUtils().showAlertDialog(
        AppStrings.bluetoothIsNotEnable.t(),
        retry,
        AppSettings.navigatorKey.currentContext!,
      );
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }

  Future<bool> checkCameraPermission() async {
    if (await Permission.camera.request().isGranted) {
      return Future<bool>.value(true);
    } else {
      var status = await Permission.camera.status;

      if (AppSettings.navigatorKey.currentContext!.mounted) {
        if (status.isDenied ||
            status.isPermanentlyDenied ||
            status.isRestricted) {
          await showDialog(
            context: AppSettings.navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(
                  AppStrings.cameraPermission.t(),
                ),
                content: Text(
                  AppStrings.thisAppNeedsCameraAccessForQRScan.t(),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      AppStrings.deny.t(),
                      style: const TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      AppStrings.settings.t(),
                    ),
                    onPressed: () async {
                      await openAppSettings();
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        }
      }
      if (status.isGranted) {
        return Future<bool>.value(true);
      }
    }

    return Future<bool>.value(false);
  }
}
