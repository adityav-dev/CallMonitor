import 'package:call_monitor/core/app-export.dart';
import '../../../widgets/analytics_widgets/call_history_item.dart';
import 'controller/incoming_calls_controller.dart';

class IncomingCallsScreen extends GetView<IncomingCallsController> {
  const IncomingCallsScreen({super.key});

  String _getScreenTitle(String type) {
    switch (type) {
      case 'incoming':
        return 'Incoming Calls';
      case 'outgoing':
        return 'Outgoing Calls';
      case 'missed':
        return 'Missed Calls';
      case 'rejected':
        return 'Rejected Calls';
      default:
        return 'Calls';
    }
  }

  @override
  Widget build(BuildContext context) {
    final String type = Get.arguments?['type'] ?? 'incoming';
    final title = _getScreenTitle(type);

    // Load data based on type
    controller.loadCalls(type);

    return Scaffold(
      appBar: CustomAppBar(
        title: title,
        titleStyle: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        showBackButton: true,
        onTapBack: () {
          Get.back();
        },
      ),
      body: Obx(() {
        final calls = controller.filteredCalls;

        if (calls.isEmpty) {
          return Center(
            child: Text(
              'No $title found',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
          );
        }

        return ListView.separated(
          itemCount: calls.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) {
            return CallHistoryListItem(callItem: calls[index]);
          },
        );
      }),
    );
  }
}
