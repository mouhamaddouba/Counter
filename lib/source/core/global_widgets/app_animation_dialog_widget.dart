import 'package:counter/source/core/global_widgets/app_button_widget.dart';
import 'package:counter/source/core/global_widgets/app_icon_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimentions.dart';
import 'package:counter/source/core/values/enums/dialog_type_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppAnimationDialogWidget extends StatelessWidget {
  final String? title;
  List<Widget> actionButtons;
  final Widget? icon;
  final DialogTypeEnum dialogTypeEnum;
  final String message;
  final Widget? content;
  final Function()? onConfirm;
  final Function()? onCancel;
  final String? textConfirm;
  final String? textCancel;
  final Widget? bodyContent;
  final bool isNewBody;

  AppAnimationDialogWidget({
    super.key,
    this.title,
    this.actionButtons = const [],
    this.icon,
    this.dialogTypeEnum = DialogTypeEnum.primary,
    this.message = AppStrings.alertMassageNoContentText,
    this.content,
    this.onConfirm,
    this.onCancel,
    this.textConfirm,
    this.textCancel,
    this.bodyContent,
    this.isNewBody = false,
  });

  @override
  Widget build(BuildContext context) {
    final textCancelTemp = textCancel ?? AppStrings.cancel.tr();
    final textConfirmTemp = textConfirm ?? AppStrings.ok.tr();

    final paddingCancelFactor = textCancelTemp.length < 5 ? 3 : 1;
    final paddingConfirmFactor = textConfirmTemp.length < 5 ? 3 : 1;

    actionButtons = actionButtons.isEmpty
        ? [
            // Cancel
            onCancel != null
                ? AppButtonWidget(
                    text: textCancelTemp,
                    onPressed: onCancel,
                    // width: AppDimensions.buttonWidth80,
                    textColor: AppColors.black02,
                    color: AppColors.background,
                    padding: EdgeInsetsDirectional.only(
                      start:
                          AppDimensions.paddingOrMargin10 * paddingCancelFactor,
                      end:
                          AppDimensions.paddingOrMargin10 * paddingCancelFactor,
                    ),
                  )
                : const SizedBox.shrink(),

            // Space
            if (onCancel != null && onConfirm != null)
              const SizedBox(
                width: AppDimensions.paddingOrMargin10,
              ),

            // Confirm
            onConfirm != null
                ? AppButtonWidget(
                    text: textConfirmTemp,
                    onPressed: onConfirm,
                    width: AppDimensions.width120,
                    textColor: AppColors.onPrimary,
                    color: _getPrimaryColor(context),
                    padding: EdgeInsetsDirectional.only(
                      start:
                          AppDimensions.paddingOrMargin8 * paddingConfirmFactor,
                      end:
                          AppDimensions.paddingOrMargin8 * paddingConfirmFactor,
                    ),
                  )
                : const SizedBox.shrink(),
          ]
        : actionButtons;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.radius10,
        ),
      ),
      elevation: AppDimensions.elevation04,
      child: ClipRRect(
        borderRadius: const BorderRadiusDirectional.all(
          Radius.circular(
            AppDimensions.radius10,
          ),
        ),
        child: Container(
          width: AppDimensions.width320,
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.onPrimary
              : AppColors.primary,
          child: Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppDimensions.paddingOrMargin16,
              vertical: AppDimensions.paddingOrMargin16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Body
                  isNewBody ? _bodyContent(context) : bodyContent!,

                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actionButtons,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _bodyContent(BuildContext context) {
    return Column(
      children: [
        // Icon & Title
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            (icon != null)
                ? icon!
                : AppIconWidget(
                    iconData: _getIconData(),
                    color: _getPrimaryColor(context),
                    size: AppDimensions.iconSize30,
                  ),

            // Space
            const SizedBox(
              width: AppDimensions.paddingOrMargin10,
            ),

            // Title
            // if (title != null)
            Expanded(
              child: AppTextWidget(
                title ?? AppStrings.noticeLabel.tr(),
                textAlign: TextAlign.start,
                fontSize: AppDimensions.fontSize10,
                fontWeight: FontWeight.w600,
                textColor: Theme.of(context).brightness == Brightness.light
                    ? AppColors.darkOnPrimary
                    : AppColors.onPrimary,
              ),
            ),
          ],
        ),

        // Space
        const SizedBox(
          height: AppDimensions.paddingOrMargin16,
        ),

        // Content
        (content != null)
            ? Container(
                alignment: AlignmentDirectional.centerStart,
                child: content!,
              )
            : SingleChildScrollView(
                child: Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: AppTextWidget(
                    message.tr(),
                    textAlign: TextAlign.start,
                    fontSize: AppDimensions.fontSize16,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.black01,
                    maxLines: 10,
                  ),
                ),
              ),

        // Space
        const SizedBox(
          height: AppDimensions.paddingOrMargin20,
        ),
      ],
    );
  }

  IconData _getIconData() {
    if (dialogTypeEnum == DialogTypeEnum.error) {
      return Icons.warning;
    } else if (dialogTypeEnum == DialogTypeEnum.warning) {
      return Icons.warning;
    } else if (dialogTypeEnum == DialogTypeEnum.success) {
      return Icons.check;
    } else {
      return Icons.check;
    }
  }

  Color _getPrimaryColor(BuildContext context) {
    if (dialogTypeEnum == DialogTypeEnum.error) {
      return AppColors.errorLight;
    } else if (dialogTypeEnum == DialogTypeEnum.warning) {
      return AppColors.warningLight;
    } else if (dialogTypeEnum == DialogTypeEnum.success) {
      return AppColors.successLight;
    } else {
      return Theme.of(context).primaryColor;
    }
  }
}
