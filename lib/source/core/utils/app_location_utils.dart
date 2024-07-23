import 'dart:io';

import 'package:counter/source/core/translations/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class AppLocationUtils {
  /// This for check Location permission
  Future<bool> checkLocationPermission(BuildContext ctx) async {
    //if IOS app did not work check this code (permission.locationWhenInUse.status)
    if (Platform.isWindows) {
      return Future<bool>.value(true);
    }

    if (await Permission.location.request().isGranted) {
      return Future<bool>.value(true);
    } else {
      var status = await Permission.location.status;

      if (ctx.mounted) {
        if (status.isDenied ||
            status.isPermanentlyDenied ||
            status.isRestricted) {
          showDialog(
            context: ctx,
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: const Text(AppStrings.locationPermission),
                content: const Text(
                  AppStrings.locationAccessConnection,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: const Text(
                      AppStrings.deny,
                      style: TextStyle(
                        color: Colors.redAccent,
                      ),
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

  /// Check if location is enable
  Future<bool> locationIsEnable(BuildContext ctx) async {
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
