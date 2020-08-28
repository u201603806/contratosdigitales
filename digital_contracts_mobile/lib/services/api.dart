import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:digitalcontractsapp/app/globals.dart';
import 'package:digitalcontractsapp/app/locator.dart';
import 'package:digitalcontractsapp/services/storage_service.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:digitalcontractsapp/utils/retry/dio_retry.dart';
import 'package:digitalcontractsapp/utils/token.dart';

@lazySingleton
class Api {
  Dio dio = new Dio();
  final shared = locator<StorageService>();
  final token = new Token();

  Api() {
    dio.options.baseUrl = Globals.apiEndpoint;
    dio.options.connectTimeout = 5000;
    dio.options.sendTimeout = 5000;
    dio.options.receiveTimeout = 20000;
    dio.interceptors.add(RetryInterceptor(
      dio: dio,
      options: RetryOptions(
        retries: 3,
        retryInterval: const Duration(seconds: 5),
      ),
    ));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<dynamic> _get(String method, {Map query}) async {
    Response response = await dio.get(method,
        queryParameters: query,
        options: Options(
          headers: await token.buildHeaders(),
        ));
    return response.data;
  }

  Future<dynamic> _post(String method, Map data, {Map query}) async {
    Response response = await dio.post(method,
        queryParameters: query,
        data: jsonEncode(data),
        options: Options(
          headers: await token.buildHeaders(),
        ));
    return response.data;
  }

  refreshToken() async {
    Map json = await _post('refresh', {}, query: {'email': await shared.getString('email')});
    token.saveToken(json['token']);
    token.saveUserType('user');
    return;
  }

  Future<Map> getLastAppVersionBuild() async => await _get('app-version');

}
