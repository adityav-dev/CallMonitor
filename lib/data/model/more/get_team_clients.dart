class GetTeamClients {
  final bool? success;
  final List<Association>? associations;

  GetTeamClients({
    this.success,
    this.associations,
  });

  factory GetTeamClients.fromJson(Map<String, dynamic> json) {
    return GetTeamClients(
      success: json['success'],
      associations: json['associations'] != null
          ? List<Association>.from(
              json['associations'].map((v) => Association.fromJson(v)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      if (associations != null)
        'associations': associations!.map((v) => v.toJson()).toList(),
    };
  }
}

class Association {
  final String? humanAgentId;
  final String? clientId;
  final String? clientUserId;
  final String? clientName;
  final bool? isApproved;
  final bool? isProfileCompleted;
  final String? type;

  Association({
    this.humanAgentId,
    this.clientId,
    this.clientUserId,
    this.clientName,
    this.isApproved,
    this.isProfileCompleted,
    this.type,
  });

  factory Association.fromJson(Map<String, dynamic> json) {
    return Association(
      humanAgentId: json['humanAgentId'],
      clientId: json['clientId'],
      clientUserId: json['clientUserId'],
      clientName: json['clientName'],
      isApproved: json['isApproved'],
      isProfileCompleted: json['isprofileCompleted'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'humanAgentId': humanAgentId,
      'clientId': clientId,
      'clientUserId': clientUserId,
      'clientName': clientName,
      'isApproved': isApproved,
      'isprofileCompleted': isProfileCompleted,
      'type': type,
    };
  }
}
