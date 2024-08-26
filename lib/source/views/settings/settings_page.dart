import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/global_widgets/app_text_widget.dart';
import 'package:counter/source/core/themes/app_colors.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';
import 'package:counter/source/view_model/settings/settings_view_model.dart';
import 'package:counter/source/views/settings/settings_view.dart';
import 'package:counter/source/views/settings/views/settings_buttons_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends GetView<SettingsViewModel> {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar
      appBar: AppBar(
        centerTitle: true,
        title: AppTextWidget(
          AppStrings.settings.t(),
          textColor: AppColors.black01,
          fontSize: AppDimensions.fontSize14,
        ),
      ),

      /// Body
      body: const SettingsView(),

      /// BottomSheet buttons
      bottomNavigationBar: const SettingsButtonsView(),
    );
  }
}
