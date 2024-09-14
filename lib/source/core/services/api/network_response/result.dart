import 'package:counter/source/core/services/api/errors/error_types.dart';

import 'response_data.dart';

class FinalResult {
  ResponseData? responseData;
  final BaseError? error;

  FinalResult({
    this.responseData,
    this.error,
  });

  bool get hasError {
    return error != null;
  }

  bool get hasData {
    return responseData != null;
  }
}
