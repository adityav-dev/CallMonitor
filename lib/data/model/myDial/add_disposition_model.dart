class AddDispositionCallLogsModel {
  bool? success;
  DispositionData? data;

  AddDispositionCallLogsModel({this.success, this.data});

  factory AddDispositionCallLogsModel.fromJson(Map<String, dynamic> json) {
    return AddDispositionCallLogsModel(
      success: json['success'],
      data: json['data'] != null ? DispositionData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data?.toJson(),
    };
  }
}

class DispositionData {
  String? clientId;
  String? category;
  String? leadStatus;
  String? phoneNumber;
  String? contactName;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  DispositionData({
    this.clientId,
    this.category,
    this.leadStatus,
    this.phoneNumber,
    this.contactName,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory DispositionData.fromJson(Map<String, dynamic> json) {
    return DispositionData(
      clientId: json['clientId'],
      category: json['category'],
      leadStatus: json['leadStatus'],
      phoneNumber: json['phoneNumber'],
      contactName: json['contactName'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'category': category,
      'leadStatus': leadStatus,
      'phoneNumber': phoneNumber,
      'contactName': contactName,
      '_id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
