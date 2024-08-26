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

class SettingsPiecesSizeView extends GetView<SettingsViewModel> {
  const SettingsPiecesSizeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppDimensions.paddingOrMargin14,
        bottom: AppDimensions.paddingOrMargin14,
        end: AppDimensions.paddingOrMargin14,
        start: AppDimensions.paddingOrMargin14,
      ),
      child: Obx(
        () {
          return Row(
            children: [
              //select Pieces size
              Expanded(
                child: CustomDropdown(
                  hintText: AppStrings.piecesSize.t(),
                  items: AppConstants.piecesSizeItems,
                  controller: controller.piecesSizeController,
                  onChanged: (dateGroup) =>
                      controller.replaceBetweenDropDown(dateGroup),
                ),
              ),

              // pieces custom
              Visibility(
                visible: controller.isCustom.value,
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: AppDimensions.paddingOrMargin20,
                    ),
                    child: AppTextFieldWidget(
                      verticalPadding: AppDimensions.paddingOrMargin14,
                      backgroundColor: AppColors.background,
                      hintText: AppStrings.custom.t(),
                      textColor: AppColors.gray03,
                      fontSize: AppDimensions.fontSize10,
                    ),
                  ),
                ),
              ),

              // pieces auto
              Visibility(
                visible: controller.isAuto.value,
                child: Expanded(
                  child: CustomDropdown(
                    hintText: AppStrings.auto.t(),
                    items: AppConstants.piecesAutoItems,
                    controller: controller.piecesAutoController,
                    onChanged: (piecesAuto) {},
                  ),
                ),
              ),

              // pieces manual
              Visibility(
                visible: controller.isManual.value,
                child: Expanded(
                  child: CustomDropdown(
                    isEnable: false,
                    hintText: AppStrings.manual.t(),
                    items: AppConstants.piecesAutoItems,
                    controller: controller.piecesAutoController,
                    onChanged: (piecesAuto) {},
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
