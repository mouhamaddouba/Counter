import 'package:counter/source/view_model/connect/connect_view_model.dart';
import 'package:counter/source/views/connect/views/connect_app_bar_view.dart';
import 'package:counter/source/views/connect/views/connect_floating_button_view.dart';
import 'package:counter/source/views/connect/views/connect_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConnectPage extends GetView<ConnectViewModel> {
  const ConnectPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      /// App Bar
      appBar: ConnectAppBarView(),

      /// List View
      body: ConnectListView(),

      /// Floating Button
      floatingActionButton: ConnectFloatingButtonView(),
    );
  }
}
