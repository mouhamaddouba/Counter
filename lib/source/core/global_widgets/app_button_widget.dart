import 'package:counter/source/core/global_widgets/app_ripple_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_dimentions.dart';
import 'package:flutter/material.dart';

class AppButtonWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final double? width;
  final double? height;
  final double? radius;
  final Function()? onPressed;
  final Color color;
  final Color textColor;
  final bool isBordered;
  final bool isSelectedBorder;
  final bool disabled;
  final Widget? icon;
  final Widget? afterTextIcon;
  final EdgeInsetsDirectional? padding;

  const AppButtonWidget({
    super.key,
    required this.text,
    this.fontSize = AppDimensions.fontSize12,
    this.width,
    this.height = AppDimensions.height55,
    this.radius = AppDimensions.radius10,
    this.isBordered = false,
    this.isSelectedBorder = false,
    required this.onPressed,
    required this.color,
    this.textColor = AppColors.white01,
    this.disabled = false,
    this.icon,
    this.afterTextIcon,
    this.padding = EdgeInsetsDirectional.zero,
  });

  @override
  Widget build(BuildContext context) {
    return AppRippleWidget(
      onTap: disabled ? () => {} : onPressed,
      child: Ink(
        padding: padding,
        width: width,
        height: height ?? AppDimensions.height40,
        decoration: BoxDecoration(
          border: Border.all(
            color: _getBorderColor(),
            width: AppDimensions.thickness01,
          ),
          color: _getColor(),
          borderRadius: BorderRadius.circular(
            radius ?? AppDimensions.radius10,
          ),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              icon != null ? icon! : const SizedBox.shrink(),

              // Space
              SizedBox(
                width: icon != null
                    ? AppDimensions.paddingOrMargin16
                    : AppDimensions.zero,
              ),

              // Text
              AppTextWidget(
                text,
                textColor: _getTextColor(),
                fontSize: fontSize,
                fontWeight: FontWeight.w700,
              ),

              // Space
              SizedBox(
                width: afterTextIcon != null
                    ? AppDimensions.paddingOrMargin8
                    : AppDimensions.zero,
              ),

              afterTextIcon != null ? afterTextIcon! : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor() {
    if (isBordered) {
      return disabled ? AppColors.onLight300 : textColor;
    }
    return disabled ? AppColors.onLight300 : color;
  }

  Color _getBorderColor() {
    return disabled ? AppColors.gray02 : color;
  }

  Color _getTextColor() {
    if (isBordered) {
      return disabled ? AppColors.onLight300 : color;
    }
    return disabled ? AppColors.onLight300 : textColor;
  }
}
