import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/app-export.dart';
import '../../../../routes/app_routes.dart';

class SplashController extends GetxController with WidgetsBindingObserver {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  bool _isCheckingSession = false;

  @override
  void onInit() async {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    await checkSessionAndNavigate();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_isCheckingSession) {
      checkSessionAndNavigate();
    }
  }

  Future<void> checkSessionAndNavigate() async {
    if (_isCheckingSession) return;
    _isCheckingSession = true;

    try {
      await Future.delayed(const Duration(milliseconds: 1200));

      final String? token = await secureStorage.read(key: Constants.token);
      debugPrint('Splash: token present? ${token != null && token.isNotEmpty}');

      if (token == null || token.isEmpty) {
        debugPrint('Splash: No token -> login');
        Get.offAllNamed(AppRoutes.loginScreen);
        return;
      }

      final String? isLoggedInStr = await secureStorage.read(key: 'isLoggedIn');
      debugPrint('Splash: isLoggedIn=$isLoggedInStr');

      // Simple check: if logged in, go to bottom bar, otherwise login
      if (isLoggedInStr == 'true') {
        debugPrint('Splash: Logged in -> bottom bar');
        Get.offAllNamed(AppRoutes.bottomBarScreen);
      } else {
        debugPrint('Splash: Not logged in -> login');
        Get.offAllNamed(AppRoutes.loginScreen);
      }
    } catch (e, st) {
      debugPrint('Splash: error $e\n$st');
      Get.offAllNamed(AppRoutes.loginScreen);
    } finally {
      _isCheckingSession = false;
    }
  }
}
