class UploadCallLogsRequest {
  final MobileUser mobileUser;
  final List<Contact>? contacts;
  final List<UploadCallLog> callLogs;

  UploadCallLogsRequest({
    required this.mobileUser,
    this.contacts,
    required this.callLogs,
  });

  Map<String, dynamic> toJson() {
    return {
      'mobileUser': mobileUser.toJson(),
      'contacts': contacts?.map((c) => c.toJson()).toList(),
      'callLogs': callLogs.map((c) => c.toJson()).toList(),
    };
  }
}

class MobileUser {
  final String deviceId;
  final String name;
  final String phoneNumber;
  final String email;

  MobileUser({
    required this.deviceId,
    required this.name,
    required this.phoneNumber,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'deviceId': deviceId,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
    };
  }
}

class Contact {
  final String phoneNumber;
  final String? name;
  final String? email;
  final List<String>? tags;
  final Map<String, dynamic>? metadata;

  Contact({
    required this.phoneNumber,
    this.name,
    this.email,
    this.tags,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'name': name,
      'email': email,
      'tags': tags,
      'metadata': metadata,
    };
  }
}

class UploadCallLog {
  final String externalId;
  final String phoneNumber;
  final String? contactName;
  final String direction;
  final String status;
  final String startedAt;
  final String endedAt;
  final String? notes;
  final Map<String, dynamic>? metadata;

  UploadCallLog({
    required this.externalId,
    required this.phoneNumber,
    this.contactName,
    required this.direction,
    required this.status,
    required this.startedAt,
    required this.endedAt,
    this.notes,
    this.metadata,
  });

  Map<String, dynamic> toJson() {
    return {
      'externalId': externalId,
      'phoneNumber': phoneNumber,
      'contactName': contactName,
      'direction': direction,
      'status': status,
      'startedAt': startedAt,
      'endedAt': endedAt,
      'notes': notes,
      'metadata': metadata,
    };
  }
}

class UploadCallLogsResponse {
  final bool success;
  final UploadCallLogsData? data;

  UploadCallLogsResponse({
    required this.success,
    this.data,
  });

  factory UploadCallLogsResponse.fromJson(Map<String, dynamic> json) {
    return UploadCallLogsResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? UploadCallLogsData.fromJson(json['data']) : null,
    );
  }
}

class UploadCallLogsData {
  final String? mobileUserId;
  final int? contactsUpserted;
  final int? callLogsUpserted;

  UploadCallLogsData({
    this.mobileUserId,
    this.contactsUpserted,
    this.callLogsUpserted,
  });

  factory UploadCallLogsData.fromJson(Map<String, dynamic> json) {
    return UploadCallLogsData(
      mobileUserId: json['mobileUserId'],
      contactsUpserted: json['contactsUpserted'],
      callLogsUpserted: json['callLogsUpserted'],
    );
  }
}


