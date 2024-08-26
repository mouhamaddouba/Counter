import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_button_widget.dart';
import 'package:counter/source/core/routes/app_routes.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsButtonsView extends GetView<SettingsViewModel> {
  const SettingsButtonsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppDimensions.height80,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingOrMargin16,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            /// Save
            AppButtonWidget(
              text: AppStrings.save.t(),
              onPressed: () => Get.offAllNamed(AppRoutes.home),
              color: AppColors.successLight,
              width: AppDimensions.width100,
              isBordered: true,
            ),

            /// Space
            const SizedBox(
              width: AppDimensions.paddingOrMargin16,
            ),

            /// Reset
            AppButtonWidget(
              text: AppStrings.reset.t(),
              onPressed: () {},
              color: AppColors.errorLight,
              width: AppDimensions.width100,
              isBordered: true,
            ),
          ],
        ),
      ),
    );
  }
}
