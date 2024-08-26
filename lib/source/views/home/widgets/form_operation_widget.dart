import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_icon_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_field_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:flutter/material.dart';

class FormOperationWidget extends StatelessWidget {
  const FormOperationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// ID
          AppTextFieldWidget(
            verticalPadding: AppDimensions.paddingOrMargin14,
            backgroundColor: AppColors.background,
            hintText: AppStrings.id.t(),
            textColor: AppColors.gray03,
            fontSize: AppDimensions.fontSize10,
          ),

          /// SN
          AppTextFieldWidget(
            verticalPadding: AppDimensions.paddingOrMargin14,
            backgroundColor: AppColors.background,
            hintText: AppStrings.sn.t(),
            textColor: AppColors.gray03,
            fontSize: AppDimensions.fontSize10,
          ),

          /// Name
          AppTextFieldWidget(
            verticalPadding: AppDimensions.paddingOrMargin14,
            backgroundColor: AppColors.background,
            hintText: AppStrings.name.t(),
            textColor: AppColors.gray03,
            fontSize: AppDimensions.fontSize10,
          ),

          /// SKU
          AppTextFieldWidget(
            verticalPadding: AppDimensions.paddingOrMargin14,
            backgroundColor: AppColors.background,
            hintText: AppStrings.sku.t(),
            textColor: AppColors.gray03,
            fontSize: AppDimensions.fontSize10,
          ),

          /// LOT
          AppTextFieldWidget(
            verticalPadding: AppDimensions.paddingOrMargin14,
            backgroundColor: AppColors.background,
            hintText: AppStrings.lot.t(),
            textColor: AppColors.gray03,
            fontSize: AppDimensions.fontSize10,
          ),

          /// Op. Begin Date & Time
          AppTextFieldWidget(
            readOnly: true,
            hintText: AppStrings.beginDate.t(),
            suffixIcon: AppIconWidget(
              iconData: Icons.date_range,
              color: AppColors.gray03,
              onTap: () async {},
            ),
          ),

          /// Op. Begin Date & Time
          AppTextFieldWidget(
            readOnly: true,
            hintText: AppStrings.endDate.t(),
            suffixIcon: AppIconWidget(
              iconData: Icons.date_range,
              color: AppColors.gray03,
              onTap: () async {},
            ),
          ),
        ],
      ),
    );
  }
}
