import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/utils/app_android_sdk_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class AppBluetoothUtils {
  /// Check permission for bluetooth
  static Future<bool> checkPermissionBluetooth(BuildContext context) async {
    int sdkNumber = await AppAndroidSdkUtils().getAndroidSDK(context);
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

      if (context.mounted) {
        if (statusBluetooth.isDenied ||
            statusBluetooth.isPermanentlyDenied ||
            statusBluetooth.isRestricted ||
            statusBluetoothConnect.isDenied ||
            statusBluetoothConnect.isPermanentlyDenied ||
            statusBluetoothConnect.isRestricted ||
            statusBluetoothScan.isDenied ||
            statusBluetoothScan.isPermanentlyDenied ||
            statusBluetoothScan.isRestricted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text(AppStrings.bluetoothPermission),
                content: const Text(AppStrings.accessConnection),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text(
                      AppStrings.deny,
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
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
      if (statusBluetooth.isGranted &&
          statusBluetoothConnect.isGranted &&
          statusBluetoothScan.isGranted) {
        return Future<bool>.value(true);
      }
    }

    return Future<bool>.value(false);
  }

  /// Check if bluetooth is enable
  Future<bool> bluetoothIsEnable(BuildContext ctx) async {
    bool bluetoothIsEnable =
        await FlutterBluePlus.adapterState.first == BluetoothAdapterState.on;
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
  Future<bool> checkBluetooth(Function retry, BuildContext ctx) async {
    bool check = false;

    check = await bluetoothIsEnable(ctx);
    if (!check) {
      if (ctx.mounted) {}
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}
