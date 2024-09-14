import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_animation_dialog_widget.dart';
import 'package:counter/source/core/global_widgets/app_button_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/enums/dialog_type_enum.dart';
import 'package:flutter/material.dart';

class AppAlertUtils {
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

  /// Alert dialog for utils permission
  void showAlertDialog(
    String text,
    Function retry,
    BuildContext context,
  ) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: 150,
            width: 350,
            margin: const EdgeInsets.only(
              bottom: 50,
              left: 12,
              right: 12,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffeceaea),
              borderRadius: BorderRadius.circular(40),
            ),
            child: SizedBox.expand(
              child: StatefulBuilder(
                builder: (context, setState) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          width: 250,
                          child: Text(
                            text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.gray03,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      /// Pointer
                      Center(
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all(
                              AppColors.primary,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              AppStrings.tryAgain.t(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          onPressed: () {
                            retry();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
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
