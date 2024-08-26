import 'dart:math';

import 'package:counter/source/core/global_widgets/app_custom_clip_path_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:flutter/material.dart';

class CounterButtonWidget extends StatefulWidget {
  final int index;
  final Color color;

  const CounterButtonWidget({
    this.index = AppConstants.index01,
    required this.color,
    super.key,
  });

  @override
  State<CounterButtonWidget> createState() => _CounterButtonWidgetState();
}

class _CounterButtonWidgetState extends State<CounterButtonWidget> {
  bool switchValue = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        /// Corner Number
        Flexible(
          child: ClipPath(
            clipper: AppCustomClipPathWidget(),
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.065,
              padding: const EdgeInsetsDirectional.only(
                start: AppDimensions.paddingOrMargin20,
                end: AppDimensions.paddingOrMargin10,
                bottom: AppDimensions.paddingOrMargin10,
                // top: 1,
              ),
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.zero,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: AppDimensions.paddingOrMargin2,
                ),
                child: AppTextWidget(
                  widget.index.toString(),
                  fontSize: AppDimensions.fontSize08,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.white01,
                ),
              ),
            ),
          ),
        ),

        /// Switch
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingOrMargin4,
              vertical: AppDimensions.paddingOrMargin6,
            ),
            child: SizedBox(
              width: AppDimensions.width30,
              height: AppDimensions.height30,
              child: FittedBox(
                child: Transform.rotate(
                  angle: pi / AppDimensions.radius02,
                  child: Switch(
                    value: switchValue,
                    onChanged: (value) {
                      setState(() {
                        switchValue = value;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
