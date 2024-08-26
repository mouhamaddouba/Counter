import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/routes/app_routes.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:counter/source/views/home/widgets/counter_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CounterWidget extends GetView<HomeViewModel> {
  final int index;
  final Color color;
  final double width;
  final double widthMin;
  final double widthMax;

  const CounterWidget({
    super.key,
    this.index = AppDimensions.flexExpand01,
    this.width = AppDimensions.width_09,
    this.widthMin = AppDimensions.width85,
    this.widthMax = AppDimensions.width150,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        Navigator.pushNamed(
          context,
          AppRoutes.settings,
        );
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * width,
        height: MediaQuery.sizeOf(context).height * AppDimensions.width_15,
        constraints: BoxConstraints(
          minWidth: widthMin,
          minHeight: AppDimensions.height100,
          maxWidth: widthMax,
          maxHeight: AppDimensions.height200,
        ),
        child: Card(
          //style card
          color: AppColors.whiteBlue,
          clipBehavior: Clip.hardEdge,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(
                AppDimensions.radius20,
              ),
              topLeft: Radius.circular(
                AppDimensions.radius20,
              ),
            ),
          ),
          child: Row(
            children: [
              // Current Kit
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingOrMargin10,
                  ),
                  child: AppTextWidget(
                    '8',
                    isAutoSized: true,
                    textColor: AppColors.black01,
                  ),
                ),
              ),
              //master & settings
              CounterButtonWidget(
                index: index,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
