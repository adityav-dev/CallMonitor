import 'package:get/get.dart';

class BottomBarController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxInt numberClick = 0.obs;
  Rx<DateTime> lastTime = DateTime.now().obs;
  DateTime? _lastTapTime;

  @override
  void onInit() {
    super.onInit();
    currentIndex.value = 0;
  }

  void changeIndex(int index) {
    // Prevent accidental double taps
    final now = DateTime.now();
    if (_lastTapTime != null &&
        now.difference(_lastTapTime!).inMilliseconds < 300) {
      return;
    }
    _lastTapTime = now;
    currentIndex.value = index;
  }

  void resetToHome() {
    changeIndex(0);
  }
}
