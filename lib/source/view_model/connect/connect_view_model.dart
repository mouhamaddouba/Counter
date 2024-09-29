import 'dart:async';

import 'package:counter/source/core/routes/app_routes.dart';
import 'package:counter/source/core/services/bluetooth/app_connect_services.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

import '../../core/values/enums/app_enum.dart';

class ConnectViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  ///region params

  late AnimationController animationController;
  late Animation<double> animation;
  Animation<double> get animationFloat => animation;

  RxBool isSearching = false.obs;
  final AppConnectServices appConnectServices = AppConnectServices();
  final RxBool isTryToConnectToAnotherDevice = false.obs;
  RxBool isTryToConnect = false.obs;
  BluetoothDevice? newDevice;
  StreamSubscription<BluetoothStatusEnum>? readStreamSubscription;

  ///region Constructors
  ConnectViewModel({
    AnimationController? animationController,
    Animation<double>? animation,
  });

  ///region Lifecycle
  @override
  InternalFinalCallback<void> get onStart {
    return super.onStart;
  }

  @override
  void onInit() {
    animateFloatButton();
    initReadStreamSubscription();

    super.onInit();
  }

  @override
  void onClose() {
    readStreamSubscription?.cancel();
    FlutterBluePlus.stopScan();
    super.onClose();
  }

  ///endregion Lifecycle

  ///region Public functions

  /// Animate float button by scale
  void animateFloatButton() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: AppConstants.duration500,
      ),
    );

    final Animation<double> curve = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animation = Tween(
      begin: AppConstants.tween0_9,
      end: AppConstants.tween1_1,
    ).animate(curve);

    animationController.repeat(
      reverse: true,
    );
  }

  /// Init read stream
  void initReadStreamSubscription() {
    readStreamSubscription =
        appConnectServices.outBluetoothState.listen((bluetoothState) {
      /// IF connect stop scan and access to connect with another device
      if (bluetoothState == BluetoothStatusEnum.connecting) {
        isTryToConnectToAnotherDevice.value = true;
        appConnectServices.isSearching.value = true;
      }

      /// If connect failed show snackBar to show failed
      if (bluetoothState == BluetoothStatusEnum.failedToConnect) {
        Get.closeCurrentSnackbar();
        Get.snackbar(
          AppConstants.emptyText,
          AppStrings.failedToConnect.tr,
          duration: const Duration(
            milliseconds: AppConstants.duration2000,
          ),
          backgroundColor: AppColors.primary,
          colorText: AppColors.white01,
        );
      }

      /// If connect done move to home feature
      else if (bluetoothState == BluetoothStatusEnum.connected) {
        Get.offAllNamed(
          AppRoutes.home,
        );
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      appConnectServices.scanStream();
    });
  }

  /// Connect with device
  Future<void> connectWithDevice(BluetoothDevice device) async {
    isTryToConnect.value = true;
    if (!isTryToConnectToAnotherDevice.value) {
      isTryToConnectToAnotherDevice.value = true;
      try {
        await appConnectServices.connectWithDevice(
          deviceToConnect: device,
        );

        isTryToConnect.value = false;
      } catch (e) {
        if (e != 'already_connected') {
          if (kDebugMode) {
            print('already_connected');
          }
          rethrow;
        }
      } finally {
        WidgetsBinding.instance.addPostFrameCallback((_) {});
      }
    }
  }

  ///endregion Public functions
}
