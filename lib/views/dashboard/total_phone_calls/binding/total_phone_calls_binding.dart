import 'package:call_monitor/views/dashboard/total_phone_calls/controller/total_phone_call_controller.dart';
import '../../../../core/app-export.dart';

class TotalPhoneCallsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TotalPhoneCallsController());
  }
}
