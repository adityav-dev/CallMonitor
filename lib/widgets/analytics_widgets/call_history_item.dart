import '../../core/app-export.dart';
import '../../data/model/analytics_model/call_history_model.dart';
import '../../views/dashboard/total_phone_calls/controller/total_phone_call_controller.dart';

class CallHistoryListItem extends StatelessWidget {
  final CallHistoryItem callItem;

  const CallHistoryListItem({super.key, required this.callItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.person, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),

          // Name & Number
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  callItem.name.isNotEmpty ? callItem.name : 'Unknown',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  callItem.phoneNumber,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Date & Time
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  callItem.date,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  callItem.time,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Call Type Icon
          Icon(
            _getCallIcon(callItem.callType),
            color: _getCallColor(callItem.callType),
            size: 22,
          ),
        ],
      ),
    );
  }

  /// Returns appropriate icon for call type enum
  IconData _getCallIcon(CallType type) {
    switch (type) {
      case CallType.incoming:
        return Icons.call_received;
      case CallType.outgoing:
        return Icons.call_made;
      case CallType.missed:
        return Icons.call_missed;
      case CallType.rejected:
        return Icons.call_end;
      default:
        return Icons.call;
    }
  }

  /// Returns color for each call type
  Color _getCallColor(CallType type) {
    switch (type) {
      case CallType.incoming:
        return Colors.green;
      case CallType.outgoing:
        return Colors.blue;
      case CallType.missed:
        return Colors.red;
      case CallType.rejected:
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
