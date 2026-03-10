import 'package:get/get.dart';

import '../controller/top_talked_controller.dart';

class TopTalkedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopTalkedController());
  }
}
