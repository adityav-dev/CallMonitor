import 'package:dio/dio.dart' as dio;
import '../../routes/app_routes.dart';
import '../app-export.dart';

class RequestInterceptor extends dio.Interceptor {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  final GetStorage storage = GetStorage();
  final RxBool isRedirecting = false.obs;

  @override
  Future<void> onRequest(
      dio.RequestOptions options,
      dio.RequestInterceptorHandler handler,
      ) async {
    String? authToken = await secureStorage.read(key: Constants.token);

    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
      print('🔐 [RequestInterceptor] Token attached: $authToken');
    } else {
      print('⚠️ [RequestInterceptor] No access token found in secure storage.');
    }

    options.headers['Content-Type'] = 'application/json';
    super.onRequest(options, handler);
  }

  @override
  void onError(
      dio.DioException err,
      dio.ErrorInterceptorHandler handler,
      ) async {
    if (err.response?.statusCode == 401) {
      // await _handleTokenExpiry();
      return handler.reject(err);
    }

    super.onError(err, handler);
  }

  Future<void> _handleTokenExpiry() async {
    if (isRedirecting.value) return;
    isRedirecting.value = true;
    await secureStorage.deleteAll();
    await storage.erase();
    if (Get.currentRoute != AppRoutes.loginScreen) {
      Get.offAllNamed(AppRoutes.loginScreen);
    }

    isRedirecting.value = false;
  }
}
