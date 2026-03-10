class CallLog {
  final String contactName;
  final String phoneNumber;
  final bool isIncoming;
  final DateTime dateTime;
  final Duration duration;

  CallLog({
    required this.contactName,
    required this.phoneNumber,
    required this.isIncoming,
    required this.dateTime,
    required this.duration,
  });
}