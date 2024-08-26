import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/core/values/enums/position_border_enum.dart';
import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:counter/source/views/home/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableCounterWidget extends GetView<HomeViewModel> {
  final Color color;
  final bool isRight;
  final double transform;
  final bool isFiveItems;
  final Position position;
  final double paddingBottom;
  final double paddingLeftTop;
  final double paddingFiveTop;
  final double paddingRightTop;
  final double paddingLeftBottom;
  final double paddingFiveBottom;
  final double paddingRightBottom;
  final List<NodePosition> nodePosition;
  final AlignmentGeometry alignmentFiveItems;
  final AlignmentGeometry alignmentThreeItems;

  const TableCounterWidget({
    super.key,
    this.color = AppColors.primary,
    this.position = Position.topLeft,
    this.nodePosition = const [NodePosition.non],
    this.transform = -AppConstants.transform12,
    this.isFiveItems = true,
    this.isRight = true,
    this.paddingBottom = AppDimensions.zero,
    this.paddingRightTop = AppDimensions.zero,
    this.paddingRightBottom = AppDimensions.zero,
    this.paddingLeftTop = AppDimensions.zero,
    this.paddingLeftBottom = AppDimensions.zero,
    this.paddingFiveTop = AppDimensions.paddingOrMargin8,
    this.paddingFiveBottom = AppDimensions.paddingOrMargin8,
    this.alignmentFiveItems = Alignment.center,
    this.alignmentThreeItems = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: AppDimensions.paddingOrMargin8,
        left: AppDimensions.paddingOrMargin8,
        // top: AppDimensions.paddingOrMargin4,
      ),
      child: isFiveItems

          /// Row contain 5 items in row
          ? Padding(
              padding: EdgeInsets.only(
                bottom: paddingBottom,
              ),
              child: Align(
                alignment: alignmentFiveItems,
                child: SingleChildScrollView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: paddingFiveTop,
                      bottom: paddingFiveBottom,
                    ),
                    child: Row(
                      children: [
                        /// Items start from 5 to 1
                        if (isRight == true)
                          for (int index = 5; index >= 1; index--)
                            CounterWidget(
                              index: index,
                              color: color,
                            ),

                        /// Items start from 1 to 5
                        if (isRight == false)
                          for (int index = 1; index <= 5; index++)
                            CounterWidget(
                              index: index,
                              color: color,
                            ),
                      ],
                    ),
                  ),
                ),
              ),
            )

          /// Row contain 2 items in row
          : Align(
              alignment: alignmentThreeItems,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.paddingOrMargin8,
                  ),
                  child: Row(
                    children: [
                      /// Row from 2 items 7 then 6
                      if (isRight == true)
                        Padding(
                          padding: EdgeInsets.only(
                            top: paddingRightTop,
                            bottom: paddingRightBottom,
                          ),
                          child: Row(
                            children: [
                              CounterWidget(
                                index: AppConstants.index07,
                                color: color,
                              ),
                              CounterWidget(
                                index: AppConstants.index06,
                                width: AppDimensions.width01,
                                widthMax: AppDimensions.width160,
                                color: color,
                              ),
                            ],
                          ),
                        ),

                      /// Row from 2 items 6 then 7
                      if (isRight == false)
                        Padding(
                          padding: EdgeInsets.only(
                            top: paddingLeftTop,
                            bottom: paddingLeftBottom,
                          ),
                          child: Row(
                            children: [
                              CounterWidget(
                                width: AppDimensions.width01,
                                widthMax: AppDimensions.width160,
                                index: AppConstants.index06,
                                color: color,
                              ),
                              CounterWidget(
                                index: AppConstants.index07,
                                color: color,
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
