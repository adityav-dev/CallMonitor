import 'dart:math';
import 'package:fl_chart/fl_chart.dart';

import '../../../core/app-export.dart';
import '../../../widgets/analytics_widgets/call_history_item.dart';
import '../../../widgets/analytics_widgets/filter_header.dart';

import 'controller/total_phone_call_controller.dart';

class TotalPhoneCallsScreen extends GetView<TotalPhoneCallsController> {
  const TotalPhoneCallsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CustomAppBar(
        title: 'Total Calls & Duration',
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
          // ✅ Reusable Filter Header
          Obx(
            () => FilterHeaderWidget(
              selectedRange: controller.selectedFilterRange.value,
              selectedFilter: controller.selectedFilter.value,
              onFilterTap: () => controller.showFilterBottomSheet(context),
            ),
          ),

          // Custom Tabs
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(child: Obx(() => _buildTab('Summary', 0))),
                Expanded(child: Obx(() => _buildTab('Call History', 1))),
              ],
            ),
          ),

          // Content
          Expanded(
            child: Obx(() {
              if (controller.selectedTab.value == 0) {
                return const SummaryTab();
              } else {
                return const CallHistoryTab();
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    final isSelected = controller.selectedTab.value == index;
    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            color: isSelected ? Colors.black : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }
}

// ==================== SUMMARY TAB ====================
class SummaryTab extends GetView<TotalPhoneCallsController> {
  const SummaryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),

          // Pie Chart Card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                // Legends with Wrap to prevent overflow
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 6,
                  children: [
                    _buildLegend('Incoming', const Color(0xFF8BC34A)),
                    _buildLegend('Outgoing', const Color(0xFFFF9800)),
                    _buildLegend('Missed', const Color(0xFFE57373)),
                    _buildLegend('Rejected', const Color(0xFF8B0000)),
                  ],
                ),
                const SizedBox(height: 24),

                // Pie Chart
                SizedBox(
                  height: 230,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 45,
                      sectionsSpace: 4,
                      borderData: FlBorderData(show: false),
                      sections: [
                        PieChartSectionData(
                          color: const Color(0xFF8BC34A),
                          value: 11,
                          title: '11%',
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: const Color(0xFFFF9800),
                          value: 82,
                          title: '82%',
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: const Color(0xFFE57373),
                          value: 4,
                          title: '4%',
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: const Color(0xFF8B0000),
                          value: 3,
                          title: '3%',
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Call Statistics Table
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                _buildStatRow(
                  'Calls',
                  'Count',
                  duration: 'Duration',
                  isHeader: true,
                ),
                const Divider(height: 1),
                _buildStatRow(
                  'Incoming',
                  '3',
                  duration: '45m 24s',
                  color: const Color(0xFF8BC34A),
                ),
                _buildStatRow(
                  'Outgoing',
                  '23',
                  duration: '58m 14s',
                  color: const Color(0xFFFF9800),
                ),
                _buildStatRow(
                  'Missed',
                  '1',
                  duration: '-',
                  color: const Color(0xFFE57373),
                ),
                _buildStatRow(
                  'Rejected',
                  '1',
                  duration: '-',
                  color: const Color(0xFF8B0000),
                ),
                SizedBox(height: 8.h),
                const Divider(height: 1, thickness: 2),
                _buildStatRow(
                  'TOTAL',
                  '28',
                  duration: '1h 43m 38s',
                  isBold: true,
                ),
                SizedBox(height: 8.h),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildStatRow(
    String label,
    String calls, {
    String? duration,
    Color? color,
    bool isHeader = false,
    bool isBold = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isHeader
                    ? FontWeight.w500
                    : isBold
                    ? FontWeight.bold
                    : FontWeight.w400,
                color: isHeader ? Colors.black87 : color ?? Colors.black87,
              ),
            ),
          ),
          Expanded(
            child: Text(
              calls,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isHeader || isBold
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
          ),
          Expanded(
            child: Text(
              duration ?? '',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isHeader || isBold
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== CALL HISTORY TAB ====================
class CallHistoryTab extends GetView<TotalPhoneCallsController> {
  const CallHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.callHistoryList.isEmpty) {
        return const Center(
          child: Text(
            'No call history available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        );
      }

      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: controller.callHistoryList.length,
        separatorBuilder: (context, index) =>
            const Divider(height: 1, thickness: 1, color: Color(0xFFE8E8E8)),
        itemBuilder: (context, index) {
          final callItem = controller.callHistoryList[index];
          return CallHistoryListItem(callItem: callItem);
        },
      );
    });
  }
}

// ==================== DONUT CHART PAINTER ====================
class DonutChartPainter extends CustomPainter {
  final double incoming;
  final double outgoing;
  final double missed;
  final double rejected;

  DonutChartPainter({
    required this.incoming,
    required this.outgoing,
    required this.missed,
    required this.rejected,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = 50.0;

    final total = incoming + outgoing + missed + rejected;
    double startAngle = -pi / 2;

    // Draw segments
    _drawSegment(
      canvas,
      center,
      radius,
      strokeWidth,
      startAngle,
      incoming / total * 2 * pi,
      const Color(0xFF8BC34A),
    );
    startAngle += incoming / total * 2 * pi;

    _drawSegment(
      canvas,
      center,
      radius,
      strokeWidth,
      startAngle,
      outgoing / total * 2 * pi,
      const Color(0xFFFF9800),
    );
    startAngle += outgoing / total * 2 * pi;

    _drawSegment(
      canvas,
      center,
      radius,
      strokeWidth,
      startAngle,
      missed / total * 2 * pi,
      const Color(0xFFE57373),
    );
    startAngle += missed / total * 2 * pi;

    _drawSegment(
      canvas,
      center,
      radius,
      strokeWidth,
      startAngle,
      rejected / total * 2 * pi,
      const Color(0xFF8B0000),
    );
  }

  void _drawSegment(
    Canvas canvas,
    Offset center,
    double radius,
    double strokeWidth,
    double startAngle,
    double sweepAngle,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
