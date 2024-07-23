import 'package:counter/source/core/global_widgets/app_animation_dialog_widget.dart';
import 'package:counter/source/core/global_widgets/app_button_widget.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/enums/dialog_type_enum.dart';
import 'package:flutter/material.dart';

abstract class AppAlertUtils {
  /// Alert for show dialog
  static Future<dynamic> showDialog({
    String? title = AppStrings.alert,
    String message = AppConstants.emptyText,
    Widget? icon,
    DialogTypeEnum dialogTypeEnum = DialogTypeEnum.primary,
    String? textConfirm,
    String? textCancel,
    Widget? content,
    bool barrierDismissible = true,
    List<AppButtonWidget> actionButtons = const [],
    Function()? onConfirm,
    Function()? onCancel,
    Function(dynamic)? onAfter,
    required BuildContext context,
    Widget? bodyContent,
    bool isNewBody = false,
  }) {
    return showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return AppAnimationDialogWidget(
          title: title,
          message: message,
          icon: icon,
          dialogTypeEnum: dialogTypeEnum,
          content: content,
          textConfirm: textConfirm,
          textCancel: textCancel,
          actionButtons: actionButtons,
          onConfirm: onConfirm ??
              () {
                Navigator.of(context).pop();
              },
          onCancel: onCancel,
          bodyContent: bodyContent,
          isNewBody: isNewBody,
        );
      },
      transitionBuilder: (context, animation1, animation2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, -1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }
}
