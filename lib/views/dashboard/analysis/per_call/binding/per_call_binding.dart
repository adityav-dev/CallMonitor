import '../../../../../core/app-export.dart';
import '../controller/per_call_controller.dart';

class PerCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PerCallController());
  }
}
