import 'package:counter/source/core/animation/animation_transactions.dart';
import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_button_widget.dart';
import 'package:counter/source/core/global_widgets/app_icon_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContentBottomSheetView extends GetView<HomeViewModel> {
  const HomeContentBottomSheetView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingOrMargin8,
        bottom: AppDimensions.paddingOrMargin8,
      ),
      child: AnimationTransaction(
        alignmentGeometry: Alignment.bottomCenter,
        delayStart: const Duration(
          milliseconds: AppConstants.duration500,
        ),
        animationDuration: const Duration(
          milliseconds: AppConstants.duration1000,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            /// Run All
            AppButtonWidget(
              isBordered: true,
              text: AppStrings.runAll.t(),
              color: AppColors.successLight,
              width: AppDimensions.width120,
              height: AppDimensions.height50,
              onPressed: () {},
            ),

            /// Generate Report
            AppButtonWidget(
              isBordered: true,
              color: AppColors.primary,
              width: AppDimensions.width180,
              height: AppDimensions.height50,
              text: AppStrings.generateReport.t(),
              onPressed: () {},
            ),

            /// New Operation
            AppButtonWidget(
              isBordered: true,
              color: AppColors.primary,
              width: AppDimensions.width200,
              height: AppDimensions.height50,
              text: AppStrings.newOperation.t(),
              afterTextIcon: const AppIconWidget(
                iconData: Icons.add,
                color: AppColors.primary,
              ),
              onPressed: () => controller.addNewOperation(context),
            ),

            /// Counters
            AppButtonWidget(
              isBordered: true,
              color: AppColors.primary,
              text: AppStrings.counters.t(),
              width: AppDimensions.width120,
              height: AppDimensions.height50,
              onPressed: () {},
            ),

            /// Reset All
            AppButtonWidget(
              isBordered: true,
              color: AppColors.errorLight,
              text: AppStrings.resetAll.t(),
              width: AppDimensions.width120,
              height: AppDimensions.height50,
              onPressed: () => controller.resetCounters(context),
            ),
          ],
        ),
      ),
    );
  }
}
