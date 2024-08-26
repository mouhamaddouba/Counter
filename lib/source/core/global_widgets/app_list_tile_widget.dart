import 'package:counter/source/core/global_widgets/app_icon_widget.dart';
import 'package:counter/source/core/global_widgets/app_image_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart' as date;

class AppListTileWidget extends StatelessWidget {
  final bool enabled;
  final bool isListView;
  final bool? minHeight;
  final bool isThreeLine;
  final bool isTitleProfile;
  final double? paddingLeading;
  final double? paddingVertical;
  final double? paddingHorizontalTitle;
  final String textTitle;
  final String? textSubtitle;
  final String? imageData;
  final double? imageSize;
  final double? iconSize;
  final Color splashColor;
  final Color? iconColor;
  final Color? titleColor;
  final double? titleSize;
  final Color? dateColor;
  final double? dateSize;
  final double? subtitleSize;
  final double? thickness;
  final Color? subtitleColor;
  final DateTime? dateTimeSubtitle;
  final DateTime? dateTimeTitle;
  final IconData? iconData;
  final String? iconPath;
  final bool? isProfile;
  final bool? isBottomSheet;
  final bool? isNotification;
  final bool? isNotes;
  final BoxFit fit;
  final String? titleSecondary;
  final FontWeight? dateWeight;
  final Color? noteColor;
  final double? heightNotifications;

  final void Function()? onTap;
  final EdgeInsetsGeometry? paddingListTile;

  const AppListTileWidget({
    super.key,
    this.paddingHorizontalTitle,
    this.paddingLeading,
    this.paddingVertical,
    this.paddingListTile,
    this.minHeight,
    this.isThreeLine = false,
    this.isTitleProfile = false,
    this.splashColor = AppColors.onLight500,
    this.enabled = false,
    this.onTap,
    required this.textTitle,
    this.textSubtitle,
    this.titleSecondary,
    this.imageData,
    this.iconData,
    this.iconColor,
    this.titleColor = AppColors.black01,
    this.titleSize,
    this.dateColor = AppColors.gray03,
    this.dateSize,
    this.subtitleSize,
    this.subtitleColor = AppColors.gray03,
    this.thickness,
    this.dateTimeSubtitle,
    this.dateTimeTitle,
    this.isListView = false,
    this.isBottomSheet = false,
    this.isNotes = false,
    this.iconPath,
    this.imageSize,
    this.iconSize,
    this.isProfile,
    this.isNotification,
    this.dateWeight,
    this.noteColor,
    this.heightNotifications,
    this.fit = BoxFit.contain,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: ListTile(
            enabled: enabled,
            horizontalTitleGap:
                paddingHorizontalTitle ?? AppDimensions.paddingOrMargin6,
            contentPadding: paddingListTile,
            dense: minHeight ?? false,
            isThreeLine: isThreeLine,
            minLeadingWidth: paddingLeading,
            minVerticalPadding: paddingVertical,
            splashColor: splashColor,
            leading: _getLeading(context),
            title: isNotification == true ? null : _getTitle(context),
            subtitle: isProfile == true ? _getSubtitle(context) : null,
          ),
        ),
        isListView
            ? const SizedBox.shrink()
            : Divider(
                thickness: thickness ?? AppDimensions.thickness_05,
                height: AppDimensions.zero,
              ),
      ],
    );
  }

  Widget _getLeading(BuildContext context) {
    return imageData != null
        ? AppImageWidget(
            disablePreview: false,
            isCircle: true,
            border: Border.all(
              color: Theme.of(context).primaryColor,
              width: AppConstants.border1_5,
            ),
            path: imageData,
            width: AppDimensions.width60,
            height: AppDimensions.height60,
            fit: fit,
          )
        : AppIconWidget(
            iconPath: iconPath,
            iconData: iconData,
            color: Theme.of(context).primaryColor,
            size: iconSize ?? AppDimensions.iconSize22,
          );
  }

  Widget _getSubtitle(BuildContext context) {
    return isThreeLine
        ? Column(
            children: [
              AppTextWidget(
                textSubtitle ?? AppConstants.emptyText,
                textColor: subtitleColor,
                fontSize: subtitleSize ?? AppDimensions.fontSize08,
                height: AppDimensions.height02,
                // maxLines: 1,
              ),
              const SizedBox(
                height: AppDimensions.paddingOrMargin8,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: AppTextWidget(
                  date.DateFormat('yyyy/MM/dd    hh:mm aa').format(
                    dateTimeSubtitle ?? DateTime.now(),
                  ),
                  //notifications.addDate.toString(),
                  textColor: dateColor,
                  fontSize: dateSize ?? AppDimensions.fontSize06,
                ),
              ),
            ],
          )
        : AppTextWidget(
            textSubtitle ?? AppConstants.emptyText,
            //textColor: Theme.of(context).primaryColor,
            textColor: noteColor ?? Theme.of(context).primaryColor,
            fontSize: subtitleSize ?? AppDimensions.fontSize08,
            height: heightNotifications ?? AppDimensions.height02,
            // maxLines: AppConstants.maxLines,
          );
  }

  Widget _getTitle(BuildContext context) {
    return isTitleProfile
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // title
              AppTextWidget(
                textTitle,
                textColor: titleColor,
                fontSize: titleSize ?? AppDimensions.fontSize08,
              ),

              // Date
              AppTextWidget(
                isBottomSheet == false
                    ? date.DateFormat('hh:mm aa').format(
                        dateTimeTitle ?? DateTime.now(),
                      )
                    : titleSecondary!,
                textColor: dateColor,
                fontSize: dateSize ?? AppDimensions.fontSize06,
                fontWeight: dateWeight ?? FontWeight.w600,
              ),
            ],
          )
        : isNotes == false
            ? AppTextWidget(
                textTitle,
                textStyle: Theme.of(context).textTheme.displayLarge,
              )
            : Align(
                alignment: AlignmentDirectional.centerStart,
                child: AppTextWidget(
                  textTitle,
                  textColor: dateColor,
                  fontSize: dateSize ?? AppDimensions.fontSize06,
                  fontWeight: dateWeight ?? FontWeight.w600,
                ),
              );
  }
}
