import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/view_model/home/home_view_model.dart';
import 'package:counter/source/views/home/widgets/appbar_operator_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeContentAppBarView extends GetView<HomeViewModel> {
  const HomeContentAppBarView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.scrollController,
      scrollDirection: Axis.horizontal,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppBarOperatorWidget(
            operatorName: AppStrings.id,
            operatorValue: '100',
          ),
          AppBarOperatorWidget(
            operatorName: AppStrings.sn,
            operatorValue: '30',
          ),
          AppBarOperatorWidget(
            operatorName: AppStrings.name,
            operatorValue: 'Exam',
          ),
          AppBarOperatorWidget(
            operatorName: AppStrings.sku,
            operatorValue: 'Test',
          ),
          AppBarOperatorWidget(
            operatorName: AppStrings.lot,
            operatorValue: 'Text',
          ),
          AppBarOperatorWidget(
            operatorName: AppStrings.operator,
            operatorValue: 'Mouhamad',
          ),
          AppBarOperatorWidget(
            operatorName: AppStrings.currentKit,
            operatorValue: '80',
          ),
          AppBarOperatorWidget(
            operatorName: AppStrings.piecesInEachKit,
            operatorValue: '30',
          ),
          AppBarOperatorWidget(
            operatorName: AppStrings.opStatus,
            operatorValue: 'Successful',
          ),
        ],
      ),
    );
  }
}
