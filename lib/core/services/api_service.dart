import 'package:dio/dio.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://finwise-api-test.up.railway.app/api/',
    )
  )..interceptors.add(LogInterceptor());
}