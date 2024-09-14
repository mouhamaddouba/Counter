import 'dart:async';

import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_dimensions.dart';

import 'parallel_model.dart';
import 'parallel_result.dart';

class ParallelService {
  late StreamController<ParallelResult> _streamController;
  late List<ParallelModel> _services = [];
  late final List<ParallelResult> _parallelResults = [];
  int _sumOfFinishedServices = AppDimensions.zeroInt;

  ParallelService({
    required List<ParallelModel> services,
  }) {
    _streamController = StreamController();
    _services = services;
  }

  Future<List<ParallelResult>> getResults({
    int duration = AppDimensions.zeroInt,
  }) async {
    int durationSum = AppDimensions.zeroInt;
    for (var service in _services) {
      service.service.then((value) {
        _streamController.add(
          ParallelResult(
            name: service.name,
            finalResult: value,
          ),
        );
      });
    }

    _streamController.stream.listen((data) {
      _sumOfFinishedServices++;
      _parallelResults.add(data);
      if (_sumOfFinishedServices == _services.length) {
        _streamController.close();
      }
    });

    while (!_streamController.isClosed) {
      durationSum += AppConstants.duration100;
      await Future.delayed(
        const Duration(
          milliseconds: AppConstants.duration100,
        ),
      );
    }
    while (durationSum <= duration) {
      durationSum += AppConstants.duration100;
      await Future.delayed(
        const Duration(
          milliseconds: AppConstants.duration100,
        ),
      );
    }
    return _parallelResults;
  }

  bool isServicesFailed() {
    return _parallelResults
        .where((element) => element.finalResult.hasError)
        .isNotEmpty;
  }
}
