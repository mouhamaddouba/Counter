import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:counter/source/views/home/views/home_content_appbar_view.dart';
import 'package:counter/source/views/home/views/home_content_body_view.dart';
import 'package:counter/source/views/home/views/home_content_bottom_sheet_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContentView extends GetView<HomeViewModel> {
  const HomeContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Operation values
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: const HomeContentAppBarView(),
      ),

      /// body content
      body: Obx(
        () {
          return AnimatedOpacity(
            opacity: controller.showForm.value
                ? AppConstants.opacity01
                : AppConstants.opacity00,
            duration: const Duration(
              milliseconds: 600,
            ),
            child: const SingleChildScrollView(
              child: HomeContentBodyView(),
            ),
          );
        },
      ),

      ///bottom sheet of buttons
      bottomNavigationBar: const HomeContentBottomSheetView(),
    );
  }
}
