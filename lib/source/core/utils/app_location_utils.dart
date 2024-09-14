import 'dart:io';

import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppLocationUtils {
  /// This for check Location permission
  Future<bool> checkLocationPermission() async {
    if (Platform.isWindows) {
      return Future<bool>.value(true);
    }

    if (await Permission.location.request().isGranted) {
      return Future<bool>.value(true);
    } else {
      var status = await Permission.location.status;

      if (AppSettings.navigatorKey.currentContext!.mounted) {
        if (status.isDenied ||
            status.isPermanentlyDenied ||
            status.isRestricted) {
          await showDialog(
            context: AppSettings.navigatorKey.currentContext!,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(
                  AppStrings.locationPermission.t(),
                ),
                content: Text(
                  AppStrings.thisAppNeedsLocationAccessForBluetoothConnection
                      .t(),
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
                    child: Text(AppStrings.settings.t()),
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
    //print(status);
  }

  /// Check if location is enable
  Future<bool> locationIsEnable() async {
    if (Platform.isWindows) {
      return true;
    }

    bool locationIsEnable = await Permission.location.serviceStatus.isEnabled;

    if (locationIsEnable) {
      return true;
    } else {
      return false;
    }
  }
}
