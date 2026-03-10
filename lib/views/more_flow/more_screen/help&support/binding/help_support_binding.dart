import '../../../../../core/app-export.dart';
import '../controller/help_support_controller.dart';

class HelpSupportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpSupportController());
  }
}
