import '../../../../core/app-export.dart';
import 'controller/per_call_controller.dart';

class PerCallScreen extends GetView<PerCallController> {
  const PerCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: CustomAppBar(
        title: "Average Call Duration",
        titleStyle: TextStyle(
          fontFamily: AppFonts.poppins,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _DurationPerDayCard(
              numberOfDays: controller.numberOfDays,
              totalDuration: controller.totalDuration,
              avgDuration: controller.avgDuration,
            ),
            const SizedBox(height: 16),
            _DurationPerCallCard(
              incomingCalls: controller.incomingCalls,
              incomingDuration: controller.incomingDuration,
              incomingAvgDuration: controller.incomingAvgDuration,
              outgoingCalls: controller.outgoingCalls,
              outgoingDuration: controller.outgoingDuration,
              outgoingAvgDuration: controller.outgoingAvgDuration,
              totalCalls: controller.totalCalls,
              totalCallsDuration: controller.totalCallsDuration,
              totalCallsAvgDuration: controller.totalCallsAvgDuration,
            ),
          ],
        ),
      ),
    );
  }
}

// --------------------------- Duration per Day Card ---------------------------
class _DurationPerDayCard extends StatelessWidget {
  final int numberOfDays;
  final String totalDuration;
  final String avgDuration;

  const _DurationPerDayCard({
    required this.numberOfDays,
    required this.totalDuration,
    required this.avgDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Average Duration per Day',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              fontFamily: AppFonts.poppins,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),
          _buildDataRow('No of Days', numberOfDays.toString()),
          const SizedBox(height: 10),
          _buildDataRow('Total Duration', totalDuration),
          const SizedBox(height: 10),
          _buildDataRow('Avg. Duration', avgDuration),
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
            fontFamily: AppFonts.poppins,
          ),
        ),
        Flexible(
          child: Text(
            value,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
              fontFamily: AppFonts.poppins,
            ),
          ),
        ),
      ],
    );
  }
}

// --------------------------- Duration per Call Card ---------------------------
class _DurationPerCallCard extends StatelessWidget {
  final int incomingCalls;
  final String incomingDuration;
  final String incomingAvgDuration;
  final int outgoingCalls;
  final String outgoingDuration;
  final String outgoingAvgDuration;
  final int totalCalls;
  final String totalCallsDuration;
  final String totalCallsAvgDuration;

  const _DurationPerCallCard({
    required this.incomingCalls,
    required this.incomingDuration,
    required this.incomingAvgDuration,
    required this.outgoingCalls,
    required this.outgoingDuration,
    required this.outgoingAvgDuration,
    required this.totalCalls,
    required this.totalCallsDuration,
    required this.totalCallsAvgDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Average Duration per Call',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              fontFamily: AppFonts.poppins,
            ),
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: Color(0xFFE0E0E0)),
          const SizedBox(height: 12),

          // Table Header
          Row(
            children: [
              const Expanded(flex: 3, child: SizedBox()),
              Expanded(flex: 2, child: _buildHeaderText('No of Calls')),
              Expanded(flex: 2, child: _buildHeaderText('Duration')),
              Expanded(flex: 2, child: _buildHeaderText('Avg.\nDuration')),
            ],
          ),
          const SizedBox(height: 10),

          _buildCallRow(
            icon: Icons.phone_callback,
            iconColor: const Color(0xFF4CAF50),
            label: 'Incoming',
            labelColor: const Color(0xFF4CAF50),
            noOfCalls: incomingCalls.toString(),
            duration: incomingDuration,
            avgDuration: incomingAvgDuration,
          ),
          const SizedBox(height: 8),
          _buildCallRow(
            icon: Icons.phone_forwarded,
            iconColor: const Color(0xFFFFA726),
            label: 'Outgoing',
            labelColor: const Color(0xFFFFA726),
            noOfCalls: outgoingCalls.toString(),
            duration: outgoingDuration,
            avgDuration: outgoingAvgDuration,
          ),
          const SizedBox(height: 8),
          _buildCallRow(
            icon: null,
            iconColor: Colors.black,
            label: 'Total Calls',
            labelColor: Colors.black87,
            noOfCalls: totalCalls.toString(),
            duration: totalCallsDuration,
            avgDuration: totalCallsAvgDuration,
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        height: 1.3,
        fontFamily: AppFonts.poppins,
      ),
    );
  }

  Widget _buildCallRow({
    IconData? icon,
    required Color iconColor,
    required String label,
    required Color labelColor,
    required String noOfCalls,
    required String duration,
    required String avgDuration,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(icon, color: iconColor, size: 16),
                const SizedBox(width: 6),
              ],
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: labelColor,
                    height: 1.3,
                    fontFamily: AppFonts.poppins,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(flex: 2, child: _buildDataText(noOfCalls)),
        Expanded(flex: 2, child: _buildDataText(duration)),
        Expanded(flex: 2, child: _buildDataText(avgDuration)),
      ],
    );
  }

  Widget _buildDataText(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        height: 1.3,
        fontFamily: AppFonts.poppins,
      ),
    );
  }
}
