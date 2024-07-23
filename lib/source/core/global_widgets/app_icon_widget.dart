import 'package:counter/source/core/global_widgets/app_image_widget.dart';
import 'package:counter/source/core/global_widgets/app_ripple_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_dimentions.dart';
import 'package:flutter/material.dart';

class AppIconWidget extends StatelessWidget {
  final IconData? iconData;
  final String? iconPath;
  final Function()? onTap;
  final double size;
  final Color? color;
  final bool ignoreColor;
  final bool withBackground;
  final double backgroundSize;
  final double? backgroundRadius;
  final double? containerRadius;
  final Color backgroundColor;
  final Color? containerColor;
  final double backgroundPadding;

  const AppIconWidget({
    super.key,
    this.iconData,
    this.iconPath,
    this.onTap,
    this.size = AppDimensions.iconSize26,
    this.color = AppColors.whiteBlue,
    this.ignoreColor = false,
    this.withBackground = false,
    this.backgroundSize = AppDimensions.iconSize24,
    this.backgroundRadius,
    this.containerRadius,
    this.containerColor,
    this.backgroundColor = AppColors.gray02,
    this.backgroundPadding = AppDimensions.zero,
  });

  @override
  Widget build(BuildContext context) {
    return AppRippleWidget(
      radius: backgroundRadius ?? backgroundSize,
      onTap: onTap,
      child: withBackground
          ? Container(
              decoration: BoxDecoration(
                //color: containerColor ?? Theme.of(context).primaryColor,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.onPrimary
                    : AppColors.primary,
                borderRadius: BorderRadius.circular(
                  containerRadius ?? AppDimensions.radius10,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray03.withOpacity(0.3),
                    blurRadius: AppDimensions.radius10,
                    offset: const Offset(
                      AppDimensions.zero,
                      AppDimensions.zero,
                    ),
                    spreadRadius: AppDimensions.radius01,
                    blurStyle: BlurStyle.normal,
                  ),
                ],
              ),
              child: Ink(
                width: backgroundSize,
                height: backgroundSize,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      backgroundRadius ?? backgroundSize,
                    ),
                  ),
                ),
                child: _getIconWidget(),
              ),
            )
          : _getIconWidget(),
    );
  }

  Widget _getIconWidget() {
    return iconData != null
        ? Icon(
            iconData,
            size: size,
            color: color,
          )
        : AppImageWidget(
            path: iconPath,
            width: size,
            height: size,
            color: ignoreColor ? null : color,
          );
  }
}
