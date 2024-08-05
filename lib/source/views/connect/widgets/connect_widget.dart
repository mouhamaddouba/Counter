import 'package:counter/source/core/extentions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_button_widget.dart';
import 'package:counter/source/core/global_widgets/app_icon_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/routes/app_routes.dart';
import 'package:counter/source/core/services/app_connect_services.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimentions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

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
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.white01,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gray02.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 0,
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
            // Icon Bluetooth
            const AppIconWidget(
              iconData: Icons.bluetooth,
              color: AppColors.primary900,
              withBackground: true,
              backgroundColor: AppColors.primary50,
              backgroundRadius: AppDimensions.radius25,
              backgroundSize: AppDimensions.iconSize40,
            ),

            Expanded(
              child: Column(
                children: [
                  // Device Platform
                  AppTextWidget(
                    device.platformName == AppConstants.emptyText
                        ? AppStrings.unknown.t()
                        : device.platformName,
                    fontSize: AppDimensions.fontSize12,
                    textColor: AppColors.rgb,
                  ),

                  //space
                  const SizedBox(
                    height: 6,
                  ),

                  // Device Remote Id
                  AppTextWidget(
                    device.remoteId.toString(),
                    fontSize: AppDimensions.fontSize08,
                    textColor: AppColors.rgb,
                  ),
                ],
              ),
            ),

            // text button connect
            AppTextWidget(
              AppStrings.connect.t(),
              textColor: AppColors.primary,
              fontSize: AppDimensions.fontSize12,
              fontWeight: FontWeight.w600,
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
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
