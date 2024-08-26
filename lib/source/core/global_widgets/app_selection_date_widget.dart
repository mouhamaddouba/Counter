import 'package:counter/source/core/extensions/click_to_able_extensions.dart';
import 'package:counter/source/core/global_widgets/app_icon_widget.dart';
import 'package:counter/source/core/global_widgets/app_number_picker_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/utils/app_alert_utils.dart';
import 'package:counter/source/core/utils/app_date_formatter.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppSelectionDateWidget<T> extends StatelessWidget {
  final String title;
  final String? value;
  final ValueChanged<DateTime> onChanged;
  final DateFormatter dateFormatter = DateFormatter.instance;
  final double width;

  late DateTime date;

  AppSelectionDateWidget({
    required this.title,
    required this.value,
    required this.onChanged,
    this.width = AppDimensions.width290,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: AppDimensions.paddingOrMargin16,
        // vertical: AppDimensions.paddingOrMargin10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppTextWidget(
            title,
            textColor: AppColors.black01,
            fontSize: AppDimensions.fontSize10,
          ),
          const SizedBox(
            width: AppDimensions.paddingOrMargin20,
          ),
          Container(
            width: width,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.gray02,
                width: AppConstants.border1_2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  AppDimensions.paddingOrMargin12,
                ),
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingOrMargin16,
              vertical: AppDimensions.paddingOrMargin8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppTextWidget(
                  value!,
                  textColor: AppColors.gray03,
                  fontSize: AppDimensions.fontSize10,
                ),
                const AppIconWidget(
                  iconData: Icons.keyboard_arrow_down,
                  color: AppColors.gray03,
                ),
              ],
            ),
          ).onTap(
            () {
              AppAlertUtils.showDialog(
                context: context,
                isNewBody: false,
                textConfirm: AppStrings.save.tr(),
                bodyContent: const AppNumberPickerWidget(
                  minutes: 00,
                  seconds: 00,
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
