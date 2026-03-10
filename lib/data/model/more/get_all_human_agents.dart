class GetAllHumanAgents {
  final bool? success;
  final List<HumanAgent>? data;

  GetAllHumanAgents({
    this.success,
    this.data,
  });

  factory GetAllHumanAgents.fromJson(Map<String, dynamic> json) {
    return GetAllHumanAgents(
      success: json['success'],
      data: json['data'] != null
          ? List<HumanAgent>.from(
              json['data'].map((v) => HumanAgent.fromJson(v)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (data != null) 'data': data!.map((v) => v.toJson()).toList(),
    };
  }
}

class HumanAgent {
  final String? id;
  final String? clientId;
  final String? humanAgentName;
  final String? email;
  final String? mobileNumber;
  final bool? isProfileCompleted;
  final bool? isApproved;
  final List<AgentId>? agentIds;
  final String? createdAt;
  final String? updatedAt;
  final String? type;

  HumanAgent({
    this.id,
    this.clientId,
    this.humanAgentName,
    this.email,
    this.mobileNumber,
    this.isProfileCompleted,
    this.isApproved,
    this.agentIds,
    this.createdAt,
    this.updatedAt,
    this.type,
  });

  factory HumanAgent.fromJson(Map<String, dynamic> json) {
    return HumanAgent(
      id: json['_id'],
      clientId: json['clientId'],
      humanAgentName: json['humanAgentName'],
      email: json['email'],
      mobileNumber: json['mobileNumber'],
      isProfileCompleted: json['isprofileCompleted'],
      isApproved: json['isApproved'],
      agentIds: json['agentIds'] != null
          ? List<AgentId>.from(
              json['agentIds'].map((v) => AgentId.fromJson(v)),
            )
          : null,
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'clientId': clientId,
      'humanAgentName': humanAgentName,
      'email': email,
      'mobileNumber': mobileNumber,
      'isprofileCompleted': isProfileCompleted,
      'isApproved': isApproved,
      if (agentIds != null)
        'agentIds': agentIds!.map((v) => v.toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'type': type,
    };
  }
}

class AgentId {
  final String? id;
  final String? agentName;
  final String? description;

  AgentId({
    this.id,
    this.agentName,
    this.description,
  });

  factory AgentId.fromJson(Map<String, dynamic> json) {
    return AgentId(
      id: json['_id'],
      agentName: json['agentName'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'agentName': agentName,
      'description': description,
    };
  }
}
