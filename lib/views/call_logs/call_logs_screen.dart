import '../../core/app-export.dart';
import '../../widgets/custom_call_logs_widget.dart';
import '../../widgets/loading_widgets.dart';
import 'controller/call_logs_controller.dart';

class CallLogsScreen extends GetView<CallLogsController> {
  const CallLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: CustomAppBar(
        title: 'Call Logs',
        centerTitle: true,
        showBackButton: false,
        onTapBack: () => Get.back(),
      ),
      body: Column(
        children: [
          Obx(() => _buildScrollableTabBar()),

          Expanded(
            child: Obx(() {
              final logs = controller.filteredLogs;
              if (controller.isLoading.value && logs.isEmpty) {
                return const Center(child: LoadingWidget());
              }

              if (logs.isEmpty && !controller.hasMore.value) {
                return const Center(child: NoLogsWidget());
              }

              return RefreshIndicator(
                onRefresh: controller.refreshCallLogs,
                child: ListView.builder(
                  controller: controller.scrollController,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  itemCount: logs.length + (controller.hasMore.value ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == logs.length && controller.hasMore.value) {
                      return const Center(child: LoadingMoreWidget());
                    }

                    final callLog = logs[index];
                    return CallLogItemWidget(
                      callLog: callLog,
                      controller: controller,
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  /// 🔸 Horizontal Scrollable Tab Bar with Color-coded Icons
  Widget _buildScrollableTabBar() {
    final tabs = [
      {'icon': Icons.phone, 'label': 'All', 'color': Colors.blueAccent},
      {
        'icon': Icons.phone_callback,
        'label': 'Incoming',
        'color': Colors.green,
      },
      {
        'icon': Icons.phone_forwarded,
        'label': 'Outgoing',
        'color': Colors.orange,
      },
      {
        'icon': Icons.phone_missed,
        'label': 'Missed',
        'color': Colors.redAccent,
      },
      {'icon': Icons.cancel, 'label': 'Rejected', 'color': Colors.purple},
      {
        'icon': Icons.hourglass_empty,
        'label': 'Never Attended',
        'color': Colors.grey,
      },
    ];

    return Container(
      height: 64,
      color: Colors.white,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final tab = tabs[index];
            final isSelected = controller.selectedTab.value == index;

            return Padding(
              padding: const EdgeInsets.only(right: 32),
              child: _buildTabButton(
                icon: tab['icon'] as IconData,
                label: tab['label'] as String,
                color: tab['color'] as Color,
                index: index,
                isSelected: isSelected,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTabButton({
    required IconData icon,
    required String label,
    required Color color,
    required int index,
    required bool isSelected,
  }) {
    final selectedColor = isSelected ? color : color.withOpacity(0.5);
    final textColor = isSelected ? Colors.black : Colors.grey;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => controller.changeTab(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: selectedColor, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: textColor,
              fontFamily: AppFonts.poppins,
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected)
            Container(
              height: 2.5,
              width: 28,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
    );
  }
}
