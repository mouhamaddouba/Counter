import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_selection_date_widget.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/settings/settings_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsGateView extends GetView<SettingsViewModel> {
  const SettingsGateView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        top: AppDimensions.paddingOrMargin14,
        bottom: AppDimensions.paddingOrMargin14,
        end: AppDimensions.paddingOrMargin16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Delay To Open
          AppSelectionDateWidget(
            width: AppDimensions.width100,
            title: AppStrings.delayToOpen.t(),
            value: '3',
            onChanged: (value) {},
          ),

          // Delay To Close
          AppSelectionDateWidget(
            width: AppDimensions.width100,
            title: AppStrings.delayToClose.t(),
            value: '1',
            onChanged: (value) {},
          ),

          // Delay To Begin New Kit
          AppSelectionDateWidget(
            width: AppDimensions.width100,
            title: AppStrings.delayToBeginNewKit.t(),
            value: '5',
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }
}
