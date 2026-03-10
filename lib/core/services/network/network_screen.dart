import '../../app-export.dart';
import 'network_controller.dart';

class NetworkScreen extends GetView<NetworkController> {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 40, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              "No Internet Connection",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                fontFamily: AppFonts.poppins,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Please check your network settings.",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                fontFamily: AppFonts.poppins,
              ),
            ),
            const SizedBox(height: 24),
            Obx(() {
              return ElevatedButton(
                onPressed: controller.isConnected.value
                    ? () => Get.back()
                    : null,
                child: const Text("Retry"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
