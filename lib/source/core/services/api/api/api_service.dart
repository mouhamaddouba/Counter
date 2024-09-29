import 'package:counter/source/core/services/api/errors/error_handler.dart';
import 'package:counter/source/core/services/api/network_response/response_data.dart';
import 'package:counter/source/core/services/api/network_response/result.dart';
import 'package:counter/source/core/values/constant/app_constants.dart';
import 'package:counter/source/core/values/constant/app_settings.dart';
import 'package:counter/source/core/values/enums/api_methods_enum.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static Future<FinalResult> sendRequest({
    String? url,
    String? ipUrl,
    dynamic body,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? pathParameters,
    ApiMethodsEnum? method,
    bool isPublic = false,
    bool havePathParameter = false,
    bool? externalService,
    bool? stringResponse,
  }) async {
    ipUrl = 'http://$ipUrl/';
    if (havePathParameter) {
      url = "${url!}?";
      (pathParameters ?? {}).forEach(
        (key, value) => url = "${url!}$key=${value.toString()}",
      );
    }
    externalService ??= false;

    if (kDebugMode) {
      print(
          "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< REQUEST URL >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

      print(
          "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< REQUEST PARAMETERS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(queryParameters ?? {});
      print(
          "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< REQUEST BODY >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print(body ?? {});
    }

    var options = BaseOptions(
      baseUrl: externalService ? "" : ipUrl,
      connectTimeout: const Duration(
        milliseconds: AppConstants.duration40000,
      ),
      receiveTimeout: const Duration(
        milliseconds: AppConstants.duration40000,
      ),
      contentType: Headers.jsonContentType,
    );

    var dio = Dio(options);
    dio.interceptors.add(
      PrettyDioLogger(),
    );

    Map<String, String> header = {};
    if (!isPublic) {
      header = {'Authorization': "Bearer ${AppSettings.token}"};
    }

    late Response response;
    try {
      switch (method) {
        /// Get Methods
        case ApiMethodsEnum.get:
          {
            response = await dio.get(
              url!,
              queryParameters: queryParameters,
              options: Options(
                headers: header,
              ),
            );
            break;
          }

        /// Post Methods
        case ApiMethodsEnum.post:
          {
            response = await dio.post(
              url!,
              queryParameters: queryParameters,
              options: Options(headers: header),
              data: body,
            );
            break;
          }

        /// Put Methods
        case ApiMethodsEnum.put:
          {
            response = await dio.put(
              url!,
              queryParameters: queryParameters,
              options: Options(headers: header),
              data: body,
            );
            break;
          }

        /// Delete Methods
        case ApiMethodsEnum.delete:
          {
            response = await dio.delete(
              url!,
              queryParameters: queryParameters,
              options: Options(headers: header),
              data: body,
            );
            break;
          }
        default:
          {
            break;
          }
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(
            "------------------------ API Exception --------------------------------------");
        print(e);
      }

      return ErrorHandler.handleDioError(e);
    }

    var decodedJson = response.data;
    if (kDebugMode) {
      print(
          "------------------------ API Response --------------------------------------");
      print(decodedJson);
      print(
          "------------------------ API Header --------------------------------------");
      print(response.headers);
    }
    if (decodedJson is Map<String, dynamic>) {
      return FinalResult(
        responseData: ResponseData.fromJson(
          decodedJson,
        ),
      );
    } else {
      return FinalResult(
        responseData: ResponseData.setData(
          decodedJson,
        ),
      );
    }
  }
}
