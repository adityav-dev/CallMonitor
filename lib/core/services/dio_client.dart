import 'package:dio/dio.dart';
import '../utils/request_interceptor.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio _dio;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    _dio = Dio(
      BaseOptions(
        // baseUrl: ApiConstants.baseUrl,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _dio.interceptors.add(RequestInterceptor());
  }

  Dio get dio => _dio; // <-- ✅ use this to access dio
}
