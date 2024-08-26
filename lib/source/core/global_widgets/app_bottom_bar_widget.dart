import 'package:counter/source/core/global_widgets/app_icon_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AppBottomBarWidget extends StatelessWidget {
  final List<AppTabBarItem> items;
  final int selectedIndex;
  final void Function(int) onTap;
  final bool isBottomIndicator;

  const AppBottomBarWidget({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    this.isBottomIndicator = false,
  }) : assert(items.length <= 5);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...items.asMap().map(
          (int index, AppTabBarItem item) {
            return MapEntry(
              index, // Important
              InkWell(
                onTap: () {
                  onTap(index);
                },
                child: index == selectedIndex

                    // style active tab
                    ? AnimatedContainer(
                        duration: const Duration(
                          milliseconds: AppConstants.duration150,
                        ),

                        width: AppDimensions.width140.w,

                        // Padding for inner Container
                        padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppDimensions.paddingOrMargin8,
                          vertical: AppDimensions.paddingOrMargin10,
                        ),

                        // Style container
                        decoration: BoxDecoration(
                          //color: AppColors.primary.withOpacity(0.15),
                          color:
                              Theme.of(context).brightness == Brightness.light
                                  ? AppColors.containerTab
                                  : AppColors.darkContainerTab,
                          borderRadius: BorderRadiusDirectional.circular(
                            AppDimensions.radius10,
                          ),
                        ),

                        // style tab icon & text
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon
                            if (item.icon != null)
                              AppIconWidget(
                                iconPath: item.icon,
                                color: Theme.of(context).primaryColor,
                                size: AppDimensions.iconSize25,
                              ),

                            // space
                            const SizedBox(
                              width: AppDimensions.width08,
                            ),

                            // Text
                            if (item.text != null)
                              AppTextWidget(
                                item.text ?? AppConstants.emptyText,
                                maxLines: AppConstants.maxLines,
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall,
                              ),
                          ],
                        ),
                      )

                    // style non-active tab
                    : AppIconWidget(
                        iconPath: item.icon,
                        color: Theme.of(context).brightness == Brightness.light
                            ? AppColors.onPrimaryContainer.withOpacity(
                                AppConstants.opacity0_6,
                              )
                            : AppColors.darkOnPrimaryContainer.withOpacity(
                                AppConstants.opacity0_7,
                              ),
                        //AppColors.black02,
                        size: AppDimensions.iconSize25,
                      ),
              ),
            );
          },
        ).values,
      ],
    );
  }
}

class AppTabBarItem {
  final String? text;
  final String? icon;

  AppTabBarItem({
    this.text,
    this.icon,
  });
}
