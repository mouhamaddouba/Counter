import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/connect/connect_view_model.dart';
import 'package:counter/source/views/connect/widgets/connect_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ConnectListView extends GetView<ConnectViewModel> {
  const ConnectListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimationLimiter(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.appConnectServices.devicesList.length,
          padding: const EdgeInsets.all(
            AppDimensions.paddingOrMargin6,
          ),
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, index) {
            // Animation for list bluetooth
            return AnimationConfiguration.staggeredList(
              position: index,
              delay: const Duration(
                milliseconds: AppConstants.duration150,
              ),
              child: SlideAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: const Duration(
                  milliseconds: AppConstants.duration2500,
                ),
                child: FadeInAnimation(
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(
                    milliseconds: AppConstants.duration2500,
                  ),

                  /// design element of list
                  child: ConnectWidget(
                    device: controller.appConnectServices.devicesList[index],
                    // device: AppConstants.devicesList[index],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
