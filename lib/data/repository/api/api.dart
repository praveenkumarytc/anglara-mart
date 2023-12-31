import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  Dio _dio = Dio();

  API() {
    _dio.options.baseUrl = 'https://fakestoreapi.com';
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get getData => _dio;
}
