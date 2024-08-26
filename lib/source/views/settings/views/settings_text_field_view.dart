import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_text_field_widget.dart';
import 'package:counter/source/core/global_widgets/custom_drop_down/custom_dropdown.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/settings/settings_view_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsTextFieldView extends GetView<SettingsViewModel> {
  const SettingsTextFieldView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController gateSettingsController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppDimensions.paddingOrMargin16,
        bottom: AppDimensions.paddingOrMargin16,
        start: AppDimensions.paddingOrMargin16,
        end: AppDimensions.paddingOrMargin16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Pieces In Each Kit
          Expanded(
            child: AppTextFieldWidget(
              verticalPadding: AppDimensions.paddingOrMargin14,
              backgroundColor: AppColors.background,
              hintText: AppStrings.piecesInEachKit.t(),
              textColor: AppColors.gray03,
              fontSize: AppDimensions.fontSize10,
            ),
          ),

          /// Space
          const SizedBox(
            width: AppDimensions.paddingOrMargin30,
          ),

          /// Kit Quantity
          Expanded(
            child: AppTextFieldWidget(
              verticalPadding: AppDimensions.paddingOrMargin14,
              backgroundColor: AppColors.background,
              hintText: AppStrings.kitQuantity.t(),
              textColor: AppColors.gray03,
              fontSize: AppDimensions.fontSize10,
            ),
          ),

          /// Space
          const SizedBox(
            width: AppDimensions.paddingOrMargin30,
          ),

          /// Gate Settings
          Expanded(
            child: CustomDropdown(
              hintText: AppStrings.gateSettings.t(),
              items: AppConstants.gateSettingsItems,
              controller: gateSettingsController,
              onChanged: (dateGroup) {},
            ),
          ),
        ],
      ),
    );
  }
}
