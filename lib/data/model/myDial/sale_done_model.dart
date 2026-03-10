class Sale {
  final String number;
  final String time;
  final String name;

  Sale({required this.number, required this.time, required this.name});
}

class SaleDoneModel {
  bool? success;
  List<Data>? data;
  Filter? filter;

  SaleDoneModel({this.success, this.data, this.filter});

  SaleDoneModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = (json['data'] as List?)
        ?.map((v) => Data.fromJson(v as Map<String, dynamic>))
        .toList();
    filter = json['filter'] != null
        ? Filter.fromJson(json['filter'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['success'] = success;
    if (data != null) {
      result['data'] = data!.map((v) => v.toJson()).toList();
    }
    if (filter != null) {
      result['filter'] = filter!.toJson();
    }
    return result;
  }
}

class Data {
  String? id;
  String? clientId;
  String? category;
  String? leadStatus;
  String? phoneNumber;
  String? contactName;
  String? createdAt;
  String? updatedAt;
  int? v;

  Data({
    this.id,
    this.clientId,
    this.category,
    this.leadStatus,
    this.phoneNumber,
    this.contactName,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    clientId = json['clientId'];
    category = json['category'];
    leadStatus = json['leadStatus'];
    phoneNumber = json['phoneNumber'];
    contactName = json['contactName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['_id'] = id;
    result['clientId'] = clientId;
    result['category'] = category;
    result['leadStatus'] = leadStatus;
    result['phoneNumber'] = phoneNumber;
    result['contactName'] = contactName;
    result['createdAt'] = createdAt;
    result['updatedAt'] = updatedAt;
    result['__v'] = v;
    return result;
  }
}

class Filter {
  String? applied;
  String? startDate;
  String? endDate;

  Filter({this.applied, this.startDate, this.endDate});

  Filter.fromJson(Map<String, dynamic> json) {
    applied = json['applied'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> result = {};
    result['applied'] = applied;
    result['startDate'] = startDate;
    result['endDate'] = endDate;
    return result;
  }
}
