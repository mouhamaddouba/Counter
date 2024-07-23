import 'package:counter/source/core/global_widgets/app_button_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_assets.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimentions.dart';
import 'package:counter/source/core/values/enums/app_state_render_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppStateRenderUtils extends StatelessWidget {
  final AppStateRenderEnum lottieType;
  final String titleState;
  final String? buttonText;
  final Function()? onPressed;

  const AppStateRenderUtils({
    super.key,
    required this.lottieType,
    required this.titleState,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie of state
          if (lottieType != AppStateRenderEnum.none)
            SizedBox(
              width: AppConstants.size150.width,
              height: AppConstants.size150.height,
              child: Lottie.asset(
                _getAnimatedJson(lottieType),
              ),
            ),

          // Title of state
          Center(
            child: Padding(
              padding: const EdgeInsets.all(
                AppDimensions.paddingOrMargin16,
              ),
              child: AppTextWidget(
                titleState,
                textColor: AppColors.black01,
                fontSize: AppDimensions.fontSize18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Button Retry
          AppButtonWidget(
            text: buttonText ?? AppStrings.retry.tr(),
            onPressed: onPressed,
            color: AppColors.primary,
            width: AppDimensions.width140,
          ),
        ],
      ),
    );
  }

  /// Type json return by state enum
  String _getAnimatedJson(AppStateRenderEnum lottieType) {
    switch (lottieType) {
      // If state is  Connecting
      case AppStateRenderEnum.connecting:
        return AppAssets.bluetooth;

      // If state is failed
      case AppStateRenderEnum.failed:
        return AppAssets.failed;

      // If state is not found
      case AppStateRenderEnum.notFound:
        return AppAssets.notFound;

      // If state is settings
      case AppStateRenderEnum.settings:
        return AppAssets.settings;

      // If state is success
      case AppStateRenderEnum.success:
        return AppAssets.success;

      // If state is none
      case AppStateRenderEnum.none:
        return AppAssets.failed;
    }
  }
}
