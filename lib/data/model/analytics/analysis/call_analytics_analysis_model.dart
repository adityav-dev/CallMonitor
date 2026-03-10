class CallAnalyticsAnalysisModel {
  final bool success;
  final dynamic data;

  CallAnalyticsAnalysisModel({
    required this.success,
    required this.data,
  });

  factory CallAnalyticsAnalysisModel.fromJson(Map<String, dynamic> json) {
    return CallAnalyticsAnalysisModel(
      success: json['success'] ?? false,
      data: json['data'],
    );
  }
}

// Top Caller Model
class TopCallerItem {
  final String id;
  final int count;
  final int totalDuration;

  TopCallerItem({
    required this.id,
    required this.count,
    required this.totalDuration,
  });

  factory TopCallerItem.fromJson(Map<String, dynamic> json) {
    return TopCallerItem(
      id: json['_id'] ?? '',
      count: json['count'] ?? 0,
      totalDuration: json['totalDuration'] ?? 0,
    );
  }
}

// Longest Call Model
class LongestCallItem {
  final String id;
  final String? phoneNumber;
  final String direction;
  final int durationSeconds;
  final String startedAt;

  LongestCallItem({
    required this.id,
    this.phoneNumber,
    required this.direction,
    required this.durationSeconds,
    required this.startedAt,
  });

  factory LongestCallItem.fromJson(Map<String, dynamic> json) {
    return LongestCallItem(
      id: json['_id'] ?? '',
      phoneNumber: json['phoneNumber'],
      direction: json['direction'] ?? '',
      durationSeconds: json['durationSeconds'] ?? 0,
      startedAt: json['startedAt'] ?? '',
    );
  }
}

// Highest Total Duration Model
class HighestTotalDurationItem {
  final String id;
  final String phoneNumber;
  final int totalDuration;
  final int count;
  final int incomingDuration;
  final int outgoingDuration;
  final int incomingCount;
  final int outgoingCount;

  HighestTotalDurationItem({
    required this.id,
    required this.phoneNumber,
    required this.totalDuration,
    required this.count,
    required this.incomingDuration,
    required this.outgoingDuration,
    required this.incomingCount,
    required this.outgoingCount,
  });

  factory HighestTotalDurationItem.fromJson(Map<String, dynamic> json) {
    return HighestTotalDurationItem(
      id: json['_id'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      totalDuration: json['totalDuration'] ?? 0,
      count: json['count'] ?? 0,
      incomingDuration: json['incomingDuration'] ?? 0,
      outgoingDuration: json['outgoingDuration'] ?? 0,
      incomingCount: json['incomingCount'] ?? 0,
      outgoingCount: json['outgoingCount'] ?? 0,
    );
  }
}

// Average Duration Model
class AverageDurationModel {
  final PerCallData perCall;
  final List<PerDirectionData> perCallByDirection;
  final List<PerDayData> perDay;

  AverageDurationModel({
    required this.perCall,
    required this.perCallByDirection,
    required this.perDay,
  });

  factory AverageDurationModel.fromJson(Map<String, dynamic> json) {
    return AverageDurationModel(
      perCall: PerCallData.fromJson(json['perCall'] ?? {}),
      perCallByDirection: (json['perCallByDirection'] as List<dynamic>?)
          ?.map((e) => PerDirectionData.fromJson(e))
          .toList() ?? [],
      perDay: (json['perDay'] as List<dynamic>?)
          ?.map((e) => PerDayData.fromJson(e))
          .toList() ?? [],
    );
  }
}

class PerCallData {
  final double avgDuration;
  final int count;

  PerCallData({
    required this.avgDuration,
    required this.count,
  });

  factory PerCallData.fromJson(Map<String, dynamic> json) {
    return PerCallData(
      avgDuration: (json['avgDuration'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }
}

class PerDirectionData {
  final String id;
  final double avgDuration;
  final int count;
  final int total;

  PerDirectionData({
    required this.id,
    required this.avgDuration,
    required this.count,
    required this.total,
  });

  factory PerDirectionData.fromJson(Map<String, dynamic> json) {
    return PerDirectionData(
      id: json['_id'] ?? '',
      avgDuration: (json['avgDuration'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
    );
  }
}

class PerDayData {
  final String day;
  final double avgDuration;

  PerDayData({
    required this.day,
    required this.avgDuration,
  });

  factory PerDayData.fromJson(Map<String, dynamic> json) {
    return PerDayData(
      day: json['day'] ?? '',
      avgDuration: (json['avgDuration'] ?? 0).toDouble(),
    );
  }
}

// Top 10 Frequent/Duration Models
class Top10FrequentModel {
  final List<Top10Item> all;
  final List<Top10Item> incoming;
  final List<Top10Item> outgoing;

  Top10FrequentModel({
    required this.all,
    required this.incoming,
    required this.outgoing,
  });

  factory Top10FrequentModel.fromJson(Map<String, dynamic> json) {
    return Top10FrequentModel(
      all: (json['all'] as List<dynamic>?)
          ?.map((e) => Top10Item.fromJson(e))
          .toList() ?? [],
      incoming: (json['incoming'] as List<dynamic>?)
          ?.map((e) => Top10Item.fromJson(e))
          .toList() ?? [],
      outgoing: (json['outgoing'] as List<dynamic>?)
          ?.map((e) => Top10Item.fromJson(e))
          .toList() ?? [],
    );
  }
}

class Top10Item {
  final String id;
  final int count;
  final int? totalDuration;

  Top10Item({
    required this.id,
    required this.count,
    this.totalDuration,
  });

  factory Top10Item.fromJson(Map<String, dynamic> json) {
    return Top10Item(
      id: json['_id'] ?? '',
      count: json['count'] ?? 0,
      totalDuration: json['totalDuration'],
    );
  }
}



// Call Log Detail Model
class CallLogDetailModel {
  final bool success;
  final CallLogDetailData data;

  CallLogDetailModel({
    required this.success,
    required this.data,
  });

  factory CallLogDetailModel.fromJson(Map<String, dynamic> json) {
    return CallLogDetailModel(
      success: json['success'] ?? false,
      data: CallLogDetailData.fromJson(json['data'] ?? {}),
    );
  }
}

class CallLogDetailData {
  final String id;
  final String phoneNumber;
  final String direction;
  final int durationSeconds;
  final String startedAt;
  final CallLogContact? contact;

  CallLogDetailData({
    required this.id,
    required this.phoneNumber,
    required this.direction,
    required this.durationSeconds,
    required this.startedAt,
    this.contact,
  });

  factory CallLogDetailData.fromJson(Map<String, dynamic> json) {
    return CallLogDetailData(
      id: json['_id'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      direction: json['direction'] ?? '',
      durationSeconds: json['durationSeconds'] ?? 0,
      startedAt: json['startedAt'] ?? '',
      contact: json['contact'] != null ? CallLogContact.fromJson(json['contact']) : null,
    );
  }
}

class CallLogContact {
  final String name;
  final String phoneNumber;

  CallLogContact({
    required this.name,
    required this.phoneNumber,
  });

  factory CallLogContact.fromJson(Map<String, dynamic> json) {
    return CallLogContact(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }
}