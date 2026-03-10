import 'package:call_monitor/core/app-export.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../../../routes/app_routes.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkConnection();
  }

  Future<void> _checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    print("NetworkResult:${results.toString()}");
    _updateConnectionStatus(results);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    final bool hasConnection = results.any((r) => r != ConnectivityResult.none);

    if (!hasConnection) {
      isConnected.value = false;
      if (Get.currentRoute != AppRoutes.networkScreen) {
        Get.toNamed(AppRoutes.networkScreen);
      }
    } else {
      if (!isConnected.value && Get.currentRoute == AppRoutes.networkScreen) {
        Get.back(); // return to the last screen
      }
      isConnected.value = true;
    }
  }
}
