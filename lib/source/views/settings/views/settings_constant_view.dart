import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/settings/settings_view_model.dart';
import 'package:counter/source/views/settings/views/widgets/constant_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsConstantView extends GetView<SettingsViewModel> {
  const SettingsConstantView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: AppDimensions.paddingOrMargin14,
        horizontal: AppDimensions.paddingOrMargin16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Name counter
          ConstantWidget(
            title: AppStrings.currentNumber.t(),
            value: 10,
          ),

          /// Divider
          const Divider(
            thickness: AppDimensions.thickness_05,
            height: AppDimensions.zero,
          ),

          /// Total Number
          ConstantWidget(
            title: AppStrings.totalNumber.t(),
            value: 20,
          ),

          /// Divider
          const Divider(
            thickness: AppDimensions.thickness_05,
            height: AppDimensions.zero,
            color: AppColors.primary,
          ),

          /// Total Number
          ConstantWidget(
            title: AppStrings.currentKit.t(),
            value: 30,
          ),
        ],
      ),
    );
  }
}
