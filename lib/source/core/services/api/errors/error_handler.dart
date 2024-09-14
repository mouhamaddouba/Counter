import 'dart:io';
import 'package:counter/source/core/extensions/string_extension.dart';
import 'package:counter/source/core/services/api/errors/error_types.dart';
import 'package:counter/source/core/services/api/network_response/result.dart';
import 'package:counter/source/core/translations/app_strings.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ErrorHandler {
  static FinalResult handleDioError<T>(DioException error) {
    debugPrint(
      "Dio error : ${error.message ?? ''}",
    );
    debugPrint(
      "Dio error : ${error.type}",
    );

    if (error.type == DioExceptionType.unknown ||
        error.type == DioExceptionType.badResponse) {
      if (error is SocketException) {
        return FinalResult(
          error: BaseError(
            code: error.response!.statusCode,
          ),
        );
      }

      if (error.type == DioExceptionType.badResponse) {
        if (error.response == null) {
          return FinalResult(
            error: BaseError(
              code: AppConstants.code503,
              msg: AppStrings.somethingWentWrong.t(),
            ),
          );
        }
        if (error.response!.statusCode == AppConstants.code400) {
          return FinalResult(
            error: BaseError(
              code: error.response!.statusCode,
              msg: error.response!.data.toString().contains('message')
                  ? error.response!.data["message"]
                  : error.response!.data.toString(),
            ),
          );
        } else {
          return FinalResult(
            error: BaseError(
              code: error.response!.statusCode,
              msg: (error.response!.data != null && error.response!.data is Map)
                  ? error.response!.data["message"] ??
                      AppStrings.somethingWentWrong.t()
                  : AppStrings.somethingWentWrong.t(),
            ),
          );
        }
      } else if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        return FinalResult(
          error: BaseError(
            errorType: ErrorType.internetConnectionError,
          ),
        );
      } else if (error.type == DioExceptionType.cancel) {
        return FinalResult(
          error: BaseError(
            errorType: ErrorType.internetConnectionError,
          ),
        );
      } else {
        return FinalResult(
          error: BaseError(
            errorType: ErrorType.internetConnectionError,
          ),
        );
      }
    }
    return FinalResult(
      error: BaseError(
        errorType: ErrorType.internetConnectionError,
      ),
    );
  }
}
