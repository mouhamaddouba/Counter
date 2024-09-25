import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_icon_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/view_model/connect/connect_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectFloatingButtonView extends GetView<ConnectViewModel> {
  const ConnectFloatingButtonView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: controller.animation,
      child: Obx(
        () {
          return FloatingActionButton(
            tooltip: AppStrings.reSearch.t(),
            backgroundColor: controller.appConnectServices.isSearching.value
                ? AppColors.gray03
                : AppColors.primary,
            onPressed: controller.appConnectServices.isSearching.value
                ? null
                : () {
                    controller.appConnectServices.scanBluetoothDevices();
                  },
            child: const AppIconWidget(
              iconData: Icons.search_rounded,
              color: AppColors.white01,
            ),
          );
        },
      ),
    );
  }
}
