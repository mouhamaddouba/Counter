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
  static const double opacity0_6 = 0.6;
  static const double opacity0_7 = 0.7;

  /// Constant duration
  static const int duration15 = 15;
  static const int duration150 = 150;
  static const int duration2500 = 2500;

  /// Constant offsets
  static const Offset offset10 = Offset(10, 10);

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
