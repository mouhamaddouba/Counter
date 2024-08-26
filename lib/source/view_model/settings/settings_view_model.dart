// ignore_for_file: unnecessary_overrides
import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsViewModel extends GetxController {
  bool isChecked = true;
  RxBool isCustom = false.obs;
  RxBool isAuto = false.obs;
  RxBool isManual = false.obs;
  final TextEditingController piecesSizeController = TextEditingController();
  final TextEditingController piecesAutoController = TextEditingController();

  ///region Constructors
  SettingsViewModel();

  ///region Lifecycle
  @override
  InternalFinalCallback<void> get onStart {
    return super.onStart;
  }

  @override
  void onInit() {
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

  /// Replace between dropdown
  void replaceBetweenDropDown(String dateGroup) {
    if (dateGroup == AppStrings.custom.t()) {
      isCustom.value = true;
      isAuto.value = false;
      isManual.value = false;
    } else if (dateGroup == AppStrings.auto.t()) {
      isCustom.value = false;
      isAuto.value = true;
      isManual.value = false;
    } else {
      isCustom.value = false;
      isAuto.value = false;
      isManual.value = true;
    }
  }

  ///endregion Public functions
}
