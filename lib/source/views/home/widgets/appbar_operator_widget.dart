import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarOperatorWidget extends GetView<HomeViewModel> {
  final String operatorName;
  final String operatorValue;

  const AppBarOperatorWidget({
    super.key,
    required this.operatorName,
    required this.operatorValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppDimensions.paddingOrMargin8,
        horizontal: AppDimensions.paddingOrMargin4,
      ),

      /// Father container
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            AppDimensions.radius25,
          ),
          border: Border.all(
            color: AppColors.primary,
            width: AppDimensions.width02,
          ),
        ),
        child: Row(
          children: [
            /// Container operator name
            Container(
              height: AppDimensions.height35,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    AppDimensions.radius25,
                  ),
                  topLeft: Radius.circular(
                    AppDimensions.radius25,
                  ),
                ),
                color: AppColors.primary400,
                border: Border(
                  right: BorderSide(
                    color: AppColors.primary400,
                    width: AppDimensions.width02,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingOrMargin8,
                ),

                /// Text operator name
                child: Center(
                  child: AppTextWidget(
                    operatorName.t(),
                    fontSize: AppDimensions.fontSize08,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingOrMargin8,
              ),

              /// Text operator value
              child: AppTextWidget(
                operatorValue,
                fontSize: AppDimensions.fontSize08,
                textColor: AppColors.black01,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
