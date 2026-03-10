enum CallType { incoming, outgoing, missed, rejected }

class CallHistoryItem {
  final String name;
  final String phoneNumber;
  final String date;
  final String time;
  final String duration; // ✅ Added this field
  final CallType callType;

  CallHistoryItem({
    required this.name,
    required this.phoneNumber,
    required this.date,
    required this.time,
    required this.duration, // ✅ Added this parameter
    required this.callType,
  });
}
