import 'package:counter/source/core/extentions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_loading_widget.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimentions.dart';
import 'package:counter/source/view_model/connect/connect_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectAppBarView extends GetView<ConnectViewModel>
    implements PreferredSizeWidget {
  const ConnectAppBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: AppDimensions.zero,
      backgroundColor: AppColors.primary600,
      actions: <Widget>[
        if (controller.isSearching.value) const AppLoadingWidget(),
      ],
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),

      // Title App Bar
      title: AppTextWidget(
        AppStrings.bluetoothConnection.t(),
        textColor: AppColors.white01,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
        AppDimensions.height55,
      );
}
