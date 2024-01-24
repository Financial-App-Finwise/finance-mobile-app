import 'package:dio/dio.dart';

class ApiService {
  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://finwise-api-test.up.railway.app/',
    )
  )..interceptors.add(LogInterceptor());
}