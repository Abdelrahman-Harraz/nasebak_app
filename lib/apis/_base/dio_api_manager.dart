import 'dart:developer';
import 'dart:io';

import 'package:nasebak_app/apis/_base/request_form_data_interceptor.dart';
import 'package:nasebak_app/apis/api_keys.dart';
import 'package:nasebak_app/preferences/preferences_manager.dart';
import 'package:nasebak_app/utils/build_type/build_type.dart';
import 'package:dio/dio.dart';
import 'package:firebase_performance_dio/firebase_performance_dio.dart';
import 'package:flutter/material.dart';
import 'package:requests_inspector/requests_inspector.dart';

class DioApiManager {
  final String defaultLanguage = "ar";
  final PreferencesManager preferenceManager;
  final VoidCallback? logOutCallBack;

  //  dio instance to request token
  DioApiManager({required this.preferenceManager, this.logOutCallBack});
  final LogInterceptor _logInterceptor = LogInterceptor(
    responseBody: true,
    requestBody: true,
    error: true,
    logPrint: (obj) {
      log(obj.toString());
    },
  );
  final _performanceInterceptor = DioFirebasePerformanceInterceptor();
  final _requestsInspectorInterceptor = RequestsInspectorInterceptor();

  Dio get dioUnauthorized {
    return DioOptions.dioInstance(options)
      ..interceptors.clear()
      ..interceptors.addAll([
        _performanceInterceptor,
        _requestsInspectorInterceptor,
        _queuedInterceptorsWrapperUnauthorized,
        if (isDebugMode()) ...[_logInterceptor, RequestFormDataInterceptor()],
      ]);
  }

  Dio get dio {
    return DioOptions.dioInstance(options)
      ..interceptors.clear()
      ..interceptors.addAll([
        _performanceInterceptor,
        _requestsInspectorInterceptor,
        _queuedInterceptorsWrapper,
        if (isDebugMode()) ...[_logInterceptor, RequestFormDataInterceptor()],
      ]);
  }

  QueuedInterceptorsWrapper get _queuedInterceptorsWrapper {
    return QueuedInterceptorsWrapper(
      onError: (error, handler) async {
        // Assume 401 stands for token expired
        if (error.response?.statusCode == 401 ||
            error.response?.statusCode == 403) {
          logOutNow();
          return;
        }

        return handler.next(error);
      },
      onRequest: (request, handler) async {
        await _setLanguage(request);
        await _setToken(request);
        return handler.next(request);
      },
    );
  }

  QueuedInterceptorsWrapper get _queuedInterceptorsWrapperUnauthorized {
    return QueuedInterceptorsWrapper(
      onRequest: (request, handler) async {
        await _setLanguage(request);
        return handler.next(request);
      },
    );
  }

  Future<void> logOutNow() async {
    logOutCallBack?.call();
  }

  Future<void> _setToken(RequestOptions request) async {
    final String? token = await preferenceManager.getToken();
    if (token != "") {
      if (request.headers[ApiKeys.authorization] == null) {
        request.headers[ApiKeys.authorization] = '${ApiKeys.keyBearer} $token';
      } else {
        request.headers.remove(ApiKeys.authorization);
      }
    }
  }

  DioOptions get options => DioOptions();

  Future<bool> updateHeaders() async {
    DioOptions.token = await preferenceManager.getToken();
    DioOptions.language = await preferenceManager.getLocale();
    return true;
  }

  Future<void> _setLanguage(RequestOptions request) async {
    final String language =
        await preferenceManager.getLocale() ?? defaultLanguage;
    if (request.headers[ApiKeys.locale] != language) {
      request.headers[ApiKeys.locale] = language;
    }
  }
}

class DioOptions extends BaseOptions {
  @override
  Map<String, dynamic> get headers {
    final Map<String, dynamic> header = {};
    header.putIfAbsent(ApiKeys.locale, () => language);
    header.putIfAbsent(ApiKeys.accept, () => ApiKeys.applicationJson);
    header.putIfAbsent(
      ApiKeys.platform,
      () => Platform.isIOS ? ApiKeys.platformIos : ApiKeys.platformAndroid,
    );

    return header;
  }

  @override
  String get baseUrl => ApiKeys.baseUrl;

  static String? token;
  static String? language;

  static Dio? dio;

  static Dio dioInstance(BaseOptions options) {
    dio ??= Dio(options);
    return dio!;
  }
}
