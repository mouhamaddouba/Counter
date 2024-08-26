import 'package:clay_containers/clay_containers.dart';
import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/core/values/enums/app_status_enum.dart';
import 'package:counter/source/core/values/enums/position_border_enum.dart';
import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:counter/source/views/home/widgets/table_border_widget.dart';
import 'package:counter/source/views/home/widgets/table_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomeContentBodyView extends GetView<HomeViewModel> {
  const HomeContentBodyView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppStatusEnum>(
      stream: controller.appConnectServices.outDashboardState,
      builder: (context, snapshot) {
        return Padding(
          padding: const EdgeInsets.all(
            AppDimensions.paddingOrMargin10,
          ),
          child: StaggeredGrid.count(
            crossAxisCount: AppConstants.cross40,
            mainAxisSpacing: AppDimensions.zero,
            crossAxisSpacing: AppDimensions.zero,
            children: [
              /// First row from 5 to 1
              StaggeredGridTile.count(
                crossAxisCellCount: AppConstants.cross20,
                mainAxisCellCount: AppConstants.cross04,
                child: TableBorderWidget(
                  isCorner: true,
                  title: AppStrings.ur.t(),
                  nodePosition: const [NodePosition.bottom],
                  child: const TableCounterWidget(
                    color: AppColors.successLight,
                    alignmentFiveItems: Alignment.centerLeft,
                  ),
                ),
              ),

              /// First row from 1 to 5
              StaggeredGridTile.count(
                crossAxisCellCount: AppConstants.cross20,
                mainAxisCellCount: AppConstants.cross04,
                child: TableBorderWidget(
                  isCorner: true,
                  title: AppStrings.ul.t(),
                  nodePosition: const [NodePosition.bottom],
                  position: Position.topRight,
                  child: const TableCounterWidget(
                    isRight: false,
                    color: AppColors.errorLight,
                    alignmentFiveItems: Alignment.centerRight,
                  ),
                ),
              ),

              /// Second row 7 + 6
              const StaggeredGridTile.count(
                crossAxisCellCount: AppConstants.cross14,
                mainAxisCellCount: AppConstants.cross3_8,
                child: TableBorderWidget(
                  nodePosition: [
                    NodePosition.top,
                    NodePosition.right,
                  ],
                  child: TableCounterWidget(
                    isFiveItems: false,
                    color: AppColors.successLight,
                    alignmentThreeItems: Alignment.centerLeft,
                  ),
                ),
              ),

              /// IOS Random Text
              StaggeredGridTile.count(
                crossAxisCellCount: AppConstants.cross12,
                mainAxisCellCount: AppConstants.cross7_8,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Center(
                    child: ClayText(
                      emboss: true,
                      AppStrings.ios.t(),
                      depth: AppConstants.cross40,
                      size: AppDimensions.width100,
                      textColor: AppColors.primary400,
                      parentColor: AppColors.primary50,
                    ),
                  ),
                ),
              ),

              /// Second row from 6 + 7
              const StaggeredGridTile.count(
                crossAxisCellCount: AppConstants.cross14,
                mainAxisCellCount: AppConstants.cross3_8,
                child: TableBorderWidget(
                  nodePosition: [
                    NodePosition.top,
                    NodePosition.left,
                  ],
                  child: TableCounterWidget(
                    isRight: false,
                    isFiveItems: false,
                    color: AppColors.errorLight,
                    alignmentThreeItems: Alignment.centerRight,
                  ),
                ),
              ),

              /// Third row 7 + 6
              const StaggeredGridTile.count(
                crossAxisCellCount: AppConstants.cross14,
                mainAxisCellCount: AppConstants.cross04,
                child: TableBorderWidget(
                  nodePosition: [
                    NodePosition.bottom,
                    NodePosition.right,
                  ],
                  child: TableCounterWidget(
                    isFiveItems: false,
                    color: AppColors.warningLight,
                    alignmentThreeItems: Alignment.centerLeft,
                    paddingRightTop: AppDimensions.paddingOrMargin8,
                  ),
                ),
              ),

              /// Third row 7 + 6
              const StaggeredGridTile.count(
                crossAxisCellCount: AppConstants.cross14,
                mainAxisCellCount: AppConstants.cross04,
                child: TableBorderWidget(
                  nodePosition: [
                    NodePosition.bottom,
                    NodePosition.left,
                  ],
                  child: TableCounterWidget(
                    isRight: false,
                    isFiveItems: false,
                    color: AppColors.gray03,
                    paddingLeftBottom: AppDimensions.zero,
                    alignmentThreeItems: Alignment.centerRight,
                    paddingLeftTop: AppDimensions.paddingOrMargin8,
                  ),
                ),
              ),

              /// End Row from 5 to 1
              StaggeredGridTile.count(
                crossAxisCellCount: AppConstants.cross20,
                mainAxisCellCount: AppConstants.cross04,
                child: TableBorderWidget(
                  isCorner: true,
                  title: AppStrings.lr.t(),
                  position: Position.bottomLeft,
                  transform: AppConstants.transform18,
                  nodePosition: const [
                    NodePosition.top,
                  ],
                  child: const TableCounterWidget(
                    color: AppColors.warningLight,
                    paddingFiveBottom: AppDimensions.zero,
                    alignmentFiveItems: Alignment.centerLeft,
                    paddingFiveTop: AppDimensions.paddingOrMargin8,
                    paddingBottom: AppDimensions.paddingOrMargin10,
                  ),
                ),
              ),

              /// End Row from 1 to 5
              StaggeredGridTile.count(
                crossAxisCellCount: AppConstants.cross20,
                mainAxisCellCount: AppConstants.cross04,
                child: TableBorderWidget(
                  isCorner: true,
                  title: AppStrings.ll.t(),
                  position: Position.bottomRight,
                  transform: AppConstants.transform18,
                  nodePosition: const [
                    NodePosition.top,
                  ],
                  child: const TableCounterWidget(
                    isRight: false,
                    color: AppColors.gray03,
                    paddingFiveBottom: AppDimensions.zero,
                    alignmentFiveItems: Alignment.centerRight,
                    paddingFiveTop: AppDimensions.paddingOrMargin8,
                    paddingBottom: AppDimensions.paddingOrMargin10,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
