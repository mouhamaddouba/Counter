import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/settings/settings_view_model.dart';
import 'package:counter/source/views/settings/views/settings_constant_view.dart';
import 'package:counter/source/views/settings/views/settings_gate_view.dart';
import 'package:counter/source/views/settings/views/settings_pieces_size_view.dart';
import 'package:counter/source/views/settings/views/settings_text_field_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsView extends GetView<SettingsViewModel> {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          /// Content settings
          Padding(
            padding: const EdgeInsets.all(
              AppDimensions.paddingOrMargin16,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white01,
                borderRadius: BorderRadius.circular(
                  AppDimensions.radius10,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray03.withOpacity(0.3),
                    blurRadius: AppDimensions.radius08,
                    offset: Offset.zero,
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingOrMargin16,
                  vertical: AppDimensions.paddingOrMargin8,
                ),
                child: Column(
                  children: [
                    /// Constant
                    SettingsConstantView(),

                    /// Divider
                    Divider(
                      thickness: AppDimensions.thickness_05,
                      height: AppDimensions.zero,
                      color: AppColors.gray03,
                    ),

                    /// Text Field
                    SettingsTextFieldView(),

                    /// Divider
                    Divider(
                      thickness: AppDimensions.thickness_05,
                      height: AppDimensions.zero,
                      color: AppColors.gray03,
                    ),

                    /// Gate settings
                    SettingsGateView(),

                    /// Divider
                    Divider(
                      thickness: AppDimensions.thickness_05,
                      height: AppDimensions.zero,
                      color: AppColors.gray03,
                    ),

                    /// Pieces Size
                    SettingsPiecesSizeView(),
                  ],
                ),
              ),
            ),
          ),

          /// Check settings
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingOrMargin16,
            ),
            child: Row(
              children: [
                // checkBox
                Checkbox(
                  value: controller.isChecked,
                  onChanged: (value) {},
                ),

                /// Space
                const SizedBox(
                  width: AppDimensions.paddingOrMargin8,
                ),

                // text checkBox
                AppTextWidget(
                  AppStrings.applySettings.t(),
                  textColor: AppColors.black01,
                  fontSize: AppDimensions.fontSize10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
