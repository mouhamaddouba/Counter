import 'dart:io';

import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/utils/app_alert_utils.dart';
import 'package:counter/source/core/utils/app_android_sdk_utils.dart';
import 'package:counter/source/core/values/constant/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class AppBluetoothUtils {
  /// Check permission for bluetooth
  Future<bool> checkPermissionBluetooth() async {
    int sdkNumber = await AppAndroidSdkUtils().getAndroidSDK();
    bool bluetooth = await Permission.bluetooth.request().isGranted;
    bool bluetoothConnect =
        await Permission.bluetoothConnect.request().isGranted;
    bool bluetoothScan = await Permission.bluetoothScan.request().isGranted;
    if (sdkNumber > 30) {
      bluetooth = true;
    }

    if (bluetooth && bluetoothConnect && bluetoothScan) {
      return Future<bool>.value(true);
    } else {
      PermissionStatus statusBluetooth = await Permission.bluetooth.status;
      PermissionStatus statusBluetoothConnect =
          await Permission.bluetoothConnect.status;
      PermissionStatus statusBluetoothScan =
          await Permission.bluetoothScan.status;

      if (sdkNumber > 30) {
        statusBluetooth = PermissionStatus.granted;
      }

      if (AppSettings.navigatorKey.currentContext!.mounted) {
        if (statusBluetooth.isDenied ||
            statusBluetooth.isPermanentlyDenied ||
            statusBluetooth.isRestricted ||
            statusBluetoothConnect.isDenied ||
            statusBluetoothConnect.isPermanentlyDenied ||
            statusBluetoothConnect.isRestricted ||
            statusBluetoothScan.isDenied ||
            statusBluetoothScan.isPermanentlyDenied ||
            statusBluetoothScan.isRestricted) {
          await showDialog(
            context: AppSettings.navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(
                  AppStrings.bluetoothPermission.t(),
                ),
                content: Text(
                  AppStrings.thisAppNeedsBluetoothAccessConnection.t(),
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
      if (statusBluetooth.isGranted &&
          statusBluetoothConnect.isGranted &&
          statusBluetoothScan.isGranted) {
        return Future<bool>.value(true);
      }
    }

    return Future<bool>.value(false);
  }

  /// Check if bluetooth is enable
  Future<bool> bluetoothIsEnable() async {
    bool bluetoothIsEnable =
        await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
    if (Platform.isIOS) {
      ///To not ask me why but this shit can only work by this way in ios;
      await Future.delayed(
        const Duration(
          milliseconds: 100,
        ),
      );
      bluetoothIsEnable =
          await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
    }
    if (kDebugMode) {
      print(
          'bluetoothIsEnable:................................$bluetoothIsEnable');
    }
    if (bluetoothIsEnable) {
      return true;
    } else {
      return false;
    }
  }

  /// Check bluetooth
  Future<bool> checkBluetooth(Function retry) async {
    bool check = false;

    check = await bluetoothIsEnable();
    if (!check) {
      if (AppSettings.navigatorKey.currentContext!.mounted) {
        AppAlertUtils().showAlertDialog(
          AppStrings.bluetoothIsNotEnable.t(),
          retry,
          AppSettings.navigatorKey.currentContext!,
        );
      }
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}
