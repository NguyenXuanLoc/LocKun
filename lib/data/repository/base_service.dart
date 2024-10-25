import 'dart:convert';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/eventbus/open_new_page_event.dart';
import 'package:base_bloc/modules/home_page/home_page.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../../generated/locale_keys.g.dart';
import '../../utils/app_utils.dart';
import '../../utils/connection_utils.dart';
import '../globals.dart' as globals;
import 'api_result.dart';

class BaseService {
  var baseUrl = 'https://staging-api.swayme.pl/api/v1/';

  void initProvider() {}

  // ignore: non_constant_identifier_names
  Future<ApiResult> GET(String url,
      {Map<String, dynamic>? queryParam,
      bool isNewFormat = false,
      bool isToken = true,
      String baseUrl = ''}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[GET] ${this.baseUrl}$url');
    debugPrint("Bearer ${globals.accessToken}");
    debugPrint("Language ${globals.lang}");
    try {
      var header = {
        'Content-Type': 'application/json',
        ApiKey.lang: globals.lang
      };
      header['Authorization'] = 'Bearer ${globals.accessToken}';
      final response = await Dio()
          .get(
            this.baseUrl + url,
            queryParameters: queryParam,
            options: Options(
                headers: header,
                sendTimeout:
                    globals.timeOut /*,receiveTimeout: globals.timeOut*/),
          )
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            data: isNewFormat ? result : result['data'],
            statusCode: response.statusCode);
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["meta"]["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      var apiResult = await checkUserExist(exception.response);
      if (apiResult != null) return apiResult;
      var newToken = await checkTokenExpired(exception.response);
      if (newToken) {
        return GET(url,
            queryParam: queryParam,
            isNewFormat: isNewFormat,
            isToken: isToken,
            baseUrl: baseUrl);
      }
      try {
        return ApiResult<dynamic>(
            code: exception.response?.data['meta'] != null &&
                    exception.response?.data['meta']['code'] != null
                ? exception.response?.data['meta']['code']
                : exception.response?.data["code"],
            error: exception.response?.data['message'] != null &&
                    (exception.response?.data['message'] as String).isNotEmpty
                ? exception.response?.data['message']
                : exception.response?.data['meta']?['message'] != null &&
                        (exception.response?.data['meta']?['message'] as String)
                            .isNotEmpty
                    ? exception.response?.data['meta']['message']
                    : exception.response?.data['error'] ??
                        LocaleKeys.network_error.tr());
      } catch (ex) {
        return ApiResult(error: LocaleKeys.network_error.tr());
      }
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  Future<ApiResult> PATCH(String url, dynamic body) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[PATCH] ${baseUrl!}$url');
    debugPrint('[PARAMS] $body');
    debugPrint("Bearer ${globals.accessToken}");
    debugPrint("Language ${globals.lang}");

    try {
      final response = await Dio()
          .patch(
            url,
            data: body,
            options: Options(
              headers: {
                'Authorization': 'Bearer ${globals.accessToken}',
                'Content-Type': 'application/json',
                ApiKey.lang: globals.lang
              },
              sendTimeout: globals.timeOut, /* receiveTimeout: globals.timeOut*/
            ),
          )
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            data: result['data'],
            statusCode: response.statusCode,
            message: result['meta']['message'] ?? '');
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["meta"]["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      var apiResult = await checkUserExist(exception.response);
      if (apiResult != null) return apiResult;
      var newToken = await checkTokenExpired(exception.response);
      if (newToken) {
        return PATCH(url, body);
      }
      return ApiResult<dynamic>(
          error: exception.response?.data['meta']['message'] ??
              LocaleKeys.network_error.tr());
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> POST(String url, dynamic body,
      {String baseUrl = '',
      bool isNewFormat = false,
      String token = ''}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[POST] ' + this.baseUrl + url);
    debugPrint("Bearer " + (token.isNotEmpty ? token : globals.accessToken));
    debugPrint('[PARAMS] ' +
        (body is FormData ? "${body.boundary}" : json.encode(body)));
    try {
      var headers = {
        'Authorization':
            'Bearer ${token.isNotEmpty ? token : globals.accessToken}',
        'Content-Type': 'application/json',
        ApiKey.lang: globals.lang
      };
      final response = await Dio()
          .post(this.baseUrl + url,
              data: body is FormData ? body : json.encode(body),
              options: Options(
                headers: headers,
                sendTimeout:
                    globals.timeOut, /*receiveTimeout: globals.timeOut*/
              ))
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            data: isNewFormat ? result : result['data'],
            statusCode: response.statusCode,
            message: result['meta']?['message'] ?? '');
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["meta"]["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response} ${exception.message}');
      debugPrint(
          '============================================================');
      var apiResult = await checkUserExist(exception.response);
      if (apiResult != null) return apiResult;
      var newToken = await checkTokenExpired(exception.response);
      if (newToken)
        return POST(url, body, baseUrl: baseUrl, isNewFormat: isNewFormat);
      try {
        return ApiResult<dynamic>(
            statusCode: exception.response?.statusCode ?? 0,
            error: exception.response?.data != null
                ? (exception.response?.data['message'] != null &&
                        (exception.response?.data['message'] as String)
                            .isNotEmpty
                    ? exception.response?.data['message']
                    : exception.response?.data['meta']?['message'] != null &&
                            (exception.response?.data['meta']?['message']
                                    as String)
                                .isNotEmpty
                        ? exception.response?.data['meta']['message']
                        : exception.response?.data['error'] ??
                            LocaleKeys.network_error.tr())
                : LocaleKeys.network_error.tr());
      } catch (ex) {
        return ApiResult(
            statusCode: exception.response?.statusCode ?? 0,
            error: LocaleKeys.network_error.tr());
      }
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> PUT(String url, dynamic body,
      {String baseUrl = '', bool isNewFormat = false}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    debugPrint('[PUT] ' + baseUrl! + url);
    debugPrint('[PARAMS] ' + body.toString());
    try {
      final response = await Dio()
          .put(url,
              data: body,
              options: Options(
                sendTimeout: globals.timeOut,
                headers: {
                  'Authorization': 'Bearer ${globals.accessToken}',
                  'Content-Type': 'application/json',
                  ApiKey.lang: globals.lang
                },
              ))
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            data: result['data'],
            statusCode: response.statusCode,
            message: result['meta']['message'] ?? '');
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["meta"]["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      var apiResult = await checkUserExist(exception.response);
      if (apiResult != null) return apiResult;
      var newToken = await checkTokenExpired(exception.response);
      if (newToken)
        return PUT(url, body, baseUrl: baseUrl, isNewFormat: isNewFormat);
      return ApiResult<dynamic>(
          error: exception.response?.data['meta']['message'] ??
              LocaleKeys.network_error.tr());
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  // ignore: non_constant_identifier_names
  Future<ApiResult> DELETE(String url, {String baseUrl = ''}) async {
    if (await ConnectionUtils.isConnect() == false) {
      return ApiResult(error: LocaleKeys.network_error.tr());
    }
    debugPrint('============================================================');
    if (kDebugMode) {
      debugPrint('[DELETE] ${baseUrl!}$url');
    }
    try {
      final response = await Dio()
          .delete(url,
              options: Options(sendTimeout: globals.timeOut, headers: {
                'Authorization': 'Bearer ${globals.accessToken}',
                ApiKey.lang: globals.lang
              }))
          .timeout(Duration(seconds: globals.timeOut));
      Logger().d(response.data);
      if ((response.statusCode == 200 || response.statusCode == 201) &&
          response.data != null) {
        var result = response.data;
        return ApiResult<dynamic>(
            data: result['data'],
            statusCode: response.statusCode,
            message: result['meta']['message'] ?? '');
      } else {
        Logger().e(
            'Error ${response.statusCode} - ${response.statusMessage} - ${response.data}');
        var result = response.data;
        return ApiResult<dynamic>(
          error: result["meta"]["message"] ?? response.statusMessage ?? '',
          data: result,
        );
      }
    } on DioError catch (exception) {
      Logger().e('[EXCEPTION] ${exception.response}');
      debugPrint(
          '============================================================');
      var apiResult = await checkUserExist(exception.response);
      if (apiResult != null) return apiResult;
      var isNewToken = await checkTokenExpired(exception.response);
      if (isNewToken) return DELETE(url, baseUrl: baseUrl);
      return ApiResult<dynamic>(
          error: exception.response?.data['meta']['message'] ??
              LocaleKeys.network_error.tr());
    } catch (error) {
      Logger().e('[ERROR] ' + error.toString());
      debugPrint(
          '============================================================');
      return ApiResult<dynamic>(error: LocaleKeys.network_error.tr());
    }
  }

  Future<ApiResult?> checkUserExist(Response? response) async {
    if (!globals.isLogin) return null;
    try {
      if (response?.statusCode == 404 &&
          response?.data['meta']['code'] == 1404 &&
          globals.isLogin) {
        globals.isLogin = false;
        var message = response?.data['meta']['message'];
        toast(message);
        Utils.fireEvent(OpenNewPageEvent(const HomePage(), isReplace: true));
        return ApiResult(error: '');
      }
    } catch (ex) {}

    return null;
  }

  Future<bool> checkTokenExpired(Response? response) async {
    if (response == null) return false;
    try {
      var result = response.data;
      var message = result['exp'] ?? '';
      if (response.statusCode != 401) return false;
      if (message == ConstantKey.TOKEN_EXPIRED && globals.isLogin) {
        var isNewToken = await renewToken();
        if (isNewToken) {
          return true;
        } else {
          if (!globals.isTokenExpired) {
            globals.isTokenExpired = true;
            RouterUtils.pushFromHomeTo(const HomePage(isOpenLoginScreen: true),
                isReplace: true);
            return false;
          }
        }
      }
      return false;
    } catch (ex) {
      return false;
    }
  }

  Future<bool> renewToken() async {
    var isResult = false;
    try {
      var response = await POST('auth/tokens/renew', {
        ApiKey.device_id: globals.deviceId,
        ApiKey.refresh_token: globals.refreshToken,
        ApiKey.login_as: ApiKey.user
      });
      if (response.error == null) {
        var token = response.data['token'] ?? '';
        if (token.isEmpty) return false;
      }
    } catch (ex) {}
    return isResult;
  }
}
