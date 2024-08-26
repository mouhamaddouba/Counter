import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AppNumberPickerWidget extends StatefulWidget {
  final int seconds;
  final int minutes;

  const AppNumberPickerWidget({
    super.key,
    required this.seconds,
    required this.minutes,
  });

  @override
  State<AppNumberPickerWidget> createState() => __AppNumberPickerWidgetState();
}

class __AppNumberPickerWidgetState extends State<AppNumberPickerWidget> {
  int _currentMinutesValue = 60;

  @override
  void initState() {
    super.initState();

    _currentMinutesValue = widget.minutes;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Space
        const SizedBox(
          height: AppDimensions.paddingOrMargin16,
        ),

        // Text
        AppTextWidget(
          AppStrings.seconds.tr(),
          textColor: AppColors.warningLight,
          fontSize: AppDimensions.fontSize12,
        ),

        NumberPicker(
          value: _currentMinutesValue,
          minValue: 0,
          maxValue: 10,
          step: 1,
          itemHeight: 80,
          itemWidth: 65,
          infiniteLoop: true,
          selectedTextStyle: const TextStyle(
            color: AppColors.primary,
            fontSize: AppDimensions.fontSize14,
          ),
          textStyle: const TextStyle(
            fontSize: AppDimensions.fontSize14,
          ),
          onChanged: (value) => setState(() {
            _currentMinutesValue = value;
          }),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimensions.radius15,
            ),
            border: Border.all(
              color: AppColors.black01,
            ),
          ),
        ),
      ],
    );
  }
}
