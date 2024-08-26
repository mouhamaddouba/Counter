import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_icon_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/routes/app_routes.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class ConnectWidget extends StatelessWidget {
  final BluetoothDevice device;

  const ConnectWidget({
    super.key,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: AppDimensions.paddingOrMargin12,
        right: AppDimensions.paddingOrMargin8,
        left: AppDimensions.paddingOrMargin8,
      ),
      height: AppDimensions.height70,
      decoration: BoxDecoration(
        color: AppColors.white01,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppDimensions.radius20,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray02.withOpacity(
              AppConstants.opacity0_6,
            ),
            blurRadius: AppDimensions.radius10,
            spreadRadius: AppDimensions.zero,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingOrMargin16,
          vertical: AppDimensions.paddingOrMargin10,
        ),
        child: Row(
          children: [
            /// Icon Bluetooth
            const AppIconWidget(
              withBackground: true,
              iconData: Icons.bluetooth,
              color: AppColors.primary900,
              backgroundColor: AppColors.primary50,
              backgroundRadius: AppDimensions.radius25,
              backgroundSize: AppDimensions.iconSize40,
            ),

            Expanded(
              child: Column(
                children: [
                  /// Device Platform
                  AppTextWidget(
                    device.platformName == AppConstants.emptyText
                        ? AppStrings.unknown.t()
                        : device.platformName,
                    fontSize: AppDimensions.fontSize12,
                    textColor: AppColors.rgb,
                  ),

                  ///space
                  const SizedBox(
                    height: 6,
                  ),

                  /// Device Remote Id
                  AppTextWidget(
                    textColor: AppColors.rgb,
                    device.remoteId.toString(),
                    fontSize: AppDimensions.fontSize08,
                  ),
                ],
              ),
            ),

            /// text button connect
            AppTextWidget(
              AppStrings.connect.t(),
              fontWeight: FontWeight.w600,
              textColor: AppColors.primary,
              fontSize: AppDimensions.fontSize12,
              onTap: () {
                Get.offAllNamed(
                  AppRoutes.home,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
