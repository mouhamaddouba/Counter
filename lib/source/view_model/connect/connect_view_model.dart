// ignore_for_file: unnecessary_overrides
import 'package:counter/source/core/utils/app_permission_utils.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class ConnectViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  ///region params
  RxBool isSearching = false.obs;

  late AnimationController animationController;
  late Animation<double> animation;

  Animation<double> get animationFloat => animation;

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
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    return super.onDelete;
  }

  ///endregion Lifecycle

  ///region Public functions
  ///
  ///
  /// Animate float button by scale
  void animateFloatButton() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );

    final Animation<double> curve = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animation = Tween(begin: 0.9, end: 1.1).animate(curve);

    animationController.repeat(
      reverse: true,
    );
  }

  /// Scan bluetooth connect
  Future<void> scanBluetoothDevices(BuildContext context) async {
    bool check = await AppPermissionUtils().checkAll(
      () {
        scanBluetoothDevices(context);
      },
      context,
    );
    if (check) {
      await FlutterBluePlus.stopScan();

      isSearching.value = true;

      FlutterBluePlus.startScan(
        timeout: const Duration(
          seconds: AppConstants.duration15,
        ),
      ).asStream().listen((event) {});
      stopScanTimer();
    }
  }

  /// Scan stop timer
  Future<void> stopScanTimer() async {
    if (isSearching.value) {
      await Future.delayed(
        const Duration(
          seconds: AppConstants.duration15,
        ),
      );

      await FlutterBluePlus.stopScan();
      isSearching.value = false;
    }
  }

  ///

  ///endregion Public functions
}
