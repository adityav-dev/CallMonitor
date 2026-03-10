class GetDialReportsModel {
  bool? success;
  DialReportData? data;
  Filter? filter;

  GetDialReportsModel({this.success, this.data, this.filter});

  factory GetDialReportsModel.fromJson(Map<String, dynamic> json) {
    return GetDialReportsModel(
      success: json['success'],
      data: json['data'] != null ? DialReportData.fromJson(json['data']) : null,
      filter: json['filter'] != null ? Filter.fromJson(json['filter']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
      'filter': filter?.toJson(),
    };
  }
}

class DialReportData {
  String? clientId;
  int? totalCalls;
  int? totalConnected;
  int? totalNotConnected;
  int? totalConversationTime;
  int? avgCallDuration;

  DialReportData({
    this.clientId,
    this.totalCalls,
    this.totalConnected,
    this.totalNotConnected,
    this.totalConversationTime,
    this.avgCallDuration,
  });

  factory DialReportData.fromJson(Map<String, dynamic> json) {
    return DialReportData(
      clientId: json['clientId'],
      totalCalls: json['totalCalls'],
      totalConnected: json['totalConnected'],
      totalNotConnected: json['totalNotConnected'],
      totalConversationTime: json['totalConversationTime'],
      avgCallDuration: json['avgCallDuration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'totalCalls': totalCalls,
      'totalConnected': totalConnected,
      'totalNotConnected': totalNotConnected,
      'totalConversationTime': totalConversationTime,
      'avgCallDuration': avgCallDuration,
    };
  }
}

class Filter {
  String? applied;

  Filter({this.applied});

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      applied: json['applied'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'applied': applied,
    };
  }
}
