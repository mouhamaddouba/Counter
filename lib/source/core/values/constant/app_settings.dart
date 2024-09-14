import 'dart:io';

import 'package:flutter/material.dart';

class AppSettings {
  static int? battery;
  static String? token = '';
  static bool isSkipped = false;
  static const int scanDelay = 15;
  static const int batteryLowLevel = 20;
  static final navigatorKey = GlobalKey<NavigatorState>();
  static int fileSendBytesSize = Platform.isIOS ? 20 : 450;
}
