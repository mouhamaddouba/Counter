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
      child: FloatingActionButton(
        tooltip: AppStrings.reSearch.t(),
        backgroundColor:
            controller.isSearching.value ? AppColors.gray03 : AppColors.primary,
        onPressed: controller.isSearching.value
            ? null
            : () {
                controller.scanBluetoothDevices(context);
              },
        child: const AppIconWidget(
          iconData: Icons.search_rounded,
          color: AppColors.white01,
        ),
      ),
    );
  }
}
