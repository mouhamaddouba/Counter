import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/core/values/enums/position_border_enum.dart';
import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableBorderWidget extends GetView<HomeViewModel> {
  final Widget child;
  final String title;
  final bool isCorner;
  final bool outOfShape;
  final double transform;
  final Position position;
  final List<NodePosition> nodePosition;

  const TableBorderWidget({
    super.key,
    this.title = '',
    required this.child,
    this.isCorner = false,
    this.outOfShape = false,
    this.position = Position.topLeft,
    this.transform = -AppConstants.transform12,
    this.nodePosition = const [NodePosition.non],
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border(
              left: nodePosition.contains(NodePosition.left)
                  ? BorderSide.none
                  : const BorderSide(
                      color: AppColors.darkGrey,
                      width: AppDimensions.zero,
                    ),
              top: nodePosition.contains(NodePosition.top)
                  ? BorderSide.none
                  : const BorderSide(
                      color: AppColors.darkGrey,
                      width: AppDimensions.zero,
                    ),
              right: nodePosition.contains(NodePosition.right)
                  ? BorderSide.none
                  : const BorderSide(
                      color: AppColors.darkGrey,
                      width: AppDimensions.zero,
                    ),
              bottom: nodePosition.contains(NodePosition.bottom)
                  ? BorderSide.none
                  : const BorderSide(
                      color: AppColors.darkGrey,
                      width: AppDimensions.zero,
                    ),
            ),
            shape: BoxShape.rectangle,
          ),
        ),
        isCorner == false
            ? const SizedBox.shrink()
            : Align(
                alignment: _getAlignment(),
                child: Container(
                  transform: Matrix4.translationValues(
                    _getXTranslation(),
                    transform,
                    AppDimensions.zero,
                  ),
                  padding: const EdgeInsets.only(
                    bottom: AppDimensions.paddingOrMargin10,
                    left: AppDimensions.paddingOrMargin10,
                    right: AppDimensions.paddingOrMargin10,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: FractionalOffset.bottomCenter,
                      end: FractionalOffset.topCenter,
                      stops: outOfShape ? const [0.54, 0.1] : const [1],
                      colors: outOfShape
                          ? [AppColors.background, Colors.white]
                          : [AppColors.background],
                    ),
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: AppDimensions.fontSize10,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ),
        child
      ],
    );
  }

  double _getXTranslation() {
    if (position == Position.topLeft) {
      return AppDimensions.width40;
    } else if (position == Position.topCenter) {
      return AppDimensions.zero;
    } else if (position == Position.bottomLeft) {
      return AppDimensions.width40;
    } else {
      return -AppDimensions.width30;
    }
  }

  _getAlignment() {
    if (position == Position.topLeft) {
      return Alignment.topLeft;
    } else if (position == Position.topCenter) {
      return Alignment.topCenter;
    } else if (position == Position.topRight) {
      return Alignment.topRight;
    } else if (position == Position.bottomLeft) {
      return Alignment.bottomLeft;
    } else if (position == Position.bottomCenter) {
      return Alignment.bottomCenter;
    } else {
      return Alignment.bottomRight;
    }
  }
}
