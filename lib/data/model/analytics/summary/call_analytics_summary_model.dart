class CallAnalyticsSummaryModel {
  final bool success;
  final CallAnalyticsSummaryData data;

  CallAnalyticsSummaryModel({
    required this.success,
    required this.data,
  });

  factory CallAnalyticsSummaryModel.fromJson(Map<String, dynamic> json) {
    return CallAnalyticsSummaryModel(
      success: json['success'] ?? false,
      data: CallAnalyticsSummaryData.fromJson(json['data'] ?? {}),
    );
  }
}

class CallAnalyticsSummaryData {
  final CallCountData total;
  final CallCountData incoming;
  final CallCountData outgoing;
  final CallCountData missed;
  final CallCountData rejected;
  final CallCountData notPickedByClient;
  final CallCountData neverAttended;

  CallAnalyticsSummaryData({
    required this.total,
    required this.incoming,
    required this.outgoing,
    required this.missed,
    required this.rejected,
    required this.notPickedByClient,
    required this.neverAttended,
  });

  factory CallAnalyticsSummaryData.fromJson(Map<String, dynamic> json) {
    return CallAnalyticsSummaryData(
      total: CallCountData.fromJson(json['total'] ?? {}),
      incoming: CallCountData.fromJson(json['incoming'] ?? {}),
      outgoing: CallCountData.fromJson(json['outgoing'] ?? {}),
      missed: CallCountData.fromJson(json['missed'] ?? {}),
      rejected: CallCountData.fromJson(json['rejected'] ?? {}),
      notPickedByClient: CallCountData.fromJson(json['notPickedByClient'] ?? {}),
      neverAttended: CallCountData.fromJson(json['neverAttended'] ?? {}),
    );
  }
}

class CallCountData {
  final int count;
  final int? durationSeconds;

  CallCountData({
    required this.count,
    this.durationSeconds,
  });

  factory CallCountData.fromJson(Map<String, dynamic> json) {
    return CallCountData(
      count: json['count'] ?? 0,
      durationSeconds: json['durationSeconds'],
    );
  }
}