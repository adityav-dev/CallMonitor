class CallStatistics {
  final int totalCalls;
  final int totalConnected;
  final int totalNotConnected;
  final double avgCallDuration;
  final double totalConversationTime;

  CallStatistics({
    required this.totalCalls,
    required this.totalConnected,
    required this.totalNotConnected,
    required this.avgCallDuration,
    required this.totalConversationTime,
  });

  factory CallStatistics.fromJson(Map<String, dynamic> json) {
    return CallStatistics(
      totalCalls: json['totalCalls'] ?? 0,
      totalConnected: json['totalConnected'] ?? 0,
      totalNotConnected: json['totalNotConnected'] ?? 0,
      avgCallDuration: (json['avgCallDuration'] ?? 0).toDouble(),
      totalConversationTime: (json['totalConversationTime'] ?? 0).toDouble(),
    );
  }
}