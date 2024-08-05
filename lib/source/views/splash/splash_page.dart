import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:counter/source/core/extentions/string_extension.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimentions.dart';
import 'package:counter/source/view_model/splash/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashViewModel> {
  const SplashPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: AppDimensions.fontSize20,
          ),
          child: AnimatedBuilder(
            animation: controller.scaleAnimation,
            builder: (context, child) {
              return Transform.translate(
                offset: AppConstants.offset10,
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      AppStrings.appName.t(),
                      speed: const Duration(
                        milliseconds: AppConstants.duration150,
                      ),
                    )
                  ],
                  repeatForever: false,
                  isRepeatingAnimation: false,
                  displayFullTextOnTap: false,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
