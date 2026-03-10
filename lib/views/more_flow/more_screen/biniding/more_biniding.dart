import '../../../../core/app-export.dart';
import '../controller/more_controller.dart';

class MoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoreController());
  }
}
