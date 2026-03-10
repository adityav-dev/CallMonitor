// data/model/myDial/call_logs_filter_model.dart
class CallLogsFilterResponse {
  final bool success;
  final CallLogsFilterData data;

  CallLogsFilterResponse({required this.success, required this.data});

  factory CallLogsFilterResponse.fromJson(Map<String, dynamic> json) {
    return CallLogsFilterResponse(
      success: json['success'] ?? false,
      data: CallLogsFilterData.fromJson(json['data'] ?? {}),
    );
  }
}

class CallLogsFilterData {
  final List<CallLogSimple> items;
  final int total;

  CallLogsFilterData({required this.items, required this.total});

  factory CallLogsFilterData.fromJson(Map<String, dynamic> json) {
    return CallLogsFilterData(
      items: (json['items'] as List<dynamic>)
          .map((e) => CallLogSimple.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] ?? 0,
    );
  }
}

class CallLogSimple {
  final String id;            // <-- Mongo _id
  final String phoneNumber;
  final String direction;
  final String status;
  final int durationSeconds;
  final String startedAt;

  CallLogSimple({
    required this.id,
    required this.phoneNumber,
    required this.direction,
    required this.status,
    required this.durationSeconds,
    required this.startedAt,
  });

  factory CallLogSimple.fromJson(Map<String, dynamic> json) {
    return CallLogSimple(
      id: json['_id'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      direction: json['direction'] ?? '',
      status: json['status'] ?? '',
      durationSeconds: json['durationSeconds'] ?? 0,
      startedAt: json['startedAt'] ?? '',
    );
  }
}