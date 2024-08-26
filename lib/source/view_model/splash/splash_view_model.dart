// ignore_for_file: unnecessary_overrides
import 'dart:async';

import 'package:counter/source/core/routes/app_routes.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController scaleController;
  late Animation<double> scaleAnimation;

  ///region Constructors
  SplashViewModel();

  ///region Lifecycle
  @override
  InternalFinalCallback<void> get onStart {
    return super.onStart;
  }

  @override
  void onInit() {
    super.onInit();
    animatedSplash();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scaleController.dispose();
    super.onClose();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    return super.onDelete;
  }

  ///endregion Lifecycle

  ///region Public functions
  void animatedSplash() {
    scaleController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: AppConstants.duration600,
      ),
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            Get.offAllNamed(
              AppRoutes.connect,
            );

            Timer(
              const Duration(
                milliseconds: AppConstants.duration300,
              ),
              () {
                scaleController.reset();
              },
            );
          }
        },
      );

    scaleAnimation = Tween<double>(
      begin: AppConstants.tween00,
      end: AppConstants.tween12,
    ).animate(scaleController);

    Timer(
      const Duration(
        seconds: AppConstants.duration02,
      ),
      () {
        scaleController.forward();
      },
    );
  }

  ///endregion Public functions
}
