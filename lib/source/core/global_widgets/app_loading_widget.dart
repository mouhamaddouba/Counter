import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimentions.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoadingWidget extends StatelessWidget {
  // Page content
  final Widget? content;
  final Color overlayColor;
  final double overlayColorOpacity;
  final bool isLoading;
  final String titleText;
  final String descriptionText;
  final Color textColor;
  final Color spinColor;
  final double fontSize;
  final double height;

  const AppLoadingWidget({
    super.key,
    this.content,
    this.overlayColor = AppColors.black00,
    this.overlayColorOpacity = AppConstants.appLoadingOpacity,
    this.isLoading = true,
    this.titleText = AppConstants.emptyText,
    this.descriptionText = AppConstants.emptyText,
    this.textColor = AppColors.white01,
    this.spinColor = AppColors.white01,
    this.fontSize = AppDimensions.fontSize18,
    this.height = AppDimensions.height200,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Stack(
        children: [
          // Page content
          content ?? const SizedBox.shrink(),

          // Overlay
          isLoading
              ? SpinKitSpinningLines(
                  color: Theme.of(context).primaryColor,
                  size: AppDimensions.paddingOrMargin70,
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
