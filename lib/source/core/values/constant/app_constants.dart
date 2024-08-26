import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

abstract class AppConstants {
  /// Constant size
  static const Size size150 = Size(150, 150);

  /// Constant Global widget
  static const int maxLines = 1;
  static const String emptyText = '';
  static const double appLoadingOpacity = 0.6;

  /// Constant Border
  static const double border1_5 = 1.5;
  static const double border1_2 = 1.2;

  /// Constant opacity
  static const double opacity00 = 0.0;
  static const double opacity0_6 = 0.6;
  static const double opacity0_7 = 0.7;
  static const double opacity01 = 1.0;

  /// Constant duration
  static const int duration00 = 0;
  static const int duration02 = 2;
  static const int duration15 = 15;
  static const int duration150 = 150;
  static const int duration300 = 300;
  static const int duration500 = 500;
  static const int duration600 = 600;
  static const int duration800 = 800;
  static const int duration1200 = 1200;
  static const int duration2500 = 2500;

  /// Constant offsets
  static const Offset offset10 = Offset(10, 10);
  static const Offset offset00 = Offset(0, 0);

  /// Constant transform
  static const double transform12 = 12;
  static const double transform18 = 18;

  /// Constant cross
  static const double cross3_8 = 3.8;
  static const int cross04 = 4;
  static const double cross7_8 = 7.8;
  static const int cross12 = 12;
  static const int cross14 = 14;
  static const int cross16 = 16;
  static const int cross20 = 20;
  static const int cross40 = 40;

  /// Constant Main Axis
  static const double mainAxis4 = 4;
  static const double mainAxis5 = 5;
  static const double mainAxis8 = 8;

  /// Constant indexes
  static const int index01 = 1;
  static const int index05 = 5;
  static const int index06 = 6;
  static const int index07 = 7;

  /// Constant Tween
  static const double tween00 = 0;
  static const double tween0_9 = 0.9;
  static const double tween1_1 = 1.1;
  static const double tween12 = 12;

  /// Fake Data
  static List<BluetoothDevice> devicesList = [
    BluetoothDevice(
      remoteId: const DeviceIdentifier("06:E5:28:3B:FD:E0"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("AA:E5:28:3F:FD:E0"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("16:0c:90:3e:63:23"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("1d:3e:5e:55:5e:15"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("b7:3a:b8:5b:00:96"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("7c:8a:2e:22:ca:e1"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("c6:40:0c:68:ad:80"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("d8:41:2f:38:a0:8d"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("2e:b7:e2:bf:05:aa"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("c7:4a:4d:05:77:7b"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("f4:f1:c6:d3:5a:de"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("8d:98:b6:ab:ab:4b"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("fe:f6:81:56:fb:3b"),
    ),
    BluetoothDevice(
      remoteId: const DeviceIdentifier("5d:c4:b5:b4:1e:89"),
    ),
  ];
}
