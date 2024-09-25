import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_loading_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/connect/connect_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectAppBarView extends GetView<ConnectViewModel>
    implements PreferredSizeWidget {
  const ConnectAppBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return AppBar(
          centerTitle: true,
          elevation: AppDimensions.zero,
          backgroundColor: AppColors.primary600,

          /// Loading search
          leading: controller.appConnectServices.isSearching.value
              ? const Center(
                  child: AppLoadingWidget(
                    spinColor: AppColors.white01,
                    spinSize: AppDimensions.paddingOrMargin30,
                  ),
                )
              : const SizedBox.shrink(),

          /// Title App Bar
          title: AppTextWidget(
            AppStrings.bluetoothConnection.t(),
            textColor: AppColors.white01,
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        AppDimensions.height55,
      );
}
