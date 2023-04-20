import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatApi {
  final dio = createDio();
  static String apiUrl = "https://chat.localservices.app/";
  final tokenDio = Dio(BaseOptions(baseUrl: apiUrl));

  ChatApi._internal();

  static final _singleton = ChatApi._internal();

  factory ChatApi() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: apiUrl,
      receiveTimeout: Duration(seconds: 15),
      connectTimeout: Duration(seconds: 15),
      sendTimeout: Duration(seconds: 15),
      headers: {'Content-Type': 'application/json'},
    ));

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;
  AppInterceptors(this.dio);

/**
 *  @onRequest part code
 */

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var preferences = await SharedPreferences.getInstance();
    String? apikey = await preferences.getString('apikey');
    String? country_id = await preferences.getString('country_id') ?? "";
    String language = await preferences.getString('SelectedLanguageCode') ?? "";
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    String? deviceId;
    deviceId = '';
    if (!kIsWeb && (Platform.isMacOS || Platform.isAndroid || Platform.isIOS))
      try {
        deviceId = await PlatformDeviceId.getDeviceId;
      } on PlatformException {
        deviceId = '';
      }
    if (!kIsWeb && Platform.isWindows) {
      var build = await deviceInfoPlugin.windowsInfo;
      deviceId = build.deviceId;
    }
    if (apikey != "" && apikey != null) {
      options.headers.addAll({"apikey": apikey});
    }
    options.headers.addAll({'language': language});
    options.headers.addAll({"country_id": country_id});
    options.headers.addAll({"device_id": deviceId!});
    return handler.next(options);
  }

/**
 *  @onResponse part code
 */
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }
/**
 *  @onErrors part code
 */

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw DeadlineExceededException(err.requestOptions);
      case DioErrorType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions, err.response);
          case 401:
            throw UnauthorizedException(err.requestOptions, err.response);
          case 404:
            throw NotFoundException(err.requestOptions, err.response);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
      case DioErrorType.badCertificate:
        break;
      case DioErrorType.connectionError:
        break;
    }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return jsonDecode(response!.toString())["message"];
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Internal Server error, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);
  @override
  String toString() {
    return jsonDecode(response!.toString())["message"];
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r, Response? response)
      : super(requestOptions: r, response: response);

  @override
  String toString() {
    return jsonDecode(response!.toString())["message"];
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
