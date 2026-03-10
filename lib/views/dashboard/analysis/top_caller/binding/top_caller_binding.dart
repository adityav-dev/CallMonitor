import '../../../../../core/app-export.dart';
import '../controller/top_caller_controller.dart';

class TopCallerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopCallerController());
  }
}
