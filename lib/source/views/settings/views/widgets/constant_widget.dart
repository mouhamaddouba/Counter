import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConstantWidget extends GetView<SettingsViewModel> {
  final String title;
  final int value;

  const ConstantWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Title
        AppTextWidget(
          title,
          textColor: AppColors.black01,
          fontSize: AppDimensions.fontSize12,
        ),

        /// Space
        const SizedBox(
          width: AppDimensions.paddingOrMargin16,
        ),

        /// Value
        AppTextWidget(
          value.toString(),
          textColor: AppColors.primary400,
          fontWeight: FontWeight.bold,
          fontSize: AppDimensions.fontSize12,
        ),
      ],
    );
  }
}
