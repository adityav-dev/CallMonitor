import 'package:call_monitor/views/contacts/controller/contacts_controller.dart';
import 'package:call_monitor/views/more_flow/more_screen/controller/more_controller.dart';

import '../../../../core/app-export.dart';
import '../../call_logs/controller/call_logs_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../controller/bottom_bar_controller.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomBarController());
    Get.lazyPut(() => DashboardController()); // Uncomment and keep
    Get.lazyPut<CallLogsController>(() => CallLogsController());
    Get.lazyPut<ContactsController>(() => ContactsController());
    Get.lazyPut<MoreController>(() => MoreController());
  }
}
