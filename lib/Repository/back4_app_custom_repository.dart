import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myfinalapp/Repository/back4_app_interceptor.dart';

class Back4AppCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  Back4AppCustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("BASEURL", fallback: 'API_URL not found');
    _dio.interceptors.add(Back4AppDioInterceptor());
  }
}
