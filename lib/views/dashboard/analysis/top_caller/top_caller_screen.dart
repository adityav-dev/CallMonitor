import '../../../../core/app-export.dart';
import '../../../../widgets/analytics_widgets/summary_widgets/call_stats_card_widget.dart';
import 'controller/top_caller_controller.dart';

class TopCallerScreen extends GetView<TopCallerController> {
  const TopCallerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String type = args['type'] ?? 'top_caller';
    final data = controller.getDataByType(type);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: CustomAppBar(
        title: type,
        titleStyle: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        showBackButton: true,
        onTapBack: () => Get.back(),
        // No actions (three-dot menu removed)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            CallStatsCard(data: data),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
