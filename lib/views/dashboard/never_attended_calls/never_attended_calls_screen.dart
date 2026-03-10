import '../../../core/app-export.dart';
import '../../../widgets/analytics_widgets/filter_header.dart';
import '../../../widgets/analytics_widgets/never_attended_calls_card.dart';
import 'controller/never_attended_calls_controller.dart';

class NeverAttendedCallsScreen extends GetView<NeverAttendedCallsController> {
  const NeverAttendedCallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final type = Get.arguments?['type'] ?? 'never_attended';
    final String title = switch (type) {
      'not_picked' => 'Not Picked by Client',
      _ => 'Never Attended Calls',
    };

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      appBar: CustomAppBar(
        title: title,
        titleStyle: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        showBackButton: true,
        onTapBack: () => Get.back(),
        // No actions
      ),
      body: Column(
        children: [
          // ✅ Reusable Filter Header (same as TotalPhoneCallsScreen)
          Obx(
            () => FilterHeaderWidget(
              selectedRange: controller.selectedFilterRange.value,
              selectedFilter: controller.selectedFilter.value,
              onFilterTap: () => controller.showFilterBottomSheet(context),
            ),
          ),

          // ✅ List of call cards
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.calls.length,
                itemBuilder: (context, index) {
                  final call = controller.calls[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: CallCard(call: call, showSubCalls: index == 0),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
