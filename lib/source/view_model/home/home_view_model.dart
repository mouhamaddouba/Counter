// ignore_for_file: unnecessary_overrides
import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/services/app_connect_services.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/utils/app_alert_utils.dart';
import 'package:counter/source/core/utils/app_bluetooth_utils.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/enums/dialog_type_enum.dart';
import 'package:counter/source/views/home/widgets/form_operation_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  ///region params
  final AppConnectServices appConnectServices = AppConnectServices();
  final ScrollController scrollController = ScrollController();
  RxBool showForm = false.obs;

  RxBool switchValue = false.obs;

  ///region Constructors
  HomeViewModel();

  ///region Lifecycle
  @override
  InternalFinalCallback<void> get onStart {
    return super.onStart;
  }

  @override
  void onInit() {
    super.onInit();

    animateAppBar();
    hideCounters();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    appConnectServices.dispose();
    super.onClose();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    return super.onDelete;
  }

  ///endregion Lifecycle

  ///region Public functions

  /// Function to check if bluetooth on
  Future<void> checkBluetooth(BuildContext context) async {
    bool check = await AppBluetoothUtils().checkBluetooth(
      checkBluetooth,
      context,
    );
    if (check) {
      appConnectServices.reconnect();
    }
  }

  /// Make animate for appBar if he need scroll
  void animateAppBar() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(
            seconds: AppConstants.duration02,
          ),
          curve: Curves.ease,
        );
      },
    );
  }

  /// Hide Counters until finish from scroll appBar and show Buttons
  void hideCounters() {
    Future.delayed(
      const Duration(
        milliseconds: AppConstants.duration600,
      ),
      () async {
        showForm.value = true;
      },
    );
  }

  /// Show dialog to reset all counters
  void resetCounters(BuildContext context) {
    AppAlertUtils.showDialog(
      isNewBody: true,
      context: context,
      onCancel: () => Get.back(),
      onConfirm: () => Get.back(),
      title: AppStrings.alertWarning.t(),
      dialogTypeEnum: DialogTypeEnum.warning,
      message: AppStrings.firstResetOperation.t(),
    );
  }

  /// Add new operation
  void addNewOperation(BuildContext context) {
    AppAlertUtils.showDialog(
      isNewBody: false,
      context: context,
      onCancel: () => Get.back(),
      onConfirm: () => Get.back(),
      bodyContent: const FormOperationWidget(),
    );
  }

  ///endregion Public functions
}
