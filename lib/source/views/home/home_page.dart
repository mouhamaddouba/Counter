import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:counter/source/views/home/home_content_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeViewModel> {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const HomeContentView();
    // return StreamBuilder<BluetoothStatusEnum>(
    //   stream: appConnectServices.outBluetoothState,
    //   builder: (context, snapshot) {
    //     switch (snapshot.data) {
    //       // If bluetooth connect
    //       case BluetoothStatusEnum.connected:
    //         return Container(
    //           color: AppColors.errorLight,
    //         );
    //
    //       // If bluetooth disable
    //       case BluetoothStatusEnum.disable:
    //         return AppStateRenderUtils(
    //           titleState: AppStrings.bluetoothNotEnabel,
    //           lottieType: AppStateRenderEnum.settings,
    //           onPressed: () {
    //             _checkBluetooth();
    //           },
    //         );
    //
    //       // If bluetooth need location permission
    //       case BluetoothStatusEnum.needLocationPermission:
    //         return AppStateRenderUtils(
    //           titleState: AppStrings.locationAccess,
    //           lottieType: AppStateRenderEnum.settings,
    //           onPressed: () {
    //             AppConnectServices().reconnect();
    //           },
    //         );
    //
    //       // If bluetooth enable location
    //       case BluetoothStatusEnum.enableLocation:
    //         return AppStateRenderUtils(
    //           titleState: AppStrings.locationNotEnabel,
    //           lottieType: AppStateRenderEnum.settings,
    //           onPressed: () {
    //             AppConnectServices().reconnect();
    //           },
    //         );
    //
    //       // If bluetooth enable
    //       case BluetoothStatusEnum.enable:
    //         return const AppStateRenderUtils(
    //           titleState: AppStrings.connecting,
    //           lottieType: AppStateRenderEnum.connecting,
    //         );
    //
    //       // If bluetooth failed to connect
    //       case BluetoothStatusEnum.failedToConnect:
    //         return AppStateRenderUtils(
    //           titleState: AppStrings.noDevice,
    //           lottieType: AppStateRenderEnum.notFound,
    //           onPressed: () {
    //             _checkBluetooth();
    //           },
    //         );
    //
    //       // If bluetooth already connected
    //       case BluetoothStatusEnum.alreadyConnected:
    //         return AppStateRenderUtils(
    //           titleState: AppStrings.anotherDevice,
    //           lottieType: AppStateRenderEnum.failed,
    //           onPressed: () {
    //             _checkBluetooth();
    //           },
    //         );
    //
    //       // Default
    //       default:
    //         return AppStateRenderUtils(
    //           titleState: AppStrings.noDevice,
    //           lottieType: AppStateRenderEnum.failed,
    //           onPressed: () {
    //             _checkBluetooth();
    //           },
    //         );
    //     }
    //   },
    // );
  }
}
