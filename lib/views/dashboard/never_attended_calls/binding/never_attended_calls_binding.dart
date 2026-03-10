import 'package:call_monitor/views/dashboard/never_attended_calls/controller/never_attended_calls_controller.dart';
import 'package:get/get.dart';

class NeverAttendedCallsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NeverAttendedCallsController());
  }
}
