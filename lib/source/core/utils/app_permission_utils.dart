// ignore_for_file: context
import 'dart:io';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/utils/app_android_sdk_utils.dart';
import 'package:counter/source/core/utils/app_bluetooth_utils.dart';
import 'package:counter/source/core/utils/app_location_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissionUtils {
  /// This for check permission External
  Future<bool> checkPermissionExternal(BuildContext context) async {
    //if IOS app did not work check this code (permission.locationWhenInUse.status)
    if (Platform.isWindows) {
      return Future<bool>.value(true);
    }

    if (Platform.isAndroid) {
      bool check = await AppAndroidSdkUtils().checkAndroidSDK(context);
      if (!check) {
        return Future<bool>.value(true);
      }
    }

    if (await Permission.storage.request().isGranted) {
      return Future<bool>.value(true);
    } else {
      var status = await Permission.storage.status;

      if (context.mounted) {
        if (status.isDenied ||
            status.isPermanentlyDenied ||
            status.isRestricted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text(AppStrings.storagePermission),
                content: const Text(
                  AppStrings.storageAccess,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text(
                      AppStrings.deny,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                    child: const Text(AppStrings.settings),
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
  Future<bool> checkAll(Function retry, BuildContext context) async {
    bool check = false;
    check = await AppLocationUtils().checkLocationPermission(context);
    if (!check) {
      retry();
      return Future<bool>.value(false);
    }

    if (!Platform.isIOS) {
      check = await AppBluetoothUtils.checkPermissionBluetooth(context);
      if (!check) {
        retry();
        return Future<bool>.value(false);
      }
    }

    check = await AppLocationUtils().locationIsEnable(context);
    if (!check) {
      return Future<bool>.value(false);
    }

    check = await AppBluetoothUtils().bluetoothIsEnable(context);
    if (!check) {
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}
