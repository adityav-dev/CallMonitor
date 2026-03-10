import '../../../../../core/app-export.dart';
import '../../../../../data/model/analysis_models/call_stats_model.dart';

class TopCallerController extends GetxController {
  // Static data for Top Caller
  String getTitleByType(String type) {
    switch (type) {
      case 'longest_call':
        return 'Longest Call';
      case 'highest_duration':
        return 'Highest Total Call Duration';
      default:
        return 'Top Caller';
    }
  }

  CallStatsModel getDataByType(String type) {
    switch (type) {
      case 'longest_call':
        return CallStatsModel(
          name: 'Ankur',
          phoneNumber: '+918604579654',
          profileImage: null,
          stats: [
            CallStatItem(
              icon: Icons.phone_android,
              label: 'Phone Number',
              value: '+918604579654',
              iconColor: Colors.grey[700],
            ),
            CallStatItem(
              icon: Icons.calendar_today,
              label: 'Date',
              value: '31 Oct 2025',
              iconColor: Colors.grey[700],
            ),
            CallStatItem(
              icon: Icons.access_time,
              label: 'Call Time',
              value: '09:21 PM',
              iconColor: Colors.grey[700],
            ),
            CallStatItem(
              icon: Icons.call_received,
              label: 'Call Type',
              value: 'INCOMING',
              iconColor: const Color(0xFF8BC34A),
            ),
            CallStatItem(
              icon: Icons.timer,
              label: 'Duration',
              value: '41m 35s',
              iconColor: const Color(0xFF42A5F5),
            ),
          ],
        );

      case 'highest_duration':
        return CallStatsModel(
          name: 'Ayushman',
          phoneNumber: '+918604579654',
          profileImage: null,
          stats: [
            CallStatItem(
              icon: Icons.phone_android,
              label: 'Phone Number',
              value: '+918604579654',
              iconColor: Colors.grey[700],
            ),
            CallStatItem(
              icon: Icons.timer,
              label: 'Total Duration',
              value: '1h 4m 14s',
              iconColor: const Color(0xFF42A5F5),
            ),
            CallStatItem(
              icon: Icons.call_received,
              label: 'Total Incoming Calls',
              value: '41m 35s',
              iconColor: const Color(0xFF8BC34A),
            ),
            CallStatItem(
              icon: Icons.call_made,
              label: 'Total Outgoing Calls',
              value: '22m 39s',
              iconColor: const Color(0xFFFFA726),
            ),
            CallStatItem(
              icon: Icons.call,
              label: 'Total Calls',
              value: '6',
              iconColor: Colors.grey[700],
            ),
          ],
        );

      default: // top_caller
        return CallStatsModel(
          name: 'Rahul',
          phoneNumber: '+918604579654',
          profileImage: null,
          stats: [
            CallStatItem(
              icon: Icons.call,
              label: 'Total Calls',
              value: '6',
              iconColor: Colors.grey[700],
            ),
            CallStatItem(
              icon: Icons.call_received,
              label: 'Total Incoming Calls',
              value: '1',
              iconColor: const Color(0xFF8BC34A),
            ),
            CallStatItem(
              icon: Icons.call_made,
              label: 'Total Outgoing Calls',
              value: '5',
              iconColor: const Color(0xFFFFA726),
            ),
            CallStatItem(
              icon: Icons.call_missed,
              label: 'Total Missed Calls',
              value: '0',
              iconColor: const Color(0xFFEF5350),
            ),
            CallStatItem(
              icon: Icons.block,
              label: 'Total Rejected Calls',
              value: '0',
              iconColor: const Color(0xFFE53935),
            ),
            CallStatItem(
              icon: Icons.timer,
              label: 'Duration',
              value: '1h 4m 14s',
              iconColor: const Color(0xFF42A5F5),
            ),
          ],
        );
    }
  }
}
