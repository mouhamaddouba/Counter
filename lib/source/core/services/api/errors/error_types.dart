import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';

enum ErrorType {
  serviceUnavailableError,
  unauthorizedError,
  notFoundError,
  forbiddenError,
  conflictError,
  internalServerError,
  badRequestError,
  internetConnectionError,
  noError,
  internetError,
  hardwareNoLocationPermission,
  hardwareNoBluetoothPermission,
  hardwareBluetoothDisable,
  hardwareLocationDisable,
  hardwareDisconnected,
}

Map<int, ErrorType> errorCodeType = {
  AppConstants.code_1: ErrorType.internetConnectionError,
  AppConstants.code400: ErrorType.badRequestError,
  AppConstants.code401: ErrorType.unauthorizedError,
  AppConstants.code403: ErrorType.forbiddenError,
  AppConstants.code404: ErrorType.notFoundError,
  AppConstants.code409: ErrorType.conflictError,
  AppConstants.code500: ErrorType.internalServerError,
  AppConstants.code503: ErrorType.serviceUnavailableError,
  AppConstants.code601: ErrorType.hardwareNoLocationPermission,
  AppConstants.code602: ErrorType.hardwareNoBluetoothPermission,
  AppConstants.code603: ErrorType.hardwareBluetoothDisable,
  AppConstants.code604: ErrorType.hardwareLocationDisable,
  AppConstants.code605: ErrorType.hardwareDisconnected,
};

Map<ErrorType, int> errorTypeCodes = {
  ErrorType.internetConnectionError: AppConstants.code_1,
  ErrorType.badRequestError: AppConstants.code400,
  ErrorType.unauthorizedError: AppConstants.code401,
  ErrorType.forbiddenError: AppConstants.code403,
  ErrorType.notFoundError: AppConstants.code404,
  ErrorType.conflictError: AppConstants.code409,
  ErrorType.internalServerError: AppConstants.code500,
  ErrorType.serviceUnavailableError: AppConstants.code503,
  ErrorType.hardwareNoLocationPermission: AppConstants.code601,
  ErrorType.hardwareNoBluetoothPermission: AppConstants.code602,
  ErrorType.hardwareBluetoothDisable: AppConstants.code603,
  ErrorType.hardwareLocationDisable: AppConstants.code604,
  ErrorType.hardwareDisconnected: AppConstants.code605,
};

Map<ErrorType, String> errorTypeMsg = {
  ErrorType.badRequestError: AppStrings.badRequestError.t(),
  ErrorType.conflictError: AppStrings.conflictError.t(),
  ErrorType.forbiddenError: AppStrings.forbiddenError.t(),
  ErrorType.internalServerError: AppStrings.internalServerError.t(),
  ErrorType.notFoundError: AppStrings.notFoundError.t(),
  ErrorType.serviceUnavailableError: AppStrings.serviceUnavailableError.t(),
  ErrorType.unauthorizedError: AppStrings.unauthorizedError.t(),
  ErrorType.internetConnectionError: AppStrings.noInternetError.t(),
  ErrorType.noError: "",
  ErrorType.internetError: AppStrings.somethingWentWrong.t(),
  ErrorType.hardwareNoLocationPermission: AppStrings.locationPermission.t(),
  ErrorType.hardwareNoBluetoothPermission: AppStrings.bluetoothPermission.t(),
  ErrorType.hardwareBluetoothDisable: AppStrings.bluetoothIsNotEnable.t(),
  ErrorType.hardwareLocationDisable: AppStrings.locationIsNotEnable.t(),
  ErrorType.hardwareDisconnected: AppStrings.deviceDisconnected.t()
};

class BaseError {
  late int? code;
  late ErrorType errorType;
  late String msg;

  BaseError({
    int? code,
    ErrorType errorType = ErrorType.noError,
    this.msg = '',
  }) {
    if (code == null) {
      this.errorType = errorType;
      this.code = errorTypeCodes[errorType]!;
    } else {
      this.code = code;
      this.errorType = errorCodeType[code]!;
    }
    if (msg.isEmpty) {
      msg = errorTypeMsg[errorType]!;
    }
  }
}

const int successCode = AppConstants.code200;
