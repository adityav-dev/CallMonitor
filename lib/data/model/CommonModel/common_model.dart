class CommonResponseModel {
  final bool? success;
  final String? message;
  final AgentInfo? agentInfo;

  CommonResponseModel({this.success, this.message, this.agentInfo});

  factory CommonResponseModel.fromJson(Map<String, dynamic> json) {
    return CommonResponseModel(
      success: json['success'],
      message: json['message'],
      agentInfo: json['data'] != null ? AgentInfo.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': agentInfo?.toJson(),
    };
  }
}

class AgentInfo {
  final String? id;
  final String? name;

  AgentInfo({this.id, this.name});

  factory AgentInfo.fromJson(Map<String, dynamic> json) {
    return AgentInfo(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
