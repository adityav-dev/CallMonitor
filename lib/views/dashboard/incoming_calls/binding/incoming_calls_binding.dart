import 'package:call_monitor/core/app-export.dart';
import 'package:call_monitor/views/dashboard/incoming_calls/controller/incoming_calls_controller.dart';

class IncomingCallsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IncomingCallsController());
  }
}
