import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mvvm/data/datasources/local/local_data_source.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/app_config.dart';
import '../../local/hive_storage.dart';
import 'error_handler/api_error.dart';

class DioClient with ApiError {
  LocalDataSource localDataSource;
  final baseApi = AppConfig.instance.apiBaseUrl;

  Dio dio = Dio(BaseOptions(
    baseUrl: AppConfig.instance.apiBaseUrl,
    contentType: 'application/json',
    connectTimeout: 30000,
    sendTimeout: 30000,
    receiveTimeout: 30000,
  ));

  DioClient(this.localDataSource){
    if (!kReleaseMode) {
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
  }

  Future<bool> _lookupInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isEmpty && result[0].rawAddress.isEmpty){
        return false;
      }
      else{
        return true;
      }
    } on SocketException catch (_) {
      return Future.error('internet is off');
    }
  }

  Future<Options> getOptions({String contentType = Headers.jsonContentType}) async {
    final Map<String, dynamic> headers = await _getHeader();
    return Options(headers: headers, contentType: contentType);
  }

  Future<Options> getAuthOptions(String contentType) async {
    final Map<String, dynamic> headers = await _getAuthorizedHeader();
    return Options(headers: headers, contentType: contentType);
  }

  Future<Map<String, String>> _getHeader() async {
    return {
      "content-type": "application/json",
    };
  }

  Future<Map<String, String>> _getAuthorizedHeader() async {
    Map<String, String> header = await _getHeader();
    String? accessToken = await localDataSource.getAccessToken();
    header.addAll({
      "Authorization": "Bearer $accessToken",
    });
    return header;
  }

  Future<Response<dynamic>> dioCall(Future<Response> Function() apiCall) async {
    try {
      return await apiCall();
    } catch (error) {
      throw checkError(error);
    }
  }
}