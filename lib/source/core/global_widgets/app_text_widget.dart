import 'package:auto_size_text/auto_size_text.dart';
import 'package:counter/source/core/global_widgets/app_ripple_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/core/values/constant/app_fonts.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AppTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? textColor;
  final double fontSize;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final TextAlign? textAlign;
  final List<AppTextWidget>? children;
  final Function()? onTap;
  final void Function()? onLongTap;
  final bool? isUnderlineShown;
  final bool? isInlineShown;
  final int? maxLines;
  final double? height;
  final TextDirection? textDirection;
  final TextStyle? childrenTextStyle;
  final bool applyChildrenTextStyle;
  final Color backgroundColor;
  final bool withBackground;
  final bool isCircularBackground;
  final double backgroundRadius;
  final double? backgroundHorizontalPadding;
  final double? backgroundVerticalPadding;
  final Widget? prefix;
  final Widget? suffix;
  final void Function()? onWidgetTap;
  final bool isCenterVertical;

  final bool isAutoSized;

  const AppTextWidget(
    this.text, {
    super.key,
    this.textStyle,
    this.textColor = AppColors.gray01,
    this.fontSize = AppDimensions.fontSize16,
    this.fontWeight = FontWeight.w400,
    this.letterSpacing = 0.0125,
    this.textAlign,
    this.children,
    this.isUnderlineShown,
    this.isInlineShown,
    this.onTap,
    this.maxLines,
    this.textDirection,
    this.height,
    this.childrenTextStyle,
    this.applyChildrenTextStyle = false,
    this.backgroundColor = AppColors.primary,
    this.withBackground = false,
    this.isCircularBackground = false,
    this.backgroundRadius = AppDimensions.radius50,
    this.backgroundHorizontalPadding,
    this.backgroundVerticalPadding,
    this.prefix,
    this.suffix,
    this.onWidgetTap,
    this.onLongTap,
    this.isCenterVertical = false,
    this.isAutoSized = false,
  });

  @override
  Widget build(BuildContext context) {
    final isHeightFixed = maxLines != null && maxLines! > 1 || maxLines == null;

    return withBackground
        ? AppRippleWidget(
            radius: backgroundRadius,
            onTap: onWidgetTap,
            child: Ink(
              height: isHeightFixed ? null : height,
              padding: EdgeInsets.symmetric(
                horizontal: backgroundHorizontalPadding ??
                    AppDimensions.paddingOrMargin12,
                vertical: backgroundVerticalPadding ??
                    (isHeightFixed
                        ? AppDimensions.paddingOrMargin10
                        : AppDimensions.zero),
              ),
              decoration: BoxDecoration(
                color: backgroundColor,
                shape:
                    isCircularBackground ? BoxShape.circle : BoxShape.rectangle,
                borderRadius: isCircularBackground
                    ? null
                    : BorderRadius.all(
                        Radius.circular(
                          backgroundRadius,
                        ),
                      ),
              ),
              child: suffix != null || prefix != null
                  ? _getTextWithIconWidget()
                  : _getTextWidget(),
            ),
          )
        : suffix != null || prefix != null
            ? _getTextWithIconWidget()
            : _getTextWidget();
  }

  Widget _getTextWidget() {
    final textWidget = isAutoSized
        ? AutoSizeText(
            text,
            maxFontSize: fontSize,
            style: textStyle ?? _getTextStyle(),
            maxLines: maxLines,
            minFontSize: AppDimensions.fontSize08,
            overflow: TextOverflow.ellipsis,
          )
        : Text.rich(
            TextSpan(
              text: text,
              children: (children ?? [])
                  .map(
                    (e) => TextSpan(
                      text: e.text,
                      style: applyChildrenTextStyle
                          ? childrenTextStyle
                          : _getTextStyle(
                              appTextWidget: e,
                            ),
                      recognizer: TapGestureRecognizer()..onTap = e.onTap,
                    ),
                  )
                  .toList(),
              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
            textDirection: textDirection,
            key: key,
            textAlign: textAlign,
            style: textStyle ?? _getTextStyle(),
            maxLines: maxLines,
            overflow: maxLines == null ? null : TextOverflow.ellipsis,
          );

    return isCenterVertical
        ? Align(
            alignment: AlignmentDirectional.centerStart,
            child: textWidget,
          )
        : textWidget;
  }

  Widget _getTextWithIconWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Prefix Icon
        prefix != null
            ? Row(
                children: [
                  // Icon
                  prefix!,

                  // Space
                  const SizedBox(
                    width: AppDimensions.paddingOrMargin10,
                  ),
                ],
              )
            : const SizedBox.shrink(),

        // Text
        Expanded(
          child: _getTextWidget(),
        ),

        // Suffix Icon
        suffix != null
            ? Row(
                children: [
                  // Space
                  const SizedBox(
                    width: AppDimensions.paddingOrMargin16,
                  ),

                  // Icon
                  suffix!,
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  TextStyle _getTextStyle({
    AppTextWidget? appTextWidget,
  }) {
    return TextStyle(
      height: appTextWidget?.height ?? height,
      color: appTextWidget?.textColor ?? textColor,
      fontSize: appTextWidget?.fontSize ?? fontSize,
      fontWeight: appTextWidget?.fontWeight ?? fontWeight,
      letterSpacing: letterSpacing,
      fontFamily: AppFonts.aeonik,
      decoration: appTextWidget?.isUnderlineShown ?? isUnderlineShown ?? false
          ? TextDecoration.underline
          : appTextWidget?.isInlineShown ?? isInlineShown ?? false
              ? TextDecoration.lineThrough
              : TextDecoration.none,
    );
  }
}
