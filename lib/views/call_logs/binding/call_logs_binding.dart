import '../../../core/app-export.dart';
import '../controller/call_logs_controller.dart';

class CallLogsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CallLogsController());
  }
}
